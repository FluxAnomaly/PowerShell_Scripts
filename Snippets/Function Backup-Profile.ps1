Function Backup-Profile {
$TimeStamp = $(get-date).ToString("yyyyMMdd_Hm")

# Make local copy:
Write-Host "Making local copy"
Copy-Item -Path "C:\Users\an458060ad\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1" –Destination "C:\TOOLS\PowerShell_Scripts\Profiles\$TimeStamp-Microsoft.PowerShellISE_profile.ps1" -Verbose

# Make network copy:
Write-Host ""
Write-Host "Making NETWORK backup copy. Enter credentials for standard account."
New-PSDrive -Name BackupDrive -PSProvider "FileSystem" -Root "\\va10vnas003b5.us.ad.wellpoint.com\home\AF75244\BACKUPS" -Credential af75244
Copy-Item -Path "C:\Users\an458060ad\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1" –Destination "BackupDrive:\PS_Profiles\$TimeStamp-Microsoft.PowerShellISE_profile.ps1" -Verbose
# Remove-PSDrive -Name BackupDrive
}

<#
Notes:
To copy files to a network drive my standard credentials are needed but this code runs under my elevated account.
But credentials cannot be passed in a normal "Copy-Item" command.
They can be passed in the "New-PSDrive" command though. 
So first I map a PSdrive and using the -Credential switch to pass it my credentials.
NOw I can copy to my personal network folder by using the PSdrive in the copy command.
#>