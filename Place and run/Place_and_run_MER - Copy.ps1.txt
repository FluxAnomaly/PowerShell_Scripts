# Copy MER.exe and remotely execute, then retrieve results:  
# This is meant to be run from your machine with no session to remote machine. 
# By using a known existing path (C:\flags\bin\) on the host you avoid having to create a directory. 

$remotepc = 'xxx'

# Test Connection:
Test-WSMan $remotepc

# Copy tool over:
Copy-Item –Path "C:\TOOLS\McAffee_Tools\MER\MER.exe" –Destination "\\$remotepc\c$\Flags\BIN\" -Verbose

# Test that file exists:
Test-Path "\\$remotepc\c$\Flags\BIN\MER.exe"

# ====== Run MER ===============================================================================
# Takes about 15 - 20 seconds to return confirm message. 
C:\tools\PSTools\PsExec.exe -H -S -E -D \\$remotepc "C:\Flags\Bin\Mer.exe" /detected /save "C:\Flags\BIN\$remotepc-MERout.tgz" /silent


# ---- Confirm that MER is running on target:  ------------------------------------------------------------
c:\tools\pstools\pslist mer \\$remotepc          # This lists elapsed time but sometimes hangs up.
Invoke-Command $remotepc {Get-Process mer}       # This doesn't hang, but takes a while to return result.


# ---- Retrieve results files: ------------------------------------------------------------------------------
Copy-Item -Path "\\$remotepc\c$\Flags\BIN\$remotepc-MERout.tgz" -Destination 'C:\Temp\PROJECTS\PS_crashing' -Verbose


# Check contents of the directory 
Invoke-Command $remotepc {dir C:\Flags\BIN}
Invoke-Command $remotepc {dir C:\Flags\BIN\*MER*.tgz}



# Additional stuff:
# ++++++ KILL a Process on remote machine ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Invoke-Command $remotepc {Stop-Process -Name "mer" -Force}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


$remotepc = 'xxx'