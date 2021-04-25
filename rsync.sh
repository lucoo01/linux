#!/bin/bash
# rsync开启，停止和重启
# sh rsync.sh start
# sh rsync.sh stop
# sh rsync.sh restart

. /etc/init.d/functions
 
function usage() {
    echo $"usage:$0 {start|stop|restart}"
    exit 1
}
 
function start() {
    rsync --daemon
    sleep 1
    if [ `netstat -antlpe | grep rsync | wc -l` -ge 1 ];then
        action "rsyncd is started." /bin/true
    else
        action "rsyncd is started." /bin/false
    fi
}
 
function stop() {
    killall rsync &> /dev/null
    sleep 1
    if [ `netstat -antlpe | grep rsync | wc -l` -eq 0 ];then
        action "rsyncd is stoped." /bin/true
    else
        action "rsyncd is stoped." /bin/false
    fi
}
 
function main() {
    if [ $# -ne 1 ];then
        usage $0
    fi
    case $1 in
        start)
        start
	;;
	stop)
	stop
	;;
	restart)
	stop
	start
	;;
	*)
	usage $0
	;;
    esac
}
 
main $*
