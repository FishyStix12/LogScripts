#!/bin/bash
#askes the user for the directory to which the auth.log file is stored and shows all directories in the current working directory
ls -d
echo -n "Name of the directory with the file/files: "
read dire
cd $dire

# Use grep to extract IP addresses from the auth.log file
echo -n "name of file to anaylze: "
read input

#appends information to file
echo -n "name of file to append information to: "
read newfile

#Appends the string to the file being created by the script
echo "Group Members\: Nicholas Fisher" >> $newfile

#Appends the string to the file being created by the script
echo "IS 480-01" >> $newfile
#saves the dates function as a variable named dates
#then prints current date and time to the file created by the script
dates=$(date)
echo $dates >> $newfile
#saves the full path to vile as variable called fullpath
#Then prints the full path to the auth.log file and added to 
#the new file  created by the script
fullpath=$(realpath auth.log)
echo $fullpath >> $newfile

#divides the header of the file with the information we were asked to pull
echo "=========================================================================================" >> $newfile

grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' *$input*| grep -v "0.0.0.0"| sort | uniq -c| sort -rn >> $newfile

