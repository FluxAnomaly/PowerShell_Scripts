# Connect to host system w/o creating a profile
$HostName = "xxx"; Enter-PSSession -computer $HostName -SessionOption (New-PSSessionOption -NoMachineProfile)
$HostIP = (Test-Connection -Count 1 $HostName).IPV4Address.IPAddressToString; Write-host $hostip

# Connect to machine by IP, useful if HostName does not resolve:
$MyCred = Get-Credential -Credential an458060ad    # Run this line once to store credentials.
$RemoteIP = "$HostIP"; Enter-PSSession -computer $RemoteIP -SessionOption (New-PSSessionOption -NoMachineProfile) -credential $MyCred

# Check host solidcore status & version
sadmin status; sadmin version | Write-Host -ForegroundColor green

# Put system in 'recovery' in prep for changes. 
sadmin recover -z CA23AF68D11B1D7 | Write-Host -F yellow
sadmin recover -z BE7WYKY64M572GU # For Servers

# Solidify file or path in quotes. / # Get SHA256 hash of file.
sadmin so 'path'

Get-FileHash -A SHA256 'path'

# Lock host down and exit. (The semicolon allows you to run them together).
sadmin lockdown | Write-Host -B Magenta; exit

######################################################################################
# If PS fails to connect you may be able to fix it with these. 
# Connect to host to start winrm.cmd (Windows Remote Mgmt.) You can use HOSTNAME or IP. 
c:\tools\pstools\psexec -accepteula -h -s -e -d \\$RemoteIP winrm.cmd quickconfig -q  

# When you can't start a PSsession, use this with HOSTNAME or IP:
C:\tools\PSTools\PsExec64.exe -accepteula -s -d \\$RemoteIP powershell.exe "enable-psremoting -force"

Enter-PSSession $RemoteIP -Authentication Negotiate 
######################################################################################

# The ping of powershell
Test-Connection -ComputerName $RemoteIP

# ----------------------------------------------- WinRM commands ---------------------
$HostName = "HostName"
# Check WinRM state on remote machine. 
Get-Service "WinRM" -ComputerName HostName
# Check the dependencies:
Get-Service "WinRM" -RequiredServices -ComputerName HostName
# Make it go!  
Get-Service -Name "WinRM" -ComputerName HostName | Set-Service -Status Running
# ------------------------------------------------------------------------------------

##########################################
# Check who is logged on to a machine
c:\tools\pstools\PsLoggedOn \\$HostName
#########################################

# Begin Update Mode.
sadmin bu
# End Update Mode.
sadmin eu

# Begin Observe Mode
sadmin bo
# End Observe Mode
sadmin eo

#  ?? 
sadmin diag

# Shows unsolidified  files & redirects output to log file.
sadmin lu "path" > c:\flags\SC_UNSO.log

# ?? 
sadmin features enable network-tracking

# Unsolidify file or path.
sadmin unso 'path'

# Lock host down and exit.
sadmin lockdown
exit

#
nslookup HOST                #Returns DNS record. (IP Address, HostName)(means "name server lookup")
ping -a HostIP               #Returns hostname
nbstat-a HostIP              #Returns hostname

net user UserNameHere /domain
 
########################################

# When first setting up PowerShell you need to run this.
c:\temp\pstools\psexec -accepteula

# Adding all machines to Trusted Hosts list
set-item wsman:localhost\client\trustedhosts -value *