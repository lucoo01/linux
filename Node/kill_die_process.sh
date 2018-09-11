pids=`ps aux | grep /root/soft/docker/  | grep -v grep | awk '{print $2}'`
for x in $pids;do
	times=`ps -p $x -o etimes=`
	if [ $[$times] -gt 250 ];then
		kill -9 $x;
		echo "$x is killed!!";
	fi
done
