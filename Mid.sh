#!/bin/bash
#################################################################################################
#       Author: Nicholas Fisher
#       Date: October 19, 2023
#       Course #: IS 477
#       Description of Script:
#       Pulls all IP addresses from any type of log file, sorts and counts the unique IP addresses
#       in reverse chronological order.
#################################################################################################
# shows all directories in the current working directory
ls -d
#asks the user for the name of the directory with the log files they want to analyze
#and saves it as a variable named dire
echo -n "Name of the directory with the file/files: "
read dire
#Changes into the directory the user input earlier (dire variable)
cd $dire

# Asks users for a string that will match some part of every file they want to analyze
echo -n "Naming Pattern of the file to analyze: "
read input

#Asks users for the name of the new file they want to create and append information to.
echo -n "name of the file to append information to: "
read newfile
#Asks for the name/names of people who helped to analyze the auth.log files
echo -n "Name of People in your group: "
read users
#Appends the string to the file being created by the script
echo "Group Members: " $users >> $newfile

#Appends the string to the file being created by the script
echo "IS 480-01" >> $newfile

#saves the dates function as a variable named dates
dates=$(date)

#saves the full path to file/files from input variable as variable called fullpath
#Then prints the full path to the auth.log file and added to 
#the new file  created by the script
fullpath=$(realpath *$input*)
echo $fullpath >> $newfile

#Adds the number of Lines that are going to be analyzed from the file/files and saves it to a variable named lines
lines=$(wc -l)

#Prints the statement below with the number of lines that were in the file/files
echo "We have analyzed and manipulated " $lines "lines, on" $dates >> $newfile
#divides the header of the file with the information we were asked to pull
echo "=======================================================================" >> $newfile

#grep -E -o -> -E runs grep with extended regular expressions such as () for grouping, {} for 
#specifying the number of repetitions, and [] for greps class pattern matching 
# and -o only matches the case in the string. This command will automatically cut the parts of 
#each line that isn't an IP address
#'([0-9]{1,3}\.){3} -> matches a sequence of three groups {3} containing 1 to 3 digits {1,3}
#and each digit contains a number from the range of 0-9 [0-9] for the IP address.
#[0-9]{1,3}' -> gives us the ability to restate that each IP address doesn't end with a period,
#that it ends with a grouping of 1-3 digits containing a number from the range of 0-9.
#If we do not include this the new file won't have any information as the command would be 
#looking for IP addresses that end in a period.
#*$input* -> greps from any files that match the string the user inputs into the interactive script when 
#running the file
#grep -v "0.0.0.0" removes the weird glitch address of 0.0.0.0 that is appearing in the 
# in the auth.log file as we do not care for when we are listening to port 22
#sort -> groups all the IP addresses numerically allowing us to truly combine and pull out unique IP's
#uniq -c -> removes anything that isn't a unique IP address, and counts all the redundancies for each IP address
# sort -rn -> sorts the unique counted IP addresses in reverse chronological order numerically
#| -> pipes the output of the previous command into the next command
grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' *$input*| grep -v "0.0.0.0"| sort | uniq -c| sort -rn >> $newfile
