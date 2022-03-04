# Set date/time variable
$time = Get-Date -format "dd-MM-yyyy_HH-mm"

# Take input from CSV and begin loop:
Import-Csv 'C:\temp\adobeconnect.csv' | foreach { 

    $computer = $_.computer
    $username = $_.user

    # Begin IF statement --------------------------------------------------------------- #

    if (Test-WSMan -ComputerName $computer -ErrorAction Ignore) {
    Write-Host ""  # Writes blank line for easier reading.
    Write-Host "Connecting to $computer" -ForegroundColor yellow

    # Begin commands inside IF statement:
    Invoke-Command -computername $computer -command {sadmin recover -z CA23AF68D11B1D7;` 
    sadmin so "C:\Windows\SysWOW64\dlumd9.dll";`
    sadmin so "C:\Windows\SysWOW64\dlumd10.dll";`
    sadmin so "C:\Windows\SysWOW64\dlumd11.dll";`
    sadmin so 'C:\Windows\SysWOW64\dlumdfb10.dll';`
    sadmin so 'C:\Windows\SysWOW64\Macromed\Flash\Flash32_29_0_0_171.ocx';`
    sadmin so 'C:\Windows\SysWOW64\igd10iumd32.dll'
    }
    
    # Lockdown after commands run
    Invoke-Command -computername $computer -command {sadmin lockdown} | Write-Host -ForegroundColor green
    Write-Host ""  # Writes blank line for easier reading on screen.
    } 
    # end IF statement ---------------------------------------------------------------- #

    else {
        # Write error message to screen.
        Write-Host “Couldn’t connect to $computer” -B Magenta

        # WRITE OUT CSV LIST OF FAILED CONNECTIONS:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name user –Value $username
        $object | Add-Member –MemberType NoteProperty –Name computer –Value $computer
        $object | select user, Computer | export-csv "C:\temp\adobeconnect_output_$time.csv" -Append -NoTypeInformation
        } 
}