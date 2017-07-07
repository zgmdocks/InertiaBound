file="cubicvt4-300g6.txt"
../SageMath/sage CubicSearch.sage &
sleep 5
prevlast=$(cat $file | head -1)
while true
do
    sleep 2700
    curLast=$(cat $file | head -1)
    echo $prevlast
    echo $curLast
    if [ "$prevlast" == "$curLast" ]
    then
        echo ""
        echo "Program will be restarted"
        echo ""
        kill -INT $(ps | grep 'python CubicSearch.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
        sleep 20
        git add cubicvt4-300g6.txt CubicVT.txt
        git commit -m "updated cubic graph search"
        git push
        sleep 10
        ../SageMath/sage CubicSearch.sage &
    else
        echo ""
        echo "Program has made progress"
        echo ""
        prevlast=$(cat $file | head -1)
    fi
done

