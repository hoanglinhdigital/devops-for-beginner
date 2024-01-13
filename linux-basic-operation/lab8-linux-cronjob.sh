#Create a script.sh file as below:
echo "Hello from Cronjob!!!" >> /home/ec2-user/log.txt
date >> /home/ec2-user/log.txt
#save and exit by ESC, :wq, enter

#add execute permission
sudo chmod 755 /home/ec2-user/script.sh

#Edit cronjob
sudo vi /etc/crontab

#Add this line to run script.sh every 1 minute
* * * * * ec2-user /home/ec2-user/script.sh

#Save and exit

#Restart cron service
sudo service crond restart

#Check log file after 2-3 minutes
cat /home/ec2-user/log.txt