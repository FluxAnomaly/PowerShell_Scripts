
Test-WSMan -ComputerName $computer -ErrorAction Ignore

Write-Host "WinRM failed on Blah" -F Red -B White

$Splunkexe = $true
$Splunkexe = $false

Write-Host "Splunk.exe present on machine is " -nonewline; Write-Host "$Splunkexe" -F Red


# Ternary operations:

$result = If ($condition) {"true"} Else {"false"}

If ($Splunkexe) {Write-Host "$Splunkexe" -F Green} Else {Write-Host "$Splunkexe" -F Red}



# Works:

Write-Host "Splunk.exe present on machine is " -nonewline; If ($Splunkexe) {Write-Host "$Splunkexe" -F Green} Else {Write-Host "$Splunkexe" -F Red}

# Also works, but not how I need:
$Splunkexe = $true
$Splunkexe = $false

$TrueDat = {Write-Host "$Splunkexe" -F Green}
$FalseDat = {Write-Host "$Splunkexe" -F Red}
Write-Host "Splunk.exe present on machine is " -nonewline; If ($Splunkexe) {& $TrueDat} Else {& $FalseDat}


# Sorta works:
$Splunkexe = $true
$Splunkexe = $false
$Splunkexe = Test-Path "c:\Program Files\SplunkUniversalForwarder\bin\splunk.exe"

$TrueMsg = {Write-Host "True" -F Green}
$FalseMsg = {Write-Host "False" -F Red}

Write-Host "Splunk.exe present on host. " -nonewline; If ($Splunkexe) {& $TrueMsg} Else {& $FalseMsg}




