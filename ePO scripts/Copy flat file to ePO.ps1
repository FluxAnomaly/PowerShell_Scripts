# Copy flat file to ePO for import into 'create server task':

# NOT WORKING, NEED TO EXPERIMENT MORE. 
    # Failed under workstation Tier 2 credentials, would prob work with server Tier 1
    # -Credential doesn't work with this command.

# Variables:
# $remotepc = 'xxx' 

$file = "C:\Temp\PROJECTS\Migration mop-up\04-02-19\040219-Win7-2019.txt"


# New ePO / ePO 300 / va10pwpmca300
Copy-Item -Path "$file" –Destination "\\va10pwpmca300\c$\temp" -Verbose
Copy-Item -Path "$file" –Destination "\\va10pwpmca300\c$\temp" -Verbose -Credential AN644915AD 


# Old ePO / ePO99 / va10pwvapp099
Copy-Item -Path "$file" –Destination "\\va10pwvapp099\c$\temp" -Verbose -Credential AN644915AD 



# NOTES:
 https://stackoverflow.com/questions/51283663/how-to-add-credentials-parameter-in-powershell-script