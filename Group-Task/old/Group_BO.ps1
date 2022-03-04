# Set date/time variable in format:    24-Sep_17-24
$time = Get-Date -format "dd-MMM_HH-mm"

$input_file = '.\EndObserve_userlist.csv'
Write-Host "Input file = $input_file" -B DarkGreen

# Take input from CSV and begin loop:
Import-Csv $input_file | foreach { 

    $computer = $_.computer
    $username = $_.user

    # Begin IF statement --------------------------------------------------------------- #

    if (Test-WSMan -ComputerName $computer -ErrorAction Ignore) {
    Write-Host ""  # Writes blank line for easier reading.
    Write-Host "Connecting to $computer" -ForegroundColor yellow

    # Begin commands inside IF statement:
    Invoke-Command -computername $computer -command {sadmin recover -z CA23AF68D11B1D7;` 
    sadmin eo;`
    #sadmin features disable sau;`
    #sadmin unso "C:\Users\$user\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5"
    sadmin aefi add file begins "C:\Users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5"
    }
    
    # Lockdown after commands run
    Invoke-Command -computername $computer -command {sadmin lockdown} | Write-Host -ForegroundColor green
    #Write-Host ""  # Writes blank line for easier reading on screen.   #This results in double space between successes but single space before failure group. 
    } 
    # end IF statement ---------------------------------------------------------------- #

    else {
        # Write error message to screen.
        Write-Host “Couldn’t connect to $computer” -B Magenta

        # WRITE OUT CSV LIST OF FAILED CONNECTIONS:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name computer –Value $computer
        $object | Add-Member –MemberType NoteProperty –Name user –Value $username
        $object | select Computer, User | export-csv ".\$time-EndObserve-output.csv" -Append -NoTypeInformation
        } 
}