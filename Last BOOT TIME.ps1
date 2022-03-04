# Last BOOT TIME.ps1
# And misc other AD commands:

# LOCAL VERSION:  Command works in both PowerShell and DOS:
systeminfo.exe | findstr.exe "Time:"

# Remotely through Pshell.  Takes about 20sec. to return result. 
    $TargetHost = 'xxx'
    Invoke-Command $TargetHost {systeminfo.exe | findstr.exe "Time:"}

# ------------------------------------------------------------------------------------------------
# User last logon: 
(get-aduser xxx -properties *).LastLogonDate

# Get Windows install date/time:
# Local:
([WMI]'').ConvertToDateTime((Get-WmiObject Win32_OperatingSystem).InstallDate)

# Remote:
Invoke-Command $TargetHost {([WMI]'').ConvertToDateTime((Get-WmiObject Win32_OperatingSystem).InstallDate)}

# Jeremy's method for getting INSTALL DATE:  Remote:
([WMI]'').ConvertToDateTime((Get-WmiObject Win32_OperatingSystem -ComputerName $TargetHost).InstallDate)



# ------------------------------------------------------------------------------------------------
# This doesn't belong here, move it. 
# Get userID from name:
Get-ADUser -Filter { displayName -like 'Poulakos, Gregory' } | Select SamAccountName



# Sources: 
https://www.cnet.com/how-to/how-to-find-system-up-time-on-windows-7/

https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/findstr

https://www.itprotoday.com/management-mobility/getting-computer-uptime-using-powershell



