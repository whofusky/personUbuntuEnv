#!/bin/bash


. /home/fusky/manualEnv/clash_proxy
logFile="/home/fusky/manualStart/log/chrome$(date +%Y%m%d)"
nohup google-chrome >>${logFile} 2>&1 &

