#!/bin/bash

# 测试lbaas的性能，即负载均衡算法统计
totalnum=10
num=0
totrq=(0 0 0 0)
timerq=(0 0 0 0)
speed=(0 0 0 0)
timestart=0
timeend=0
temptime=0

while [ $num -lt $totalnum ]
do
    num=`expr $num + 1`
	echo "$num次request"

    timestart=$(date +%s.%N)
    RESULT='server1'
	sleep 0.5
	timeend=$(date +%s.%N)
    # echo $RESULT   
    case $RESULT in
        'server1') 
		    totrq[0]=`expr ${totrq[0]} + 1`
			temptime=`echo "$timeend - $timestart"|bc`
			timerq[0]=`echo "${timerq[0]} + $temptime"|bc`
            ;;
        'server2') 
		    totrq[1]=`expr ${totrq[1]} + 1`
			temptime=`echo "$timeend - $timestart"|bc`
			timerq[1]=`echo "${timerq[1]} + $temptime"|bc`
            ;;
		'server3')
		    totrq[2]=`expr ${totrq[2]} + 1`
			temptime=`echo "$timeend - $timestart"|bc`
			timerq[2]=`echo "${timerq[2} + $temptime"|bc`
			;;
		'server4')
		    totrq[3]=`expr ${totrq[3]} + 1`
			temptime=`echo "$timeend - $timestart"|bc`
			timerq[3]=`echo "${timerq[3]} + $temptime"|bc`
			;;
    esac
done

speed[0]=`echo "scale=4;${timerq[0]} / ${totrq[0]}"|bc`
speed[1]=`echo "scale=4;${timerq[1]} / ${totrq[1]}"|bc`
speed[2]=`echo "scale=4;${timerq[2]} / ${totrq[2]}"|bc`
speed[3]=`echo "scale=4;${timerq[3]} / ${totrq[3]}"|bc`

printf "%s %d %s %f %s %f \n" "server1总接受请求数:" ${totrq[0]} "处理耗时：" ${timerq[0]} "单个请求平均耗时:" ${speed[0]}
printf "%s %d %s %f %s %f \n" "server2总接受请求数:" ${totrq[1]} "处理耗时：" ${timerq[1]} "单个请求平均耗时:" ${speed[1]}
printf "%s %d %s %f %s %f \n" "server3总接受请求数:" ${totrq[2]} "处理耗时：" ${timerq[2]} "单个请求平均耗时:" ${speed[2]}
printf "%s %d %s %f %s %f \n" "server4总接受请求数:" ${totrq[3]} "处理耗时：" ${timerq[3]} "单个请求平均耗时:" ${speed[3]}