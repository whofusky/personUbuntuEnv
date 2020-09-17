#!/bin/bash
#
###############################################################################
#author:fushikai
#Time:  2020-08-27_20:13
#Dsc:   judge clash is running,if not runing and to running 
#
###############################################################################

tprofile="/root/.profile"
if [ -e "${tprofile}" ];then
       . ${tprofile}  >/dev/null 2>&1
fi       

logDir=/home/fusky/log
if [ ! -d "${logDir}" ];then
	mkdir -p ${logDir}
	chown -R fusky:fusky ${logDir}
fi

rfname="clash"
tYMD="$(date +%Y%m%d)"

allShName="$0"
shName=${allShName##*/}
preShName=${shName%.*}
#echo "preShName=[${preShName}]"

shLog="${logDir}/${preShName}_${tYMD}.log"
startLog="${logDir}/${rfname}_start.log"
outputLog="${logDir}/${rfname}_${tYMD}.log"

tbin="/usr/local/bin/${rfname}"
tcfgDir=/etc/clash

rpidof=/usr/bin/pidof

function chgOwnTofusky()
{
	if [ $# -lt 1 ];then
		return 1
	fi
	local tFile="$1"
	if [ ! -e "${tFile}" ];then
		return 0
	fi
	local uname=$(stat -c %U ${tFile})
	if [ "${uname}" != "fusky" ];then
		chown -R fusky:fusky ${tFile}
	fi
	return 0
}

num=$(${rpidof} -x ${allShName} 2>/dev/null|wc -l)
if [ ${num} -gt 1 ];then

	echo "$(date +%Y-%m-%d_%H:%M:%S.%N): shell file [ ${allShName} ]  is alreaday running!">>${shLog}
	chgOwnTofusky ${shLog}
	exit 1
fi

num=$(${rpidof} ${rfname} 2>/dev/null|wc -l)
#echo "num=[${num}]"
if [ ${num} -gt 0 ];then
	#echo "$(date +%Y-%m-%d_%H:%M:%S.%N): bin file [ ${rfname} ]  is alreaday running!">>${shLog}
	#chgOwnTofusky ${shLog}
	exit 0
fi


if [ ! -e "${tbin}" ];then
	echo "$(date +%Y-%m-%d_%H:%M:%S.%N): file [ ${tbin} ] not exist!">>${shLog}
	chgOwnTofusky ${shLog}
	exit 1
fi
if [ ! -d "${tcfgDir}" ];then
	echo "$(date +%Y-%m-%d_%H:%M:%S.%N): dir [ ${tbin} ] not exist!">>${shLog}
	chgOwnTofusky ${shLog}
	exit 1
fi

nohup ${tbin} -d ${tcfgDir} >>${outputLog} 2>&1 &
chgOwnTofusky ${outputLog}

echo "$(date +%Y-%m-%d_%H:%M:%S.%N): [ ${tbin} ] start to runing!">>${startLog}
chgOwnTofusky ${startLog}

exit 0


