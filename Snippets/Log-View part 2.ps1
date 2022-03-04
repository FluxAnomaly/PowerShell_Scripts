
# Malware detected:
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1006} | Select-Object timecreated,message -First 10} | Format-List
# MALWARE_ACTION_TAKEN
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1007} | Select-Object timecreated,message -First 10} | Format-List


# Malware behaviour detected:
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1015} | Select-Object timecreated,message -First 10} | Format-List

# 
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1116} | Select-Object timecreated,message -First 10} | Format-List

Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1117} | Select-Object timecreated,message -First 10} | Format-List






# LOCAL VERSIONS: 

Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1006} | Select-Object timecreated,message -First 10 | Format-List

# MALWARE_ACTION_TAKEN
Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1007} | Select-Object timecreated,message -First 10 | Format-List

Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1015} | Select-Object timecreated,message -First 10 | Format-List

Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1116} | Select-Object timecreated,message -First 10 | Format-List

Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1117} | Select-Object timecreated,message -First 10 | Format-List