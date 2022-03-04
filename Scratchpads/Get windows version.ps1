# Get windows version. 
# https://stackoverflow.com/questions/7330187/how-to-find-the-windows-version-from-the-powershell-command-line/43668006#43668006

<#
NOTE:  Windows 7 reports as major version 6.
    Example:
    OS Name             : Microsoft Windows 7 Enterprise 
    OS Version          : 6.1.7601 Service Pack 1 Build 7601

    OS Name             : Microsoft Windows 10 Enterprise
    OS Version          : 10.0.17763 N/A Build 17763
#>

[System.Environment]::OSVersion.Version
[System.Environment]::OSVersion.Version.Major


# --------------------------------------------------------------------------------------------------------------------------------
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentMajorVersionNumber

$Target = 'xxx'
Invoke-Command $Target {(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentMajorVersionNumber}

    

# --------------------------------------------------------------------------------------------------------------------------------
# https://stackoverflow.com/questions/7330187/how-to-find-the-windows-version-from-the-powershell-command-line/43668006#43668006
systeminfo /fo csv | ConvertFrom-Csv | select OS*, System*, Hotfix* | Format-List