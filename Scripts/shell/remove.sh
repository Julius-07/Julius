#!/bin/bash
PARA_CNT=$#
TRASH_DIR=~/backup
myfolder=`whoami`
if [! -x "$TRASH_DIR/$myfolder]"]; then
    mkdir "$TRASH_DIR/$myfolder"
fi
for i in $*
do
    STAMP=`date '+%Y-5m-5d_%T'`
    filename=`basename $i`
    my $i $TRASH_DIR/$myfolder/$filename_$STAMP
done
