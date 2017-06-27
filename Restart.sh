file="DeleteResults.txt"

prevlast=$(cat $file | tail -n 2)

while true
do
    sleep 30m
    if [ prevlast -ne $(cat $file | tail -n 2 ]
    then
        $(kill -INT ps | grep 'python Delete.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
    fi
done

