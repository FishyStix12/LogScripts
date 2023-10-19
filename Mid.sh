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

#grep -E -o -> -E runs grep with extended regular expressions such as () for grouping, {} for 
#specifying the number of repetitions, and [] for greps class pattern matching 
# and -o only matches the case in the string. This command will automatically cut the parts of 
#each line that aren't an IP address
#'([0-9]{1,3}\.){3} -> matches a sequence of three groups {3} containing 1 to 3 digits {1,3}
#and each digit contains a number from the range of 0-9 [0-9] for the IP address.
#[0-9]{1,3}' -> gives us the ability to restate that each IP address doesn't end with a period,
#that it ends with a grouping of 1-3 digits containing a number from the range of 0-9.
#If we do not include this the new file won't have any information as the command would be 
#looking for IP addresses that end in a period.
#grep -v "0.0.0.0" removes the weird glitch address of 0.0.0.0 that is appearing in the 
# output but isn't actually in the file
#| -> pipes the output of the previous command into the next command
grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' *$input*| grep -v "0.0.0.0"| sort | uniq -c| sort -rn >> $newfile

