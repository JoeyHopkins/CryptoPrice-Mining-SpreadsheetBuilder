#! /usr/bin/bash

#In order for crontab to run every hour correctly,
#the directory for the executable file needs to be the same here
dir=/home/usr/Desktop
APIKey="<Insert API Key here>"
APIID="1027" #1027 is Eth
DestEmail="sampleEmail@Sample.com"

GetDateTime()
{
	Year=$(date +"%Y")
	Month=$(date +"%-m")
	Day=$(date +"%-d")
	Hour=$(date +"%-H")
	PastYear=$((Year-1))
	DayOfYear=$(date +"%-j")
	DayOfWeek=$(date +"%-u")
	WeekOfYear=$(date +"%-U")
}

getCurrentShyftPrice() {

	#Obtain Shyft information from API
	curl -H "X-CMC_PRO_API_KEY: $APIKey" -H "Accept: application/json" -d "id=$APIID&convert=USD" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest -o $CURRENTSHYFTPRICE

        #Isolate the price in a text file
        sed -i 's/\,/\n/g' $CURRENTSHYFTPRICE
        sed -i 's/{/\n/g' $CURRENTSHYFTPRICE
        sed -i '/price/!d' $CURRENTSHYFTPRICE
        sed -i -r 's/["price":]//g' $CURRENTSHYFTPRICE
}

GetDateTime

CURRENTSHYFTPRICE=$dir/CurrentShyftPrice.txt
HOURLYFILE=$dir/HourlyStorage.txt
EXCELSPREADSHEET=$dir/ShyftSpreadsheet$Year.xls
PASTEXCELSPREADSHEET=$dir/ShyftSpreadsheet$PastYear.xls
PREVIOUSDAYSTORAGE=$dir/PreviousDayStorage.txt
OBTAINBALANCE=$dir/ObtainBalance.js

getCurrentShyftPrice

#if it is the beggining of a new day
if (($Hour == 0))
then
	#First time use: check if file exists to prevent prompt
	if [ -f "$HOURLYFILE" ]
	then
		#remove the file if it exists to clear the storage
   		rm "$HOURLYFILE"
	fi
fi

#place the current price into the hourly file
cat $CURRENTSHYFTPRICE >> "$HOURLYFILE"

#if it is the last hour of the day
if (($Hour == 23))
then
	#Find the average of all the hourly values
	total=0
	average=$(awk '{ total += $1 } END { print total/NR }' "$HOURLYFILE")

	#If the spreadsheet does not exists then
	if [ ! -f "$EXCELSPREADSHEET" ]
	then
		#create the spreadsheet and add the header
		echo "$Year" >> "$EXCELSPREADSHEET"
		echo "Date	Avg Price	Shyft Mined 24H	Value Mined 24H" >> "$EXCELSPREADSHEET"
	fi

	#obtain the current balance
        AmountMined=$(node $OBTAINBALANCE)

	#if storage exists then
        if [ -f "$PREVIOUSDAYSTORAGE" ]
	then
		#get yesterdays mined from storage
		#use it to calculate Mined in last 24H
                PrevMined=$(sed '1q;d' $PREVIOUSDAYSTORAGE)
		Mined24H=$(echo "$AmountMined - $PrevMined" | bc)

		#obtain yesterdays average and use it to calculate mined value 24H
                PrevAvg=$(sed '2q;d' $PREVIOUSDAYSTORAGE)
		Value24H=$(echo "$Mined24H * $PrevAvg" | bc)

		#For the values if they need to be changed belong to last years sheet
		sed -i "s/Target Mined/$Mined24H/" $PASTEXCELSPREADSHEET
		sed -i "s/Target Value/$Value24H/" $PASTEXCELSPREADSHEET

		#current spreadsheet
                sed -i "s/Target Mined/$Mined24H/" "$EXCELSPREADSHEET"
		sed -i "s/Target Value/$Value24H/" "$EXCELSPREADSHEET"
	fi

	#Put the current values needed on the next day into storage
	echo "$AmountMined" > $PREVIOUSDAYSTORAGE
	echo "$average" >> $PREVIOUSDAYSTORAGE

	#add in the new entry to the spreadsheet
	echo "$Month/$Day	$average	Target Mined	Target Value" >> "$EXCELSPREADSHEET"

        #if it is friday send the current spreedsheet
        if (( $DayOfWeek == 5 ))
        then
                echo "See Attached" | mutt -s "Week $WeekOfYear Spreadsheet" $DestEmail -a $EXCELSPREADSHEET

                #If its the first week of the year, send last years final spreadsheet
                if (( $DayOfYear < 8 ))
                then
                        echo "See Attached" | mutt -s "Final Spreadsheet of $PastYear" $DestEmail -a $PASTEXCELSPREADSHEET
                fi
        fi
fi
