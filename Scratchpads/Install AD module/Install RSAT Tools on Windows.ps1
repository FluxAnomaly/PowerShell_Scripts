# Install RSAT Tools on Windows 
# RSAT tools:  https://www.microsoft.com/en-us/download/details.aspx?id=45520
# WindowsTH-RSAT_WS_1803-x64.msu 

# https://www.prajwaldesai.com/install-rsat-tools-on-windows-10-version-1809/
# https://theitbros.com/install-and-import-powershell-active-directory-module/


Get-ADGroup


# Use PowerShell to Install the Remote Server Administration Tools (RSAT) on Windows 10 version 1809
# https://mikefrobbins.com/2018/10/03/use-powershell-to-install-the-remote-server-administration-tools-rsat-on-windows-10-version-1809/

Get-Command -Noun WindowsCapability
Get-WindowsCapability -Name RSAT* -Online

Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property DisplayName, State


    # Active Directory Domain Services and Lightweight Directory Services Tools
    # Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0


Get-WindowsCapability -Name "RSAT: Active Directory Domain Services*" -Online | Add-WindowsCapability -Online

# This line should install AD Directory module but results in RSAT Tools Installation Error 0x800f0954
Get-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online










