######################################################################################
# If PS fails to connect you may be able to fix it with these. 
# Connect to host to start winrm.cmd (Windows Remote Mgmt.) You can use HOSTNAME or IP. 
c:\terry\pstools\psexec -h -s -e -d \\$HostIP winrm.cmd quickconfig -q  

# When you can't start a PSsession, use this with HOSTNAME or IP:
C:\terry\PSTools\PsExec64.exe -s -d \\$HostIP powershell.exe "enable-psremoting -force"

Enter-PSSession $HostIP -Authentication Negotiate 
######################################################################################

$MyCred = Get-Credential -Credential US\an458060ad    # Run this line once to store credentials.

$HostName = 'xxx'
$HostIP = 'xxx'
$HostIP = (Test-Connection -Count 1 $HostName).IPV4Address.IPAddressToString; Write-host $hostip

Enter-PSSession -computer $HostIP -SessionOption (New-PSSessionOption -NoMachineProfile) -credential $MyCred
hostname
Test-Path 'C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe'
& "c:\Program Files\SplunkUniversalForwarder\bin\splunk" version
exit

#----------------------------------------------------------
net localgroup administrators
Invoke-Command $HostIP {net localgroup administrators} -credential $MyCred
#----------------------------------------------------------

Invoke-Command $HostIP {net localgroup WolfreyTest /add} -credential $MyCred
Invoke-Command $HostIP {net localgroup WolfreyTest /delete} -credential $MyCred

Invoke-Command $HostIP {net user Wolfrey Insanity8086! /add} -credential $MyCred
Invoke-Command $HostIP {net user Wolfrey Insanity8086! /delete} -credential $MyCred

#----------------------------------------------------

Test-Path 'C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe'
Test-Path 'C:\Program Files\SplunkUniversalForwarder\etc\apps\nms-default-desktops'
Test-Path 'C:\Program Files\SplunkUniversalForwarder\etc\apps\nms-aoc-winevents'

Test-Path 'C:\Program Files\SplunkUniversalForwarder\etc\apps\nms-aoc-winevents\default\inputs.conf'

& "c:\Program Files\SplunkUniversalForwarder\bin\splunk" version