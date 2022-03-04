# COPYING FILESs from one host to another.
# Working copy of commands....

# Variables:
$HostName = 'xxx'
#$source_pc = 'l4xw56m2'    # Not needed.
#$RipPath = "C:\TOOLS\McAffee_Tools\FramePkg_5.6.2.209_RTW_EPO_300.exe"

# ===================================================================================
# SHORTLIST OF COMMANDS:
Copy-Item –Path "C:\TOOLS\McAffee_Tools\FramePkg_5.6.2.209_RTW_EPO_300.exe" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose

Copy-Item –Path "C:\TOOLS\McAffee_Tools\McAfeeEndpointProductRemoval_19.11.0.64.exe" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose
Copy-Item -Path "C:\TOOLS\McAffee_Tools\elevate.bat" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose

.\FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT

Invoke-Command -Computername $HostName -Command {c:\Flags\BIN\\FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT}
# ===================================================================================

# Connect to host to start winrm.cmd (Windows Remote Mgmt.) You can use HOSTNAME or IP. 
c:\tools\pstools\psexec -h -s -e -d \\$HostName winrm.cmd quickconfig -q

# Create and check folder from my machine:
    # Invoke-Command -Computername $HostName -Command {mkdir c:\Flags\BIN\}
    # Invoke-Command -Computername $HostName -Command {dir C:\Flags\BIN\}
Invoke-Command $HostName {Test-Path c:\Flags\BIN\}

# To copy files over run these lines from YOUR machine.

# Product removal:
Copy-Item –Path "C:\TOOLS\McAffee_Tools\McAfeeEndpointProductRemoval_19.11.0.64.exe" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose
Copy-Item –Path "C:\TOOLS\McAffee_Tools\ENS10_Uninstall.bat" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose

# Solidcore v 8.0.2.125 installer:
Copy-Item –Path "C:\TOOLS\McAffee_Tools\SOLIDCOR802-125_WIN\setup-win-7-2008r2-amd64-8.0.2.125.exe" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose
Copy-Item –Path "C:\TOOLS\McAffee_Tools\SC_Cleanup.exe" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose

# Misc stuff:
Copy-Item -Path "C:\TOOLS\McAffee_Tools\readme.txt" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose
Copy-Item -Path "C:\TOOLS\McAffee_Tools\MSI removal commands.txt" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose
Copy-Item -Path "C:\TOOLS\McAffee_Tools\elevate.bat" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose
Copy-Item -Path "C:\TOOLS\McAffee_Tools\updatepol.bat" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose

    # If host is on NEW ePO. This is the McAfee agent, not solidcore.
    Copy-Item –Path "C:\TOOLS\McAffee_Tools\FramePkg_5.6.2.209_RTW_EPO_300.exe" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose
    
    # If host is on old ePO. This is the McAfee agent, not solidcore.
    Copy-Item –Path "C:\TOOLS\McAffee_Tools\FramePkg_OLDepo.exe" –Destination "\\$HostName\c$\Flags\BIN\" -Verbose


# Install Solidcore when in session with host:
FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT

.\FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT


#=======================================================================
# Scratchpad below here:  ---------------------------------------------------------------------------------

# Install Agent when in session with host:
FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT

.\FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT
Invoke-Command $HostName {C:\Flags\BIN\\FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT}

# Can the Rip tool be run in PowerShell remote session?         Not working so far.   
.\McAfeeEndpointProductRemoval_19.5.0.17.exe /quiet /noreboot /all

# Remove ENS:
McAfeeEndpointProductRemoval_19.5.0.17.exe --accepteula --ENS --IgnoreFRPCheck

# Remove Application Control. If MACC is active it will not be removed.
McAfeeEndpointProductRemoval_19.5.0.17.exe --accepteula --MACC --IgnoreFRPCheck

# Remove Agent. If Encryption is active it will not be removed.  (Remove all products to bypass this)
McAfeeEndpointProductRemoval_19.5.0.17.exe --accepteula --MA --IgnoreFRPCheck


# Can the Rip tool be run from local session on my machine with Invoke-Command?         Not working so far.
Invoke-Command -Computername $HostName -Command {C:\Flags\BIN\\McAfeeEndpointProductRemoval_19.5.0.17.exe /quiet /noreboot /all}


# Can the Rip tool be run from local session on my machine with PsExec?         Not working so far.
C:\tools\PSTools\PSEXEC.exe -H -S -E -I 0 \\$HostName C:\tools\McAfeeEndpointProductRemoval_19.5.0.17.exe /quiet /noreboot /all
    C:\tools\PSTools\PSEXEC.exe -H -S -E -D \\$HostName C:\tools\McAfeeEndpointProductRemoval_19.5.0.17.exe /quiet /noreboot /all
    C:\tools\PSTools\PSEXEC.exe -H -S -E -D \\$HostName 'C:\tools\McAfeeEndpointProductRemoval_19.5.0.17.exe' /quiet /noreboot /all

# To run the Command prompt on the remote host:
C:\tools\PSTools\psexec.exe \\hostname cmd


# ---------------------------------------------------------------------------------------------------------------------------
# Check that rip tool is running?  ------------------------------------------------------------------------------------------
Get-Process *removal* | where {$_.Product} | Format-Table name, product, cpu, description -autosize

    # Process Name:
    # McAfeeEndpointProductRemoval_2.3.0.39




<# ---------  Contents of readme  ---------------------------------------------

MFERemoval101_q2_1587-5-25-2018			McAfee rip tool zip file

McAfeeEndpointProductRemoval_2.3.0.39.exe	McAfee rip tool

MER.exe				Collects McAfee logs & packages them to share. 

SC_Cleanup.exe			Cleans up leftovers after uninstalling SolidCore. 



FramePkg.exe	                McAfee agent installer, keyed to the ePO console it was exctracted from.

-----------------------------------------------------------------------------------
Extracting the FramePkg.exe installer from ePO:

	• At the top of the System Tree page choose New Systems.
	• Select: Create and download agent installation package and nothing else.
	• Click OK button.
	• Download/Save the file.  Rename if needed. 



If a new agent version has been release since the last extraction, do a new one.

#>