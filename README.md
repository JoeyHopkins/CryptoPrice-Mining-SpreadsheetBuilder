# CryptoPrice-Mining-SpreadsheetBuilder

config.sh is going to install mutt and set up the configuration file.
It will be set up properly to work with gmail.
It is recommended to test the functionality at the end of the config file.
the dailyAvg.sh file was made to work well with crontab to be scheduled to run each hour
The dailyAvg.sh file has the following functionality:
->Store the current value of the set up crypto each hour
->At the end of each day:
---->The date is stored into the spreadsheet
---->an average is calculated and is stored into the spreadsheet
---->the previous day mined amount is added to the spreadsheet
---->the previous day mining value (avg * total mined) is added to the spreadsheet


Make sure your gmail is configured correctly:
->Manage your google account
-->select the security tab
--->turn on less secure app access

Run config.sh. This will install and configure mutt to run off your email.
(Will work for any email but is configured currently for gmail SSL)

in ObtainBalance.js, a proper wallet address needs to be added.
in ObtainBalance.js, a proper rpc address needs to be set up.


In order to run properly, the following must be set up correctly in dailyAvg.sh.

Directory (dir):
The directory must be altered to be the current directory these files are placed in.
For example if the .sh file is located in
/home/usr/Desktop/File.sh
the directory in File.sh needs to be set to 
/home/Desktop

API key must be set. APIID must be set. Heres documentaion for more detail.
https://coinmarketcap.com/api/documentation/v1/#

Email Functionality:
DestEmail must be set to the desired email for recieving emails every friday.
Emails will arrive every friday at ~11pm

Crontab can now be set to run the dailyAvg.sh script every hour
