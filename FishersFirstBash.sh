#!/bin/bash
#################################################################################################
#	Author: Nicholas Fisher
#	Date: September 11 2023
#	Course #: IS 477
#	Description of Script
# Pulls all cron jobs that are not closed from auth.log files
#################################################################################################
#User inputs the name of the directory with the auth.log files 
echo -n  "Enter directory with auth.log files to analyze:"
#Reads the input given by the user and saves it as variable a variable named d
read d
#Changes the directory from the current working directory into the directory the user has input
cd ./$d 
#Here we are asking the user to provide us with  a string that could represent all of the auth.log files they want to>
echo -n "Enter a file pattern to search within $d:"
#Reads the input given by the user and saves it as a variable named pattern
read pattern
#greps the files that match the pattern recursivevly for all lines in each file with the string cron in it
# then it will simplify the list of lines to display only lines with chron and that are closed
# then it will cut each of the lines to only show the first 4 fields of the lines we greped
#the less function will then take all the lines that meet our grep and cut parameters and display the contents of the>
grep cron -r *$pattern* | grep -v closed | cut -d " " -f 1-4 | less

