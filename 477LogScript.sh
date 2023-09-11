#!/bin/bash
###################################################################################
#	Author: Nicholas Fisher
#	Collaborators: 
#	Date: September 11 2023
#	Course #: IS 477
#	Description of Script
#	This script is used to pull out suspicious login
#	attempts onto the linux system. The script will pull unique IP addresses
#	and invlaid usernames from failed login attempts for the root and ubuntu 
#	users, as well as any unique invalid usernames
###################################################################################

#Read the input given by the user and saves it as a variable named input file
echo -n "Enter a pattern for the type of log files your want to analyze: "
read input_file

#User inputs the name of the directory with the log files to be analyzed and the read command saves it to a 
#variable named dire 
echo -n "Please enter the directory with the log files you wish to analyze: "
read dire

#Changes the directory from the current working directory into the directory with the Log files to be analyzed
cd ./$dire

#Ask the user for the name of the txt file they want to create for the analysis to be appended to
#And saves their input as a variable named newfile
echo -n "Enter the name of the file you want to create to append the analysis information to: "
read newfile

#This command prints the string to the new text file#
echo "Welcome to my foruth Linux Bash Script" >> $newfile

#Next for the first part of the script we want to pull unique IP addresses and the number of times they attempted
#to login with an invalid username, so I want to label each sections outputs to not confuse the user.
echo '-----------------------Unique IP with Invalid Users with number of Attempts -----------------------------' >> $newfile
cat *$input_file* | grep -oi 'Invalid user.*' *$input_file*| grep -i 'from' | cut -d " " -f 5| sort | uniq -c>> $newfile

#For the next part of the assignment we want to pull unique ip addr for the root username
echo '-------------------Unique IP failing to login with root user with number of Attempts ---------------------'>> $newfile
cat *$input_file* | grep -oi 'Failed password for root from.*' *$input_file*| cut -d " " -f 6 | sort | uniq -c  >> $newfile

#for the next part of the assignment we want to pull unique ip from the ubuntu username
echo '-------------------Unique IP failing to login with ubuntu user with number of Attempts ---------------------'>> $newfile
cat *$input_file* | grep -oi 'Failed password for ubuntu from.*' *$input_file* | cut -d " " -f 6 | sort | uniq -c  >> $newfile

#For the next part we want to pull all the unique invalid usernames attempting to login
echo '-------------------Unique Usernames failing to login with number of Attempts -------------------------' >> $newfile
cat *$input_file* | grep -oi 'Invalid user.*' *$input_file* | cut -d " " -f 3 | sort | uniq -c >> $newfile 
