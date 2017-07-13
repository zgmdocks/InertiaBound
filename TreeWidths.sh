file="FoundVertices.txt"
/../Applications/SageMath-7.6.app/sage transfer.sage &
sleep 5
prevlast=$(cat $file | tail -n 2 | head -1)
Update=false
while true
do
    sleep 10
    curLast=$(cat $file | tail -n 2 | head -1)
    echo $prevlast
    echo $curLast
    if [ "$prevlast" == "$curLast" ]
    then
        echo ""
        echo "Program will be restarted"
        echo ""
        kill -INT $(ps | grep 'python transfer.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
        sleep 20
        if [ "$Update" = true ]
        then
            git add FoundVertices.txt TreeWidths.txt
            git commit -m "updated FoundVertices.txt"
            git push
            Update=false
        fi
        sleep 10
        /../Applications/SageMath-7.6.app/sage transfer.sage &
    else
        echo ""
        echo "Program has made progress"
        echo ""
        Update=true
        prevlast=$(cat $file | tail -n 2 | head -1)
    fi
done

