######################## Mount and extend EBS volume #################
#list all partition and mountpoint
lsblk
#display all volume and free space
df -h

#Using fdisk to create partition.
sudo fdisk /dev/xvdf

#format partition
sudo mkfs -t xfs /dev/xvdf1
#Mount
sudo mkdir /data
sudo mount /dev/xvdf1 /data

#Make volume auto mount after restart
sudo blkid
sudo lsblk -o +UUID

#Modify fstab file, then add 1 line for /data volume
sudo vi /etc/fstab
#Test auto mount
sudo umount /data
sudo mount -a

#Grow part after extend EBS volume on AWS Console.
sudo growpart /dev/xvdf 1
#AND
sudo xfs_growfs /dev/xvdf1

#NOTE:
/dev/xvdf1: UUID="2f8fae87-be68-46d4-a4bf-a9948f9d0a91" TYPE="xfs" PARTUUID="b4994ce5-01"
