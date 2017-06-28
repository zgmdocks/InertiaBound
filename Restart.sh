file="DeleteResults.txt"
/../Applications/SageMath-7.6.app/sage Delete.sage &
sleep 30
prevlast=$(cat $file | tail -n 2 | head -1)
while true
do
    sleep 1800
    curLast=$(cat $file | tail -n 2 | head -1)
    echo $prevlast
    echo $curLast
    if [ "$prevlast" == "$curLast" ]
    then
        echo ""
        echo "Program will be restarted"
        echo ""
        kill -INT $(ps | grep 'python Delete.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
        sleep 20
        ./clean.py
        sleep 10
        git add DeleteResults.txt CheckedBad.txt
        git commit -m "added new graphs"
        git push
        sleep 10
        /../Applications/SageMath-7.6.app/sage Delete.sage &
    else
        echo ""
        echo "Program has made progress"
        echo ""
        prevlast=$(cat $file | tail -n 2 | head -1)
    fi
done

