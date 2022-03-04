# See who is logged into a given machine:
# SOURCE:    https://4sysops.com/archives/how-to-find-a-logged-in-user-remotely-using-powershell/

$remotepc = "D9GLJDH2"
Get-CimInstance –ComputerName $remotepc –ClassName Win32_ComputerSystem | Select-Object UserName

# You can use Get-WmiObject for older machines if needed:
Get-WmiObject -ComputerName $remotepc -Class Win32_ComputerSystem | Select-Object UserName


# Local versions:  ----------------------------------------------------

# The new hotness
Get-CimInstance –ClassName Win32_ComputerSystem | Select-Object UserName

# for older machines
Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName




# =======================================================================================
# See who is using a process:  
get-process -IncludeUserName | select username -Unique