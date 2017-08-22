file="CheckedBad.txt"
file2="GoodGraphs.txt"
/../Applications/SageMath-7.6.app/sage FindMinimal.sage &
sleep 5
prevlast=$(cat $file | tail -n 2 | head -1)
prevlast2=$(cat $file2 | tail -n 2 | head -1)
Update=false
while true
do
    if [ "$Update" = true ]
    then
        echo "Update was True"
        sleep 2700
    else
        echo "Update was False"
        sleep 7200
    fi
    curLast=$(cat $file | tail -n 2 | head -1)
    curLast2=$(cat $file2 | tail -n 2 | head -1)
    echo $prevlast
    echo $curLast
    echo $prevlast2
    echo $curLast2
    if [ "$prevlast" == "$curLast" ] && [ "$prevlast2" == "$curLast2" ]
    then
        echo ""
        echo "Program will be restarted"
        echo ""
        kill -INT $(ps | grep 'python FindMinimal.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
        sleep 20
        ./clean.py
        sleep 10
        /../Applications/SageMath-7.6.app/sage transferMin.sage
        sleep 20
        if [ "$Update" = true ]
        then
            git add CheckedBad.txt GoodGraphs.txt Minimal.txt MinimalVertices.txt
            git commit -m "updated files that are used to find minimal graphs"
            git push
            Update=false
        fi
        sleep 10
        /../Applications/SageMath-7.6.app/sage FindMinimal.sage &
    else
        echo ""
        echo "Program has made progress"
        echo ""
        Update=true
        prevlast=$(cat $file | tail -n 2 | head -1)
        prevlast2=$(cat $file2 | tail -n 2 | head -1)
    fi
done

