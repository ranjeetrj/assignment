#!/bin/bash

cd $WORKSPACE/Backend
find . -maxdepth 1 -type d | cut -c 3- > abc.txt
sed -i -e '1d' abc.txt
cat abc.txt

while read line
do
    array+=("$line")
done <  abc.txt
for ((i=0; i < ${#array[*]}; i++))
do
git log --since="24 hours ago" --stat |grep ${array[i]}
if [ $? == 0 ];
then
echo "Building image-------Found updates in  ${array[i]} folder"
docker build -t pivotchaindata.com:8443/${array[i]}:$BUILD_NUMBER .
echo "Image Build --> $?"
docker push pivotchaindata.com:8443/${array[i]}:$BUILD_NUMBER

echo "Image Push --> $?"
else
echo "Not Found Any Updates in ${array[i]}"
fi
done
