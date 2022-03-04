$Start_Time = Get-Date   # For tracking when a PS tab was first opened. 

$MyCred = Get-Credential -Credential an458060ad    # Run this line once to store credentials.

Function remote-message{
$RemotePC = read-host -prompt ‘Input PC name’;
$message = read-host -prompt ‘Enter the message’;
Invoke-WmiMethod -Class win32_process -ComputerName $RemotePC -Name create -ArgumentList  “c:\windows\system32\msg.exe * $message” | Out-Null
}

Function Reboot-host1 {
Param($remotepc)
Restart-Computer -ComputerName $remotepc -Force -Timeout 0          #Timeout in seconds.  300 = 5 min.
}

Function Reboot-host2 {
$remotepc = read-host "Please enter host to reboot:"
Restart-Computer -ComputerName $remotepc -Force -Timeout 0          #Timeout in seconds.  300 = 5 min.
}

# Use Powershell to reboot remote host. 
Function PS-Reboot {
$remotepc = read-host -Prompt 'Input HostName to reboot';
Restart-Computer -ComputerName $remotepc -Force
}

Function Get-UserGroups ($username) {
Write-Host ''
Write-Host 'SECURITY GROUPS: ' -F Red -B Yellow
(get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Security"}).name | sort -Descending

Write-Host ''
Write-Host 'DISTRO GROUPS: ' -F Green
(get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Distribution"}).name | sort -Descending
}

# -----------------------------------------------------------------------------------------
#region "Open Scripts" 
Function Daily {
ise "`"C:\TOOLS\PowerShell_Scripts\Daily Commands.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\Scratchpads\Tanium report.ps1`"" | out-null

ise "`"C:\TOOLS\PowerShell_Scripts\Last BOOT TIME.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\GET PROCESSES.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\HOSTS file modify.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\Snippets\Log-View.ps1`"" | out-null

ise "`"C:\TOOLS\PowerShell_Scripts\Snippets\RESTART a remote host.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\Audit_Tools.ps1`"" | out-null

# Note: The ' | out-null' at the end of each line causes PS to wait for the process to complete before going to the next line. 
# In this case that forces the scripts to open in order. 
# https://www.itprotoday.com/powershell/forcing-powershell-wait-process-complete
}

Function FixHosts {
ise "`"C:\TOOLS\PowerShell_Scripts\Machine Remediation\Copy_McInstaller v2.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\Machine Remediation\Run_McAfee_Agent_Installer.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\Machine Remediation\WinRM_Fix_Attempt v1.ps1`"" | out-null
ise "`"C:\TOOLS\PowerShell_Scripts\Machine Remediation\File-Check_FlagsBin_V2.ps1`"" | out-null

# Note: The ' | out-null' at the end of each line causes PS to wait for the process to complete before going to the next line. 
# In this case that forces the scripts to open in order. 
# https://www.itprotoday.com/powershell/forcing-powershell-wait-process-complete
}



Function McCopy {
ise "`"C:\TOOLS\PowerShell_Scripts\Snippets\Copy_McA_Tools.ps1`""
}

Function GenXML {
ise "`"C:\TOOLS\PowerShell_Scripts\ePO scripts\Generate ePO Query XML.ps1`""
ise "`"C:\TOOLS\PowerShell_Scripts\ePO scripts\Generate TANIUM ePO Query XML - v2.ps1`""
}

Function Log-view {
ise "`"C:\TOOLS\PowerShell_Scripts\Snippets\Log-View.ps1`"" | out-null
}
#endregion "Open Scripts"
# -----------------------------------------------------------------------------------------


Function Backup-Profile {
$TimeStamp = $(get-date).ToString("yyyyMMdd_Hm")

# Make local copy:
Write-Host ""
Write-Host "Making LOCAL backup copy" -F Green
Copy-Item -Path "C:\Users\an458060ad\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1" –Destination "C:\TOOLS\PowerShell_Scripts\Profiles\$TimeStamp-Microsoft.PowerShellISE_profile.ps1" -Verbose

# Make network copy:
Write-Host ""
Write-Host "Making NETWORK backup copy. Enter credentials for standard account."  -F Green
New-PSDrive -Name BackupDrive -PSProvider "FileSystem" -Root "\\va10vnas003b5.us.ad.wellpoint.com\home\AF75244\BACKUPS" -Credential af75244
Copy-Item -Path "C:\Users\an458060ad\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1" –Destination "BackupDrive:\PS_Profiles\$TimeStamp-Microsoft.PowerShellISE_profile.ps1" -Verbose
# Remove-PSDrive -Name BackupDrive
}

Function Backup-Scripts {
$timestamp = Get-Date -format "MMdd-HHmm" 

# Make network copy:
Write-Host ""
Write-Host "Making NETWORK backup of Scripts folders"  -F Green
Write-Host "Enter credentials for standard account when prompted." -F Red -B Yellow
Start-Sleep -s 1

New-PSDrive -Name BackupScripts -PSProvider "FileSystem" -Root "\\va10vnas003b5.us.ad.wellpoint.com\home\AF75244\BACKUPS" -Credential af75244
Copy-Item -Path "C:\TOOLS\PowerShell_Scripts"  –Destination "BackupScripts:\SCRIPTS\$TimeStamp" -Recurse -Verbose

# PLAY SPEECH:
# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
# Say something
$voice.speak("Your scripts backup is complete") | Out-Null  #Out-Null prevents the return code from showing.
}

Function Reload {
Write-Host "Reloading profile"
.$profile
}


