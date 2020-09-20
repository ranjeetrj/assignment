#!/bin/bash
find . -not -path '*/\.*' -type d > abc.txt
sed -i -e '1d' abc.txt  && sed -i -e 's/^..//' abc.txt
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
docker build -t pivotchaindata.com:8443/${array[i]}:v01 .
echo "Image Build --> $?"
docker push pivotchaindata.com:8443/${array[i]}:v01 

echo "Image Push --> $?"
else
echo "Not Found Any Updates in ${array[i]}"
fi
done

