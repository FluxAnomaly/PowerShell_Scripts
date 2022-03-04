# Mapping drives:


# For explorer use:
# You can use the DOS commands you'd use in a batch file.

Net use Z: \\Server-xxxxxx\c$


# --------------------------------------------------------
# PS Drives:   (They have names, not letters. Can be persistent and temporary.)

# See existing PSDrives:
Get-PSDrive


# Create new PSDrive:
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive?view=powershell-7
# When creating new drive name doesn't include colon.  But needs one when used. 
New-PSDrive

New-PSDrive -Name Demo -PSProvider FileSystem -Root C:\Temp   

New-PSDrive -Name "Public" -PSProvider "FileSystem" -Root "\\Server01\Public"

# Example with splatting:

    $parameters = @{
        Name = "MyDocs"
        PSProvider = "FileSystem"
        Root = "C:\Users\User01\Documents"
        Description = "Maps to my My Documents folder."
    }
    New-PSDrive @parameters





# Misc:

New-PSDrive -Name BackupDrive -PSProvider "FileSystem" -Root "\\va10vnas003b5.us.ad.wellpoint.com\home\AF75244\BACKUPS" -Credential af75244
Copy-Item -Path "C:\Users\an458060ad\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1" –Destination "BackupDrive:" -Verbose


Get-PSDrive

dir BackupDrive:

Remove-PSDrive -Name BackupDrive

