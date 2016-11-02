#!/bin/bash
# 生成 svn 状态信息
svn_info_txt=`svn info`; ret_info=$?
unset svn_info_txt
if [ $ret_info -eq 0 ]
then {		
    svn_version=`svn info | grep Revision | grep -o '[0-9]\+'`;
    svn log -r$svn_version > svn_log; ret_log=$?
    if [ $ret_log -eq 0 ]
    then {
        svn_log=`sed '1d;2d;3d;$d' svn_log | tr '\n' ' '`;
    } fi
    rm svn_log -f
} fi
#svn_diff=`svn diff`; ret_diff=$?
#if [ $ret_diff -eq 0 ]
#then {
#    svn_log=`sed '1d;2d;3d;$d' svn_log`;
#} fi
sf_author=$LOGNAME
sf_date=`date -R`

# 处理生成的状态信息
echo "#define OMX_COMPILE_INFO      \"author:  $sf_author time: $sf_date version: ${svn_version:-0}\"" > ./include/rockchip/svn_info.h

