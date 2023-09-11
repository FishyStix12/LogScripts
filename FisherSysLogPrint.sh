#!/bin/bash
#########################################################################
#	Author: Nicholas Fisher
#	Collaborators: Harsh Patel
#	Date: September 6 2023
#	Course #: IS 480
#	Description of this Script:
#	This script takes multiple sys.log files as an input 
#	and finds if the system has vulnerabilites and prints a 
#	statement telling us if there are or are not vulnerabilities.
#########################################################################

#Reads the input given by the user and saves it as a variable named input_file
echo -n "Enter a pattern for the type of log files you want to analyze: "

#Saves the input the user gave as a variable called input_file
read input_file

echo "This is my second bash script"

#User inputs the name of the directory with the log files for the script to analyze
echo -n "Please enter the directory with the log files to analyze: "

#Read the input given by the user and saves it as variable a named d
read d

#Changes the directory from the current working directory into the directory the user specifies
cd ./$d

echo "We will analyze all the files that match the pattern input_file in the $d directory"

if  grep -r "Speculative Store Bypass" *$input_file* ; then
   echo "A Vulnerability has been found"
else
   echo "No vulnerabilities have been found"
fi




