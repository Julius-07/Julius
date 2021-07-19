#!/usr/bin/python3.8


##--------------------------------------------------------------------------------------------------
##  regr.py
##  Auther: zhujintao
##  Edition: V1.0: Frist version
##  Description: VCS regression script
##  Note:
##      1) regr.py ../tc/xxxx.sv NUM; "NUM" is repeat number
##      2) Just support VCS
#3      3) must be execute in "xxxx" path
##--------------------------------------------------------------------------------------------------

import sys
import os
import re
import random
import time

## get argv
TC_PKG  = sys.argv[1]
RUN_NUM = int(sys.argv[2])

## vcs option
cov_opt = "line+cond+fsm+branch+assert+tgl"

tc_pkg_file  = open(TC_PKG, "r")
tc_pkg_lines = tc_pkg_file.readlines()


##--------------------------------------------------------------------------------------------------
## get test case name
##--------------------------------------------------------------------------------------------------
## create regression log
DATE = time.strftime("%Y%m%d")
PWD  = os.path.abspath(os.curdir)
regr_log = open("{PWD}/xxxx/regr_sum_{DATE}.log".format(PWD=PWD, DATE=DATE), "a")

for line in tc_pkg_lines:
    TC_LIST = []
    ##if re.match(r" *\/\/", line):
    ##    print("remove comment")
    ##elif re.search("base_test", line):
    ##    print("remove base test case")
    ##elif re.search("(include *\")(\w*)(\.sv\")", line):
    if re.search("(include *\")(\w*)(\.sv\")", line):
        tc_name = re.search("(\w*)(\.sv\")", line).group(1)
        TC_LIST.append(tc_name)
        os.system("mkdir -p {PWD}/regression/{tc_name}".format(PWD=PWD, tc_name=tc_name))
        os.chdir(r"{PWD}/regression/{tc_name}".format(PWD=PWD, tc_name=tc_name))
        print("test case name is", tc_name)
        regr_log.write("//------------------------------------------------------------")
        regr_log.write("TEST CASE is {tc_name}".format(tc_name=tc_name))
        regr_log.write("//------------------------------------------------------------")
        for num in range(0, RUN_NUM):
            SEED = random.randint(0,80000000)
            print("RUN  NUM is ", num)
            pring("RUN SEED is ", SEED)
            os.system("../simv +vcs+lic+wait +UVM+TEST_NAME={tc_name} +ntb_random_seed={SEED} -ucli -i ../waive.tcl +UVM+VERBOSITY=UVM_NONE +{tc_name} -cm {cov_opt} -cm_dir {tc_name}/{SEED} -l regression.log".format(PWD=PWD, tc_name=tc_name, SEED=SEED, cov_opt=cov_opt))
            sim_log=open("regression.log", "r")
            sim_log_file=sim_log.readlines()
            regr_log.write.write("SEED is {SEED}\n".format(SEED=SEED))
            for log in sim_log_file:
                if re.match(r"UVM_ERROR :", log):
                    regr_log.write(log)
                elif re.match(r"UVM_FATAL :", log):
                    regr_log.write(log)
            sim_log.close()
        regr_log.write("//------------------------------------------------------------\n\n\n\n")

tc_pkg_file.close()
regr_log.close()

