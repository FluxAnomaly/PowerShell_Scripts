

$remotepc = 'LF2R2JR2,LGLH6JR2,LHC656H2,L5TWHZ52,L40M1JR2'    # This won't work as is. 

# This FAILS because the variable isn't available inside the scope of the script block {}.  Need to pass the variable?  Investigate '$Using:'  Ex: $Using:ps
ForEach-Object ($remotepc) {
Copy-Item -Path "\\$remotepc\c$\Flags\BIN\$remotepc-MERout.tgz" -Destination 'C:\Temp\PROJECTS\PS_crashing' -Verbose
}


ForEach-Object ($remotepc) {
Copy-Item -Path "\\$_\c$\Flags\BIN\$_-MERout.tgz" -Destination 'C:\Temp\PROJECTS\PS_crashing' -Verbose
}



# In the following example, the $ps variable is created in the local session, but is used in the session in which the command runs. 
# The Using scope modifier identifies $ps as a local variable.
$ps = "Windows PowerShell"
Invoke-Command -ComputerName S1 -ScriptBlock {
  Get-WinEvent -LogName $Using:ps
}


# This example works:   Build on it.
$ps = "Windows PowerShell"

Invoke-Command -ComputerName L5CG54138LC -ScriptBlock {
  Get-WinEvent -LogName $Using:ps
}



<# NOTES:

$_
The current pipeline object; used in script blocks, filters, the process clause of functions, where-object, foreach-object and switch (current object)

#>