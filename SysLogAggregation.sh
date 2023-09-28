#!/bin/bas
###################################################################################
#       Author: Nicholas Fisher
#       Date: September 11 2023
#       Course #: IS 477
#       Important Note: Use "bash SysLogAggregation.sh"  and not sh to run script
#	Description of SysLogAggregation.sh
#       This script is used to expand DHCPREQUEST repeated x times into the normal
#       DHCPREQUEST format of DHCPREQUEST of <IP ADDR> & <SUBNET Addr> and appends it
#       to a file the user creates, and aggregates it with the normal data. It then
#       moves all the files to a directory created by the user.
###################################################################################
#User inputs the name of the directory with the log files to be analyzed and the read command saves it
#variable named input_file
echo -n "Please enter a pattern that will match a file/ files we want to analyze: "
read input_file

#User inputs the name of the directory with the log files to be analyzed and the read command saves it to a
#variable named dire
echo -n "Please enter the directory with the log files you wish to analyze: "
read dire

#Changes the directory from the current working directory into the directory with the Log files to be analyzed
cd ./$dire

#Ask the user for the name of the txt file they want to create for the analysis to be appended to
#And saves their input as a variable named dhcprequest
echo -n "Enter the name of the file you want to create to append the normal dhcp request information to: "
read dhcprequest

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

#Creates a variable we are using for the final output
line='--------------------------------------------------------------'

#grabs any file matching the input_file pattern, and pulls out the lines with dhcp request, and appends it the the $dhcprequest file
#-i ignores case
zgrep -i 'dhcprequest' *$input_file* >> $dhcprequest

#creates a variable names search_data for the dhcprequest file
search_data=$dhcprequest

#zgrep -i 'dhcprequest' $search_data -> pulls all the dhcprequest lines from the dhcprequest file
#grep -v 'repeated' -> elimiates from the first grep that contain the string repeated
#sed 's/  / /' -> replaces double spaces that appear anywhere in the file with one space
#sed 's/of/from' -> replaces every instance of "of" in the file with the word for
#cut -d ' ' -f 6-12 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field besides 6-12 from the final result
#>>$no_repeat -> appends the final output to the user created $no_repeat file
zgrep -i 'dhcprequest' $search_data| grep -v 'repeated'| sed 's/  / /' | sed 's/of/from/'| cut -d ' ' -f 6-12 >> $no_repeat

#saves the $no_repeat file as a variable called normal_data
normal_data=$no_repeat

#zgrep -i 'dhcprequest' $search_data -> pulls all the dhcprequest lines from the dhcprequest file
#grep -i 'repeated' -> grabs only the lines from the previous output that contain the string 'repeated'
#sed 's/  / /' -> replaces double spaces that appear anywhere in the file with one space
#sed 's/of/from' -> replaces every instance of "of" in the file with the word for
#cut -d ' ' -f 7-12 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field besides 7-12 from the final result
#>> $repeatLines -> appends the final output to the user created $repeatLines file
zgrep -i 'dhcprequest' $search_data| grep -i 'repeated'| sed 's/  / /' | sed 's/of/from/' |cut -d ' ' -f 7-17 >> $repeatLines

#saves the $repeatLines file as a variable named repeat_dat
repeat_dat=$repeatLines

#repeat_count =$()-> saves the commannds from the commands in the paraentheses to a variavle named repeat_count
#zgrep - i 'repeated' $repeat_dat -> grabs the lines that contain 'repeated' from the repeat_dat file
#cut -d ' ' -f 2 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field besides 2 from the final result
repeat_count=$(zgrep -i 'repeated' $repeat_dat|cut -d ' ' -f 2)

#expanded_info=$()-> saves the commannds from the commands in the paraentheses to a variavle named expanded_info
#zgrep - i 'repeated' $repeat_dat -> grabs the lines that contain 'repeated' from the repeat_dat file
#cut -d ' ' -f 5-12 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field besides 5-12 from the final result
expanded_info=$(zgrep -i 'repeated' $repeat_dat |cut -d ' ' -f 5-12)

#for(()) -> initiates a for loop
#i=1; i < $repeat_count; i++ -> tells us that the loop will run until i = $repet_count, i starts at 1, and it incremental goes up by 1 every time the loop is ran
#do -> this iniaties the loop and what the loop will execute every time it is repeated
# echo "$expanded_info" -> tells the loop to echo the contents of $expanded info until the condition of i <= $repeat_count has been met
#>> $expandedLines will append the repeated echos to the user created $expandedLines file
#done -> ends the loop once the condition of i <= $repeat_count has been met
for((i = 1; i <= $repeat_count; i++)); do
	echo "$expanded_info" >> $expandedLines
done

#echo $line 'Data to be expanded' $line -> will echo the information within the line file then 'Data to be expanded' followed by the line variable again
#>> appends the echo command output to the user created $final file
echo $line 'Data to be expanded' $line >> $final

#grep -i 'request' $repeat_dat -> grabs all the lines containing the string 'request' no matter the casing from the $repeat_dat file
#>> $final -> appends the output of the grep command to the user created $final file
grep -i 'request' $repeat_dat >> $final

#echo $line 'Expanded Data' $line -> will echo the information within the line file then 'Expanded Data' followed by the line variable again
# >> $final -> appends the echo command output to the user created $final file
echo $line "Expanded data" $line >> $final

#grep -i 'from' $repeat_dat -> grabs all the lines containing the string 'from' no matter the casing from the $expandedLines file
#>> $final -> appends the grep output to the $final file
grep -i 'from' $expandedLines >> $final

#echo $line 'Normal Unique Data' $line -> will echo the information within the line file then 'Normal Unique Data' followed by the line variable again
# >> $final -> appends the echo command output to the user created $final file
echo $line "Normal Unique Data" $line >> $final

#grep -i 'from' $repeat_dat -> grabs all the lines containing the string 'from' no matter the casing from the $normal_dat file
#cut -d ' ' -f 3,7 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field besides 3 and 7 from the final result
#sort -> sorts the output numerically
#uniq -c -> eliminates redundant answers from the final output and counts the number of times each unique instance occurs
# >> $final -> appends the echo command output to the user created $final file
grep -i 'from' $normal_data|cut -d ' ' -f 3,7 | sort | uniq -c >> $final

#echo $line 'Aggregated Unique Data' $line -> will echo the information within the line file then 'Aggregated Unique Data' followed by the line variable again
# >> $final -> appends the echo command output to the user created $final file
echo $line 'Aggregated Unique Data' $line >> $final

#grep -i 'from' $repeat_dat -> grabs all the lines containing the string 'from' no matter the casing from the $norml_dat
# >> $expandedLine -> appends the echo command output to the user created $expandedLines file
grep -i 'from' $normal_data >> $expandedLines

#grep -i 'from' $repeat_dat -> grabs all the lines containing the string 'from' no matter the casing from the $expandedLines file
#cut -d ' ' -f 3,7 -> cuts the lines into deliminiters that are seperated by spaces, and we are cutting every field besides 3 and 7 from the final result
#uniq -c -> eliminates redundant answers from the final output and counts the number of times each unique instance occurs
# >> $final -> appends the echo command output to the user created $final file
grep -i 'from' $expandedLines| cut -d ' ' -f 3,7|sort| uniq -c >> $final

#Tells the user where the final aggregated data will be stored
echo "Final DHCP results are in" $final "file!"




