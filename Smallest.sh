file="NoGood.txt"
/../Applications/SageMath-7.6.app/sage Find11.sage &
sleep 5
prevlast=$(cat $file | tail -n 2 | head -1)
Update=false
while true
do
    sleep 2700
    curLast=$(cat $file | tail -n 2 | head -1)
    echo $prevlast
    echo $curLast
    if [ "$prevlast" == "$curLast" ] || [ "$prevlast2" == "$curLast2" ]
    then
        echo ""
        echo "Program will be restarted"
        echo ""
        kill -INT $(ps | grep 'python Find11.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
        sleep 20
        if [ "$Update" = true ]
        then
            git add NoGood.txt EdgeResults.txt
            git commit -m "updated files that are used to find small graphs"
            git push
            Update=false
        fi
        sleep 10
        /../Applications/SageMath-7.6.app/sage Find11.sage &
    else
        echo ""
        echo "Program has made progress"
        echo ""
        Update=true
        prevlast=$(cat $file | tail -n 2 | head -1)
    fi
done

