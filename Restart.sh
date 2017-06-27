file="DeleteResults.txt"

sage Delete.sage
sleep 15

prevlast=$(cat $file | tail -n 2)

while true
do
    sleep 30
    if [ prevlast -ne $(cat $file | tail -n 2 ]
    then
        kill -INT $(ps | grep 'python Delete.sage.py' | grep -v 'grep' | grep -v 'bash'| awk '{print $1;}')
        ./cleaner.py
        git add .
        git commit -m "added new graphs"
        git push
        sage Delete.sage
    fi
done

