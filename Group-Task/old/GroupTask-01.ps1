# Set date/time variable
$time = Get-Date -format "dd-mmm-yyyy_HH-mm"

# Take input from CSV and begin loop:
Import-Csv 'C:\temp\adobeconnect.csv' | foreach { 

    $computer = $_.computer
    $username = $_.user

    if (Test-WSMan -ComputerName $computer -ErrorAction Ignore) {
    Write-Output "Connecting to $computer" 
    Invoke-Command -computername $computer -command {sadmin recover -z CA23AF68D11B1D7; sadmin unso "C:\Users\$username\AppData\Roaming\Macromedia\Flash Player\www.macromedia.com\bin\adobeconnectaddin\adobeconnectaddin.exe"}
    Invoke-Command -computername $computer -command {sadmin lockdown}
    }

    else {
        Write-Warning -Message “Couldn’t connect to $computer”

        # WRITE OUT CSV LIST OF FAILED CONNECTIONS:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name user –Value $username
        $object | Add-Member –MemberType NoteProperty –Name computer –Value $computer
        $object | select user, Computer | export-csv "C:\temp\adobeconnect_output_$time.csv" -Append -NoTypeInformation
        } 
}