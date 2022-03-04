# Get Windows event log.  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1

Get-EventLog

Get-EventLog -List

Get-EventLog -LogName System -Newest 5

Get-EventLog -ComputerName LHJQX2H2 -LogName Security -Newest 5

Get-EventLog -LogName System -EntryType Error

Get-EventLog -LogName System -InstanceId 2*

#---------------------------------------------------------------
# windows defender logs:
# Neil and Rich's command:

Invoke-Command -Computer LBR72ZY2 {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1121} | Select-Object timecreated,message -First 50} | Out-GridView 

# Rich's command:
# Windows Firewall events, shows the blocked windows FW events
Invoke-Command -Computer PCNAME {Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall";id=2011} | Select-Object timecreated,message -First 50} | Out-GridView  



# Notes:

https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/

https://www.codetwo.com/admins-blog/how-to-check-event-logs-with-powershell-get-eventlog/

# And the ID equals the GUID?   Is there a table or something that lists those out?
https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/attack-surface-reduction 
