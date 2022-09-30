# UnknownBeacons
A short script to streamline looking up beaconing IPs

---
Because running tools like Zeek/Corelight@home and Rita have become so easy to run on a home network, it's easier than ever to get a list of suspicious IPs that are phoning home, but those tools don't tell you where "home" is. 

This script doesn't find that information out for you, but it does help streamline the process of figuring it out on your own. Simply put, this script will parse through an `unknown-beacons.txt` file to see if you've added an IP already, and if you haven't it will perform a whois search and allow the addition of one line for comments. It puts this output into a consistent format:
```
AS       | IP       | AS Name
<number> | <number> | <name>
# Comments

```

If you don't want to leave a comment you won't have to; if you don't want to add anything at all to the file, this is probably a waste of your time and you should just do a simple `whois` lookup.

---
### Format
`./unknown_beacon.sh [IP]`

### To Do
* Integrate various APIs that will shorten the amount of time it takes to gather data, such as VirusTotal and Alien Vault.
* Allow for comments to span multiple new lines.
* Allow adding comments to previously created entries.
* *Re-write in golang for fun* ;)
