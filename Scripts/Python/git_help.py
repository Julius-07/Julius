#!/usr/bin/python3.8

##--------------------------------------------------------------------------------------------------
##  git_help.py
##  Auther: zhujintao
##  Edition: V1.0: Frist version
##  Description:
##  Note:
##      1): Support git pull, add tag, delete tag and check status
##--------------------------------------------------------------------------------------------------


import os
import argparse
import re

IP_PATH = ['CHIP_TOP']

# parse cmd line
parser = argparse.ArgumentParser()
parser.add_argument("-pull"    , dest="pull"    , action="store", required=False, help="git pull design")
parser.add_argument("-status"  , dest="status"  , action="store", required=False, help="git check status")
parser.add_argument("-tag"     , dest="tag"     , action="store", required=False, help="git add tag")
parser.add_argument("-tag_del" , dest="tag_del" , action="store", required=False, help="git delete tag")

args = parser.parse_args()

# process command
if (args.pull != None):
    if(args.pull == "DE"):
        print("Pull all design")
        for subdir in os.listdir():
            if re.match(r"design", subdir):
                os.chdir("{subdir}".format(subdir=subdir))
                os.system("git checkout master")
                os.system("git pull")
                os.chdir("..")
    elif(args.pull == "DV"):
        print("Pull all verification environment")
        for subdir in os.listdir():
            if re.match(r"verification", subdir):
                os.chdir("{subdir}".format(subdir=subdir))
                os.system("git checkout master")
                os.system("git pull")
                os.chdir("..")
    else:
        print("Error: Not find pull target")
elif(args.status != None):
    for subdir in os.listdir():
        if re.match(r"design", subdir):
            os.chdir("{subdir}".format(subdir=subdir))
            os.system("pwd")
            os.system("git status")
            os.chdir("..")
elif(args.tag != None):
    for ip_path in IP_PATH:
        os.chdir(os.getenv(ip_path))
        os.system("pwd")
        os.system("git tag {tag_name}".format(tag_name=args.tag))
        os.system("git push --tag")
elif(args.tag != None):
    for ip_path in IP_PATH:
        os.chdir(os.getenv(ip_path))
        os.system("pwd")
        os.system("git tag -d {tag_name}".format(tag_name=args.tag_del))
        os.system("git push origin :refs/tags/{tag_name}".format(tag_name=args.tag_del))
else:
    print("Error: Not find valid command")
