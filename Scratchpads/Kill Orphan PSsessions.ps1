
# Source:   ???

# Terminate open PowerShell session on a remote machine:

# The remote jobs would run under a wsmprovhost.exe process per job. You should be able to brute force terminate these processes 
# with WMI - or even remotely reboot the machine. You run the risk of killing hosted jobs for other users/activities, of course.

# This would terminate all wsmprovhost.exe processes on the computer named (or array of computer names):

$remotepc = 'L32LDTN2'

(gwmi win32_process -ComputerName $remotepc) |? 
    { $_.Name -imatch "wsmprovhost.exe" } |% 
    { $_.Name; $_.Terminate() }



# Not working for me; prompts for more info, properties, etc.