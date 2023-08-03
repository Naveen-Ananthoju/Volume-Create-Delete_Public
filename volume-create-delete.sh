#!/bin/bash
Action="Create"
#Actionn=${Action}
if [ $Action == "Create" ]
then
i=0
for i in {1..3}
do
echo "Creating Volume$i"
aws ec2 create-volume --availability-zone us-east-1a --size 1
done
else
#volumeswithsize1=$(aws ec2 describe-volumes --query 'Volumes[?Size==`1`].VolumeId' | tr -d '"' | tr -d ',')
volumeswithsize1=$(aws ec2 describe-volumes --query 'Volumes[?Size==`1`].VolumeId' | jq -r '.[]')
for vol in $volumeswithsize1
do
echo "Deleting volume: $vol"
aws ec2 delete-volume --volume-id "$vol"
done
fi


