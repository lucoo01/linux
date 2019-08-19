docker ps -a | grep Exited | grep -v grep|awk '{print $1}'|xargs docker rm
