#!/bin/bash

read -p "What word are you looking for? " word
read -p "how big do you want your commit jumps to be? " steps
read -p "What path to search?" path

cd $path
git checkout master
git fetch --depth=1000000

function commit_count {
  git rev-list --count master
}

echo "++++++++++++++++++++++++++++++++++++++++++++++++"
commit_count=$(commit_count)
echo "woah you have $commit_count commmits! That's crazzzzy!"
count=$((commit_count / steps))
echo "we are gonna run this thing $count times then"
echo "++++++++++++++++++++++++++++++++++++++++++++++++"

total_steps=0

rm ~/Desktop/final.txt

for ((i=0; i<=$count; i++)); do
    # echo "（●＾o＾●）（＾ｖ＾）（＾ｕ＾）（＾◇＾）( ^)o(^ ) ( *^▽^* ) ( ✿◠‿◠ )"
    # echo "steps taking is $steps"
    git checkout HEAD~$steps
    grep -rl $word $path* > ~/Desktop/temp.txt
    # echo "count #$i"
    # echo "count #$i" >> ~/Desktop/final.txt
    SHA=$(git rev-parse HEAD)
    echo $(git show -s --format=%ci $SHA) >> ~/Desktop/final.txt
    echo $SHA >> ~/Desktop/final.txt
    # echo $SHA
    sed -n '$=' ~/Desktop/temp.txt >> ~/Desktop/final.txt
    # total_steps=$((total_steps+steps))
done

echo $total_steps

git checkout master
