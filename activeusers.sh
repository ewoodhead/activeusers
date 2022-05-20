#/bin/sh
ps -ef | tail -n +2 | awk '{print $1}' | sort | uniq
