#!/bin/bash
#################################################################################################
#	Author: Nicholas Fisher
#	Date: September 11 2023
#	Course #: IS 477
#	Description of Script
#	This script is used to pull and counts the unique IP addresses of failed login attempts
#	of invalid users, and for the authentic users root & ubuntu. The script also
#	pulls and counts the unqiue invalid usersnames attempting to login.
#################################################################################################

#Read the input given by the user and saves it as a variable named input file
echo -n "Enter a pattern for the type of log files your want to analyze: "
read input_file

#User inputs the name of the directory with the log files to be analyzed and the read command saves it to a
#variable named dire
echo -n "Please enter the directory with the log files you wish to analyze: "
read dire

#Changes the directory from the current working directory into the directory with the Log files to be analyzed
cd ./$dire

#Ask the user for the name of a file to combine all of the data from each of the AWS instance logs

#Ask the user for the name of the txt file they want to create for the analysis to be appended to
#And saves their input as a variable named failedpassword
echo -n "Enter the name of the file you want to create to append the normal Failed password information to: "
read failedpassword

#Ask the user for the name of the txt file they want to create for the analysis to be appended to
#And saves their input as a variable named no_repeat
echo -n "Enter the name of the file you want to create to append the non-repeated lines to: "
read no_repeat

#Ask the user for the name of the txt file they want to create for the analysis to be appended to
#And saves their input as a variable named repeatLines
echo -n "Enter the name of the file you want to create to append the repeated lines to: "
read repeatLines

#Ask the user for the name of the txt file they want to create for the analysis to be appended to
#And saves their input as a variable named expandedLines
echo -n "Enter the name of the file you want to create to append the expanded repeat lines to: "
read expandedLines

#Ask the user for the name of the txt file they want to create for the analysis to be appended to show work
#And saves their input as a variable named expandedLines
echo -n "Enter the name of the file you want to create to append the final aggregation to: "
read final
#zgrep -i "Fail password for root froom.*" -> grabs any lines from regular or zipped files that match Failed password for root from anything after from the input_files
#>> $failedpassword -> appends the zgrep results to the $failedpassword file
zgrep -i "Failed password for root from.*" *$input_file* >> $failedpassword

#zgrep -i "Invalid user.*" *$input_file* -> grabs any lines from regular or zipped files matching the pattern "Invalid user.*" (ignore case) from any files matching the $input_file parameters
#>> failedpassword -> appends the zgrep results to the failedpassword file
zgrep -i "Invalid user.*" *$input_file* >> $failedpassword

#zgrep -i "Fail password for root froom.*" -> grabs any lines from regular or zipped files the paramter "Failed password for ubuntu.*(anything)" from the input_file files
#>> $failedpassword -> appends the zgrep results to the failedpassword file
zgrep -i "Failed password for ubuntu.*" *$input_file* >> $failedpassword

#zgrep -i 'repeated' *$input_file* -> grabs lines from the input_file files that match the pattern 'repeated' (ignore case)
#>> $failedpassword -> appends the zgrep results to the failedpassword file
zgrep -i 'repeated' *$input_file* >> $failedpassword

#Saves the results in thre failedpassword file as a variable named search_data
search_data=$failedpassword

#zgrep -i 'Failed password' $search_data -> pulls all the dhcprequest lines from the search_data file
#grep -v 'repeated' -> elimiates from the first grep that contain the string repeated
#sed 's/  / /' -> replaces double spaces that appear anywhere in the file with one space
#sed 's/of/from' -> replaces every instance of "of" in the file with the word for
#cut -d ' ' -f 6-11 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field besides 6-11 from the results
#>>$no_repeat -> appends the final output to the user created $no_repeat file
zgrep -i 'Failed password' $search_data| grep -v 'repeated'| sed 's/  / /' | sed 's/of/from/'| cut -d ' ' -f 6-11 >> $no_repeat

