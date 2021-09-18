#! /usr/bin/bash

#important note to begin the program
echo "Make sure gmail is configured correctly:"
echo ""
echo "->Manage your google account"
echo "--> select the security tab"
echo "---> turn on Less secure app access"
echo ""

#obtain the username and password for the email
echo "What is the email you would like to use for sending?"
read EmailName

echo ""
echo "What is the Password for this email?"
read Password

#make sure that mutt is installed
sudo apt-get install mutt

#create a directory for the mutt config file
mkdir ~/.mutt

#if current muttrc file exists remove it
rm ~/.mutt/muttrc

#This section mutt configuration for sending the email. It is configured for gmail
echo "## ================  SMTP settings====================" >> ~/.mutt/muttrc
echo set "smtp_url = \"smtps://$EmailName@smtp.gmail.com:465/\"" >> ~/.mutt/muttrc

#Change out for this one if port for TLS/STARTTLS is needed
#echo set "smtp_url = \"smtps://$EmailName@smtp.gmail.com:587/\"" >> ~/.mutt/muttrc

echo "set smtp_pass = \"$Password\"" >> ~/.mutt/muttrc


#prompt test
clear
echo "Package installation is complete"
echo ""
echo "Would you like to send a test email?[yes/no]"
read answer

#send a test email if desired to a chosen email
if [[ "$answer" = "yes" ]]
then
	echo ""
	echo "What email would you like to send a test email to?"
	read testEmail

	echo "test body" | mutt -s "test subject" $testEmail
fi

echo ""
echo "Configuration Complete"
