$hostfile = "C:\TEMP\BOWLING\hostlist.txt"
$timestamp = Get-Date -format "dd-MMM-yyyy_HH-mm"    # Set date/time variable to be used in output name. In format: "24-Sep-2018_17-24"
#New Installs

Get-Content $hostfile | foreach {
    $Computer = $_
    $fileContents = $null

    If (Test-WSMan $Computer) {
    #Success
    Write-Host "Connection Test Success on $Computer" -ForegroundColor Green
    Write-Host "Checking XML File..." -ForegroundColor Green
    # Read in the file contents, update the BypassDownloader node's value, and save the file.

    #$fileLoc = "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\test.xml"
    $fileLoc = "\\$Computer\c$\TEMP\BOWLING\VPNDisable_ServiceProfile.xml"

    [ xml ] $fileContents = Get-Content -Path $fileLoc
        
        if  ($fileContents.AnyConnectProfile.ClientInitialization.ServiceDisable -eq "true") {
        Write-Host "The key is there" -ForegroundColor Green
        $Computer | Out-File -filepath "C:\TEMP\BOWLING\Success_install_$timestamp.txt" -Append
        Write-Host "$Computer Completed" -ForegroundColor Green 
        } 
        else {
        Write-Host "The key is not there" -ForegroundColor Green
        Write-Host "Fail on $Computer" -ForegroundColor Magenta
        $Computer | Out-File -filepath "C:\TEMP\BOWLING\Fail_install_$timestamp.txt" -Append
        }
    }
    Else {
    # Fail
    Write-Host "Connection Test Fail on $Computer" -ForegroundColor Magenta
    $Computer | Out-File -filepath "C:\TEMP\BOWLING\Connection_Fail_$timestamp.txt" -Append
    }
}