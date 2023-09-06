#!/bin/bash
#User inputs the name of the directory with the auth.log files
echo "This is my first bash script"
echo -n  "Please enter the directory with the files to analyze:"
#Reads the input given by the user and saves it as variable a variable named d
read d
#Changes the directory from the current working directory into the directory the user has input
cd ./$d
#Here we are asking the user to provide us with  a string that could represent all of the auth.log files they want to analyze
echo -n "Enter a file pattern to search within $d:"
#Reads the input given by the user and saves it as a variable named pattern
read pattern
echo -n "Enter the name of the text file you would like to create:"
read new_file
touch $new_file.txt
echo "I am now going to analyze the *$pattern* files now"
#cat pattern-> opens the log file and stores its contents
#grep cron ->prints all lines that have the string 'cron'
#grep 'open' -> prints all the lines that have the string 'open'
#cut -d " " -f 1-3,11 ->cut the line on spaces and keeps the first three and eleventh fields
cat $pattern > $new_file | grep cron -r *$pattern* | grep -v closed | cut -d " " -f 1-4,11 | less