#zgrep -i 'Failed password' $search_data -> pulls all the dhcprequest lines from the search_data file
#grep -i 'repeated' -> grabs only the lines from the previous output that contain the string 'repeated'
#sed 's/  / /' -> replaces double spaces that appear anywhere in the file with one space
#sed 's/of/from' -> replaces every instance of "of" in the file with the word for
#cut -d ' ' -f 6-16 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field except for fields 6-16
#>> $repeatLines -> appends the final output to the user created $repeatLines file
zgrep -i 'Failed password' $search_data | grep -i 'repeated'| sed 's/  / /'| sed 's/of/from/'| cut -d ' ' -f 6-16 >> $repeatLines

#Ask the user for the name of the txt file they want to create for the analysis to be appended to
#And saves their input as a variable named repeatnum
echo -n "File for number of repeats to be appended to:"
read repeatnum

#Saves the repeatLines file as a variable named repeat_dat
repeat_dat=$repeatLines

#zgrep - i 'message' $repeat_dat -> grabs the lines that contain 'message' from the repeat_dat file
#cut -d ' ' -f 3 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field except for the 3rd field
zgrep -i 'message' $repeat_dat | cut -d ' ' -f 3 >> $repeatnum

#expanded_info=$()-> saves the commannds from the commands in the paraentheses to a variavle named exapnded_info
#zgrep - i 'repeated' $repeat_dat -> grabs the lines that contain 'repeated' from the repeat_dat file
#cut -d ' ' -f 6-11 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field except for fields 6-11
expanded_info=$(zgrep -i 'repeated' $repeat_dat | cut -d ' ' -f 6-11)

#for(()) -> initiates a for loop
#i=1; i < $repeat_count; i++ -> tells us that the loop will run until i = $repet_count, i starts at 1, a>
#do -> this iniaties the loop and what the loop will execute every time it is repeated
# echo "$expanded_info" -> tells the loop to echo the contents of $expanded info until the condition of >
#>> $expandedLines will append the repeated echos to the user created $expandedLines file
#done -> ends the loop once the condition of i <= $repeat_count has been met
for((i =1; i<=$repeatnum; i++)); do
	echo "$expanded_info" >> $expandedLines
done

#This command prints the string to the new text file#
grep -i 'from' $no_repeat >> $expandedLines

#This message welcomes the user to the results of my 6th bash script
echo "Welcome to my foruth Linux Bash Script" >> $final



#Next for the first part of the script we want to pull unique IP addresses and the number of times they attempted
#to login with an invalid username, so I want to label each sections outputs to not confuse the user.
echo '-----------------------Unique IP with Invalid Users with number of Attempts -----------------------------' >> $final
cat *$expandedLines* | grep -oi 'Invalid user.*' *$expandedLines*| grep -i 'from' | cut -d ' ' -f 5| sort| uniq -c>> $final

#For the next part of the assignment we want to pull unique ip addr for the root username
echo '-------------------Unique IP failing to login with root user with number of Attempts ---------------------'>> $final
cat *$expandedLines* | grep -oi 'Failed password for root from.*' *$expandedLines*| cut -d " " -f 6 | sort | uniq -c  >> $final

#for the next part of the assignment we want to pull unique ip from the ubuntu username
echo '-------------------Unique IP failing to login with ubuntu user with number of Attempts ---------------------'>> $final
cat *$expandedLines* | grep -oi 'Failed password for ubuntu from.*' *$expandedLines* | cut -d " " -f 6 | sort | uniq -c  >> $final

#For the next part we want to pull all the unique invalid usernames attempting to login
echo '-------------------Unique Usernames failing to login with number of Attempts -------------------------' >> $final
cat *$expandedLines* | grep -oi 'Invalid user.*' *$expandedLines* | cut -d " " -f 3 | sort | uniq -c >> $final

#rm * removes all the uneccasry files that were used to compose the final results of the analysis
rm $expandedLines
rm  $failedpassword
rm $no_repeat
rm $repeatLines
rm $repeatnum


#Tells the user which directory and file the final results in
echo "Final Brute Force Results Analysis results are in the" $dire "directory in the" $final "file!"
