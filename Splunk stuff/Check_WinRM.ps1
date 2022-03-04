# Check hosts for WinRM working.

$hostfile = "C:\Terry\415\TryWinRM.txt"
$timestamp = Get-Date -format "dd-MMM-HH-mm"    # Set date/time variable to be used in output name. In format: "24-Sep-2018_17-24"

Get-Content $hostfile | foreach {
    $Computer = $_

    If (Test-WSMan $Computer) {
    # Success
    Write-Host "Success on $Computer"
    $Computer | Out-File -filepath "C:\Terry\415\WinRM_Success_$timestamp.txt" -Append
    }
    Else {
    # Fail
    $Computer | Out-File -filepath "C:\Terry\415\WinRM_Fail_$timestamp.txt" -Append
    }
} 
Write-Host 'Script Complete' -B Yellow
# End