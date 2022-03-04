# Set date/time variable
$time = Get-Date -format "dd-MM-yyyy_HH-mm"

# Take input from CSV and begin loop:
Import-Csv 'C:\temp\sau_userlist.csv' | foreach { 

    $computer = $_.computer
    $username = $_.user

    # Begin IF statement --------------------------------------------------------------- #

    if (Test-WSMan -ComputerName $computer -ErrorAction Ignore) {
    Write-Host ""  # Writes blank line for easier reading.
    Write-Host "Connecting to $computer" -ForegroundColor yellow

    # Begin commands inside IF statement:
    Invoke-Command -computername $computer -command {mkdir c:\McAfee_MER}
    Copy-Item –Path 'C:\Users\af75244\Downloads\McAffee Tools\MER.exe' –Destination "\\$computer\c$\McAfee_MER"

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
        $object | select user, Computer | export-csv "C:\temp\PlaceMER_output_$time.csv" -Append -NoTypeInformation
        } 
}