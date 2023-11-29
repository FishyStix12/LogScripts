# Log Analysis Scripts
# By: Nicholas Fisher
This is a repository of scripts to help analyze various .log files found on Linux systems. <br />

**The Following List gives a short description of all the scripts in this repository:** <br />
1. 477AggregateLogScript.sh - Takes multiple auth.log files and pulls unique IP addresses that failed to login, and failed login attempts from users attempting to log into invalid user accounts (pulls invalid usernames), the root user (pulls IP addresses), and the ubuntu user (pulls IP addresses). This script will also expand messaged repeated lines and add them into the analysis results. <br />
2. 477LogScript - Takes multiple auth.log files and pulls unique IP addresses that failed to login, and failed login attempts from users attempting to log into invalid user accounts (pulls invalid usernames), the root user (pulls IP addresses), and the ubuntu user (pulls IP addresses). <br />
3. FisherSysLogPrint.sh - This script takes multiple sys.log files as an input and finds if the system has vulnerabilites and prints a statement telling us if there are or are not vulnerabilities. <br />
4. FishersFirstBash.sh - Pulls all cron jobs that are not closed from auth.log files. <br />
5. FishersLogPrint.sh - This script takes multiple auth.log files as an input and prints out the date, time, user, and the IP Addr for each cron job that is open in all the matching files to a new text file created by the user in this script. <br />
6. IPpuller.sh - #       Pulls all IP addresses from any type of log file, sorts and counts the unique IP addresses in reverse chronological order. <br />
7. SysLogAggregation.sh - This script is used to expand DHCPREQUEST repeated x times into the normal DHCPREQUEST format of DHCPREQUEST of <IP ADDR> & <SUBNET Addr> and appends it to a file the user creates, and aggregates it with the normal data. It then moves all the files to a directory created by the user. <br />
8. Testscript.sh - is a script I use when making updates to the codes above to ensure that I am not damaging the actual shell scripts. <br />
