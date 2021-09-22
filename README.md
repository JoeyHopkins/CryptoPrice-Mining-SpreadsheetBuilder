# CryptoPrice-Mining-SpreadsheetBuilder

config.sh is going to install mutt and set up the configuration file.
It will be set up properly to work with gmail.
It is recommended to test the functionality at the end of the config file.
the dailyAvg.sh file was made to work well with crontab to be scheduled to run each hour
<br><br><br>
The dailyAvg.sh file has the following functionality:<br>
->Store the current value of the set up crypto each hour<br>
->At the end of each day:<br>
---->The date is stored into the spreadsheet<br>
---->an average is calculated and is stored into the spreadsheet<br>
---->the previous day mined amount is added to the spreadsheet<br>
---->the previous day mining value (avg * total mined) is added to the spreadsheet<br>
<br><br>
Make sure your gmail is configured correctly:<br>
->Manage your google account<br>
-->select the security tab<br>
--->turn on less secure app access<br>
<br><br>
Run config.sh. This will install and configure mutt to run off your email.<br>
(Will work for any email but is configured currently for gmail SSL)<br>
<br><br>
In order for ObtainBalance.js to work, web3 needs to be installed (npm install web3)<br>
in ObtainBalance.js, a proper wallet address needs to be added.<br>
in ObtainBalance.js, a proper rpc address needs to be set up.<br>
<br><br>
In order to run properly, the following must be set up correctly in dailyAvg.sh.<br>
Directory (dir):<br>
The directory must be altered to be the current directory these files are placed in.<br>
For example if the .sh file is located in<br>
/home/usr/Desktop/File.sh<br>
the directory in File.sh needs to be set to <br>
/home/Desktop<br>
<br><br>
API key must be set. APIID must be set. Heres documentaion for more detail.<br>
https://coinmarketcap.com/api/documentation/v1/# <br>
<br><br>
Email Functionality:<br>
DestEmail must be set to the desired email for recieving emails every friday.<br>
Emails will arrive every friday at ~11pm<br>
<br><br>
Crontab can now be set to run the dailyAvg.sh script every hour
