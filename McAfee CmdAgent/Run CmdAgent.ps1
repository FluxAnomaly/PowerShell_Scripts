# Run CmdAgent.exe sort of through powershell using PSexec.exe :

# Copy batch file with multiple commands to target and execute it:
# The -c switch copies the file, executes it, then deletes it.
$remotepc = 'xx'
c:\tools\pstools\psexec \\$remotepc -s -c "C:\TOOLS\Batch Files\RemoteDOS\payloads\updatepol.bat"


# Run a single command:
$remotepc = 'xx'

c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files\McAfee\Agent\cmdagent.exe" /p
c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files\McAfee\Agent\cmdagent.exe" /c
c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files\McAfee\Agent\cmdagent.exe" /e

# Alternate location:
c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe" /p
c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe" /c
c:\tools\pstools\psexec \\$remotepc -s "C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe" /e


# 	/p		Collect and send properties to the ePO server
# 	/c 		Check for new policies.
# 	/e		Enforce policies locally


# FYI: Contents of updatepol.bat:
<#
REM Executes a series of cmdagent commands after finding the correct path. 
REM Needs to be copied to target machine first by either remotepol or polex. 

@echo off
IF EXIST "C:\Program Files\McAfee\Agent\cmdagent.exe" (
	echo CMDAGENT found at Primary location of: "C:\Program Files\McAfee\Agent\"
	"C:\Program Files\McAfee\Agent\cmdagent.exe" /p
	"C:\Program Files\McAfee\Agent\cmdagent.exe" /c
	"C:\Program Files\McAfee\Agent\cmdagent.exe" /e
) ELSE (
	echo CMDAGENT found at alternate location of: "C:\Program Files (x86)\McAfee\Common Framework\"
	"C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe" /p
	"C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe" /c
	"C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe" /e
)

@echo.
@echo Policy updates should now be complete. 


REM Notes: --------------------------------------------------------------------------------------

REM There are two possible paths for CMDAGENT.  
	REM C:\Program Files\McAfee\Agent\cmdagent.exe
	REM C:\Program Files (x86)\McAfee\Common Framework\CmdAgent.exe
	
REM The IF EXIST statement automates finding the correct path and changing to that directory. 

REM 	/p		Collect and send properties to the ePO server
REM 	/c 		Check for new policies.
REM 	/e		Enforce policies locally
 

#>