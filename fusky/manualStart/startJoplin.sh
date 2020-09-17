#!/bin/bash


. /home/fusky/manualEnv/clash_proxy
logFile="/home/fusky/manualStart/log/joplin$(date +%Y%m%d)"
nohup /home/fusky/.joplin/Joplin.AppImage >>${logFile} 2>&1 &

