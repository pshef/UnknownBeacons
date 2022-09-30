#! /bin/bash

# Usage: unknown_beacons.sh [IP]

# This script will automatically perform a `whois -h whois.cymru.com` search on a provided IP and append the results and any comments to the unknown-beacons.txt file.
# Make sure you're in the home directory where the unknown-beacons.txt file is.

if [ -z "$1" ]; then
	echo "No IP supplied."
	echo "Usage: unknown_beacons.sh [IP]"
	exit 1
else

#Get the IP you want to look up
echo -e "You're looking up IP $1"
unknown_IP=$1

# Check if it's already in unknown-beacons.txt
if grep -q $unknown_IP "unknown-beacons.txt"; then
	echo -e "$unknown_IP is already in unknown-beacons.txt. Here's what you found:"
	echo -e $'\n'
	echo -e "--------------------snip--------------------"
	grep -C 1 $unknown_IP "unknown-beacons.txt"
	echo -e "--------------------snip--------------------"
	echo -e $'\n'
	echo -e "If you need to add more information to this entry, do it manually. I haven't figured out how incorporate that into the script yet."
else
# Print whois information
        whois_IP=$(whois -h whois.cymru.com "$unknown_IP")
        echo -e "$whois_IP"

# Get comments
        echo -e $'\n'
        echo -e "Add a comment or leave blank to move on."
        read add_comment

# Add whois and comment to file
        if [ ! -z "$add_comment" ]; then
        	echo -e $'\n'
        	echo -e "Cool, adding whois info and your comment to unknown-beacons.txt"
        	echo -e "$whois_IP" >> unknown-beacons.txt
                echo -e "# $add_comment" >> unknown-beacons.txt
        	echo -e " " >> unknown-beacons.txt
        	echo -e $'\n'
        	echo -e "Here's what it looks like:"
		echo -e $'\n'
        	echo -e "--------------------snip--------------------"
        	tail -n 4 unknown-beacons.txt
        	echo -e "--------------------snip--------------------"
		echo -e $'\n'
        	echo -e "Done. On to the next sus beacon. Happy hunting!"
        
# If you don't want to add a comment but do want to add the IP
        else
        	echo -e $'\n'
        	echo -e "Do you at least want to add the whois info? (y/n)"
        	read add_whois
        	if [ "$add_whois" = y ]; then
        		echo -e $'\n'
        		echo -e "Well at least you used this for something."
        		echo -e "$whois_IP" >> unknown-beacons.txt
        		echo -e " " >> unknown-beacons.txt
        		echo -e $'\n'
        		echo -e "Finished adding the IP, now go figure out what it was."
        
# If you don't want to add anything
        	else
        		echo -e $'\n'
        		echo -e "Then what did you use this script for? Quit wasting time."
        	fi
        fi
fi
fi
