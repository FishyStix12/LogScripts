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
<br />
**Example output of 477AggregateLogScript.sh:**
Welcome to my foruth Linux Bash Script
-----------------------Unique IP with Invalid Users with number of Attempts ----------------------------- <br />
    532 68.183.12.113 <br />
     36 13.235.135.173 <br />
     24 14.200.212.187 <br />
     18 218.35.208.5 <br />
     10 211.219.44.209 <br />
-------------------Unique IP failing to login with root user with number of Attempts --------------------- <br />
   2666 138.255.93.0 <br />
    174 68.183.12.113 <br />
     34 121.155.231.244 <br />
     27 120.224.50.233 <br />
     15 187.134.242.142 <br />
     10 103.141.234.41 <br />
      8 41.139.176.122 <br />
      8 221.158.175.94 <br />
      8 13.235.135.173 <br />
      6 14.200.212.187 <br />
      4 218.35.208.5 <br />
      2 89.10.150.58 <br />
      2 193.201.9.21 <br />
      2 175.178.237.54 <br />
      2 175.120.170.20 <br />
      2 112.186.218.246 <br />
      2 101.35.214.179 <br />
      1 121.161.234.34 <br />
      1 117.102.186.80 <br />
      1 112.160.137.225 <br />
-------------------Unique IP failing to login with ubuntu user with number of Attempts --------------------- <br />
    174 68.183.12.113 <br />
     10 136.53.82.151 <br />
     10 13.235.135.173 <br />
      4 69.223.75.0 <br />
      4 14.200.212.187 <br />
      2 34.219.130.168 <br />
      1 31.10.205.220 <br />
      1 146.229.255.21 <br />
      1 112.160.137.225 <br />
-------------------Unique Usernames failing to login with number of Attempts ------------------------- <br />
    354 admin <br />
    285 user <br />
    264 debian <br />
     27 Ubuntu <br />
     18 pi <br />
     15 ubnt <br />
     14 username <br />
      9 spark <br />
      9 guest <br />
      9 craft <br />
      3 vagrant <br />
      3 test <br />
      3 postgres <br />
      3 oracle <br />
      3 moxa <br />
      3 ftpserver <br />
      3 ftp <br />
      3 esuser <br />
      3 es <br />
      3 ec2-user <br />
      3 devops <br />
      3 antti <br />
      3 ansible <br />
      3 1 <br />
