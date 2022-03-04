# Set date/time variable
$time = Get-Date -format "dd-mmm-yyyy_HH-mm"

# Take input from CSV and begin loop:
Import-Csv 'C:\temp\adobeconnect.csv' | foreach { 

    $computer = $_.computer
    $username = $_.user

    # --------------------------------------------------------------------------------- #
    # Begin IF statement:
    if (Test-WSMan -ComputerName $computer -ErrorAction Ignore) {
    Write-Host ""  # Writes blank line for easier reading.
    Write-Host "Connecting to $computer" -ForegroundColor yellow

    # Begin commands inside IF statement:
    Invoke-Command -computername $computer -command {sadmin recover -z CA23AF68D11B1D7;` 
    sadmin unso "C:\Users\$username\AppData\Roaming\Macromedia\Flash Player\www.macromedia.com\bin\adobeconnectaddin\adobeconnectaddin.exe"
        }

    Invoke-Command -computername $computer -command {sadmin lockdown} | Write-Host -ForegroundColor green
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