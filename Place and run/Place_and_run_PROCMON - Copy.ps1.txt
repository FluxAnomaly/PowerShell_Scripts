# Copy ProcMon w/ config file, remotely execute, then retrieve results:  
# This is meant to be run from your machine with no session to remote machine. 
# By using a known existing path (C:\flags\bin\) on the host you avoid having to create a directory. 

$remotepc = 'Host'

# Copy tool over:
Copy-Item –Path 'C:\TOOLS\ProcessMonitor\Procmon.exe' –Destination "\\$remotepc\c$\Flags\BIN\"
Copy-Item –Path 'C:\TOOLS\ProcessMonitor\ProcmonConfig.pmc' –Destination "\\$remotepc\c$\Flags\BIN\"


# #### RUN Process Monitor  ############################################################
    # Command will appear to hang but ProcMon starts, use CTRL-C to get control back and run the terminate line. 
C:\tools\PSTools\PSEXEC.exe -H -S -E -I 0 \\$remotepc C:\FLAGS\BIN\PROCMON.EXE /ACCEPTEULA /BACKINGFILE "C:\FLAGS\BIN\$remotepc-ProcMon.PML" /LOADCONFIG "C:\FLAGS\BIN\ProcmonConfig.pmc" /QUIET
    
    # Terminate ProcMon. Takes about 10 - 20 seconds. 
C:\tools\PSTools\PSEXEC.exe -H -S -E -I 0 \\$remotepc C:\FLAGS\BIN\PROCMON.EXE /TERMINATE
#########################################################################################


# ---- Copy results files: ------------------------------------------------------------------------------
Copy-Item -Path "\\$remotepc\c$\Flags\BIN\$remotepc-ProcMon.PML" -Destination 'c:\temp\ContentIE_data'


# Check contents of the directory 
Invoke-Command $remotepc {dir C:\Flags\BIN}




# Additional stuff:
# ++++++ KILL a Process on remote machine ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Invoke-Command $remotepc {Stop-Process -Name "XXX" -Force}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++