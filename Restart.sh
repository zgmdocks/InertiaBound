file="DeleteResults.txt"

/../Applications/SageMath-7.6.app/sage Delete.sage &
sleep 15
prevlast=$(cat $file | tail -n 2 | head -1)
echo $prevlast
while true
do
    echo "NOW"
    sleep 10
    if [ "$prevlast" == "$(cat $file | tail -n 2 | head -1)" ]
    then
        echo ""
        echo "Program will be restarted"
        echo ""
        kill -INT $(ps | grep 'python Delete.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
        ./cleaner.py
        git add .
        git commit -m "added new graphs"
        git push
        /../Applications/SageMath-7.6.app/sage Delete.sage &
    else
        echo ""
        echo "Program has made progress"
        echo ""
        prevlast=$(cat $file | tail -n 2 | head -1)
    fi
done

