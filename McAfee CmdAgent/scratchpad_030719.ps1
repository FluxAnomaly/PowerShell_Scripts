"C:\Program Files\McAfee\Agent\cmdagent.exe"

"C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat"

# No result:
Invoke-Command -ComputerName L32LDTN2 -ScriptBlock { "C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat" }
Invoke-Command -ComputerName L32LDTN2 -ScriptBlock { & "C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat" }

# The value of the FilePath parameter must be a Windows PowerShell script file.
Invoke-Command -ComputerName L32LDTN2 -FilePath { & "C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat" }
Invoke-Command -ComputerName L32LDTN2 -FilePath { "C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat" }


# Using -FilePath and Putting the CmdAgent commands into a PS script.
Invoke-Command -ComputerName L32LDTN2 -FilePath {"C:\TOOLS\PowerShell_Scripts\Scratchpads\CmdAgent.ps1" }
Invoke-Command -ComputerName L32LDTN2 -FilePath { C:\TOOLS\PowerShell_Scripts\Scratchpads\CmdAgent.ps1 }

Invoke-Command -ComputerName L32LDTN2 -FilePath C:\TOOLS\PowerShell_Scripts\Scratchpads\CmdAgent.ps1

Invoke-Command -ComputerName L32LDTN2 -FilePath & C:\TOOLS\PowerShell_Scripts\Scratchpads\CmdAgent.ps1
Invoke-Command -ComputerName L32LDTN2 -FilePath & "C:\TOOLS\PowerShell_Scripts\Scratchpads\CmdAgent.ps1"




# =====================================================================================================
# None of these worked locally

$command = "C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat"
Invoke-Expression "$command"﻿

$command = {& "C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat"}
Invoke-Expression $command

$command = {"C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat"}
Invoke-Expression & $command

$command = {"C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat"}
& $command

# Works locally
& "C:\TOOLS\Batch Files\RemoteDOS\Payloads\updatepol.bat"



# Psexec approach:

#copy file to target and execute it:
# WORKS
$remotepc = 'xx'
c:\tools\pstools\psexec \\$remotepc -h -s -c "C:\TOOLS\Batch Files\RemoteDOS\payloads\updatepol.bat"

c:\tools\pstools\psexec \\$remotepc -s -c "C:\TOOLS\Batch Files\RemoteDOS\payloads\updatepol.bat"

c:\tools\pstools\psexec \\$remotepc -s -c "C:\TOOLS\Batch Files\RemoteDOS\payloads\updatepol.bat"


# Use what's there:
# WORKS
$remotepc = 'xx'

c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files\McAfee\Agent\cmdagent.exe" /p
c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files\McAfee\Agent\cmdagent.exe" /c
c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files\McAfee\Agent\cmdagent.exe" /e

# 	/p		Collect and send properties to the ePO server
# 	/c 		Check for new policies.
# 	/e		Enforce policies locally