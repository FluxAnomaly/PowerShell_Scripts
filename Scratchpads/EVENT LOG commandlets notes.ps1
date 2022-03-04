# Get-WinEvent vs. Get-EventLog :

<#
GET-EVENTLOG seems to be a legacy cmdlet that is compatible with older versions of Windows, 
while GET-WINEVENT is the "new" shiny thing. 
According to some blog posts, it is much faster than Get-Eventlog, especially when being used against remote computers. 
It is also capable to display the message body in XML format.

Get-WinEvent
Gets events from event logs and event tracing log files on local and remote computers


Get-EventLog
Gets the events in an event log, or a list of the event logs, on the local computer or remote computers.

#>




$RemotePC = 'VDAASW1016087'
$RemotePC = 'L4GVZR72'  #Rick
$RemotePC = 'L4JKGWF2'  #Leo

# All event ID's:
# THIS DOESN'T WORK, IT DOESN'T LIKE THE * BUT I THOUGHT I REMEBERED IT WORKING BEFORE. 8/27/20.
Invoke-Command -Computer "$RemotePC" {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=*} | Select-Object timecreated,message -First 100} | Out-GridView


# Attack Surface Reduction (ASR) events:
# Windows Defender:
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1121} | Select-Object timecreated,message -First 100} | Out-GridView

# Windows firewall events:
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall";id=2011} | Select-Object timecreated,message -First 50} | Out-GridView  


Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall";id=2011} | Select-Object timecreated,message -First 50} | Format-Table  




Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational"} | Select-Object timecreated,message -First 100} | Out-GridView
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational"} | Select-Object timecreated,message -First 100} | ft


Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall"} | Select-Object timecreated,message -First 50} | ft  


# =============================
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall"} | Select-Object * -First 50} | Out-GridView

Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall";id=2010} | Select-Object * -First 50} | Out-GridView