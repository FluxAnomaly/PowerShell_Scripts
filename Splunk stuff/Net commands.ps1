
# Net commands, useable samples:

# Create / Delete a local user:
net user WolfreyTestUser Insanity8086! /add
net user WolfreyTestUser /delete

# Create / Delete a local group:
net localgroup WolfreyTestGroup /add
net localgroup WolfreyTestGroup /delete

# Add / Delete user from local group:
net localgroup WolfreyTestGroup WolfreyTestUser /add
net localgroup WolfreyTestGroup WolfreyTestUser /delete

net localgroup Administrators WolfreyTestUser /add
net localgroup Administrators WolfreyTestUser /delete

# View:
net users
net localgroup
net localgroup administrators
net localgroup WolfreyTestGroup


# $HostName = 'xxx'
# $HostIP = (Test-Connection -Count 1 $HostName).IPV4Address.IPAddressToString; Write-host $hostip


$HostIP = ''

Invoke-Command $HostIP {net localgroup WolfreyTest /add}
Invoke-Command $HostIP {net localgroup WolfreyTest /delete}

Invoke-Command $HostIP {net user Wolfrey Insanity8086! /add}
Invoke-Command $HostIP {net user Wolfrey /delete}

#----------------------------------------------------------
net localgroup administrators
net users

net users defaultuser0 /delete

#----------------------------------------------------------
