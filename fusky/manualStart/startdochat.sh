#!/bin/bash


#. /home/fusky/manualEnv/clash_proxy
logFile="/home/fusky/manualStart/log/dochat$(date +%Y%m%d)"
nohup /home/fusky/manualStart/dochat.sh >>${logFile} 2>&1 &


