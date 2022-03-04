$hostfile = "C:\TEMP\BOWLING\hostlist_2.txt"
$timestamp = Get-Date -format "dd-MMM-yyyy_HH-mm"    # Set date/time variable to be used in output name. In format: "24-Sep-2018_17-24"
#New Installs

Get-Content $hostfile | foreach {
    $Computer = $_
    $fileContents = $null

    If (Test-WSMan $Computer) {
    #Success
    Write-Host "Connection Test Success on $Computer" -ForegroundColor Green
    Write-Host "Checking XML File..." -ForegroundColor Yellow
    # Read in the file contents, update the BypassDownloader node's value, and save the file.

    #$fileLoc = "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\test.xml"
    $fileLoc = "\\$Computer\c$\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\VPNDisable_ServiceProfile.xml"

    [ xml ] $fileContents = Get-Content -Path $fileLoc
        
        if  ($fileContents.AnyConnectProfile.ClientInitialization.ServiceDisable -eq "true") {
        # Key present:
        Write-Host "The key is there" -ForegroundColor Green
        $Computer | Out-File -filepath "C:\TEMP\BOWLING\Success_install_$timestamp.txt" -Append
        Write-Host "$Computer Completed" -ForegroundColor Green 
        Write-Host ""   # A blank space for screen readability.

        # Success beep, upward tones let you know an iteration is successful.
        [console]::beep(2000,300)
        [console]::beep(4000,300)
        } 

        else {
        # Key NOT present:
        Write-Host "The key is NOT there" -ForegroundColor Red #-B White
        Write-Host "Fail on $Computer" -ForegroundColor Red
        Write-Host ""   # A blank space for screen readability. 
        $Computer | Out-File -filepath "C:\TEMP\BOWLING\Fail_install_$timestamp.txt" -Append

        # Fail beep, downward tones let you know an iteration failed.
        [console]::beep(1000,300)
        [console]::beep(400,300)
        }
    }
    Else {
    # Connection Fail
    Write-Host "Connection Test Fail on $Computer" -ForegroundColor Red -B White
    Write-Host ""   # A blank space for screen readability.
    $Computer | Out-File -filepath "C:\TEMP\BOWLING\Connection_Fail_$timestamp.txt" -Append

    # Fail beep, downward tones let you know an iteration failed.
    [console]::beep(1000,300)
    [console]::beep(400,300)
    }
}