# Remote security event generator:

$MyCred = Get-Credential -Credential US\an458060ad    # Run this line once to store credentials.

# Read the hostname file content here:
$inputfile = "C:\Terry\hosts.txt"
$list = get-content $inputfile

# Loop here:

ForEach ($item in $list) {
    #$HostIP = ""
    
    $HostIP = (Test-Connection -Count 1 $item).IPV4Address.IPAddressToString
    Write-host "The IP for $line is $HostIP Sending commands to $HostIP"

    
    Invoke-Command $HostIP {net localgroup WolfreyTest /add} -credential $MyCred
    Invoke-Command $HostIP {net user Wolfrey Insanity8086! /add} -credential $MyCred

    #Start-Sleep -Second 3

    Invoke-Command $HostIP {net localgroup WolfreyTest /delete} -credential $MyCred
    Invoke-Command $HostIP {net user Wolfrey /delete} -credential $MyCred
    
}


# Scratchpad below here:

$HostIP = (Test-Connection -Count 1 25WD9H2).IPV4Address.IPAddressToString
$HostIP