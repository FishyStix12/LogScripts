#!/bin/bash
######################################################################
#	Author: Nicholas Fisher
#	Date: September 6 2023
#	Course #: IS 480
#	Description of this Script:
#	This script takes multiple auth.log files as an input 
#	and prints out the date, time, user, and the IP Addr
#	for each cron job that is open in all the matching 
#	files to a new text file created by the user in this script.
######################################################################

#Reads the input given by the user and saves it as a variable named input_file
echo -n "Enter a pattern for the type of log files you want to analyze: "

#Saves the input the user gave as a variable called input_file
read input_file

echo "This is my first bash script"

#User inputs the name of the directory with the log files for the script to analyze
echo -n "Please enter the directory with the log files to analyze: "

#Read the input given by the user and saves it as variable a named d
read d

#Changes the directory from the current working directory into the directory the user specifies
cd ./$d

echo "We will analyze all the files that match the pattern input_file in the $d directory"

#User creates the name for the new txt file the script will create
echo -n "Enter the name of the new file you want to input filtered log data into: "

#Stores the users input as a variable
read newfile

#cat input_file -> opens the input_file and stores the contents
#grep cron -> prints all the lines that have the string cron
#grep "open" -> prints all of the lines that have the string 'open'
#cut -d " " -f 1-4,11 -> cut the line on spaces and keeps the first 4 and eleventh fields
# >> $newfile.txt -> appends the filtered information (described in the lines above) to the file name provided by the user
cat *$input_file* | grep cron -r *$input_file*| grep 'open' | cut -d " " -f 1-4,11 >> $newfile.txt

#Tells the user where the output is being stored
echo "Now I will input print the results to the" $newfile.txt



