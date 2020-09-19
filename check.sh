#!/bin/bash
# git log --since="12 hours ago" | grep .
git log --since="24 hours ago" --stat |grep testing
if [ $? == 0 ];
then
echo "Building image"
else
echo "Not Found Any Updates"
fi
