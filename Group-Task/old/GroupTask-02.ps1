# Set date/time variable
$time = Get-Date -format "dd-mmm-yyyy_HH-mm"

# Take input from CSV and begin loop:
Import-Csv 'C:\temp\userlist.csv' | foreach { 

    $computer = $_.computer
    #$username = $_.user

    if (Test-WSMan -ComputerName $computer -ErrorAction Ignore) {
    Write-Output "Connecting to $computer" 
    Invoke-Command -computername $computer -command {sadmin recover -z CA23AF68D11B1D7;` 
    sadmin so "C:\Windows\SysWOW64\dlumd9.dll";`
    sadmin so "C:\Windows\SysWOW64\dlumd10.dll";`
    sadmin so "C:\Windows\SysWOW64\dlumd11.dll";`
    sadmin so 'C:\Windows\SysWOW64\dlumdfb10.dll';`
    sadmin so 'C:\Windows\SysWOW64\Macromed\Flash\Flash32_29_0_0_171.ocx';`
    sadmin so 'C:\Windows\SysWOW64\igd10iumd32.dll'
    }
        
    Invoke-Command -computername $computer -command {sadmin lockdown}
    }

    else {
        Write-Warning -Message “Couldn’t connect to $computer”

        # WRITE OUT CSV LIST OF FAILED CONNECTIONS:
        $object = New-Object –TypeName PSObject
        #$object | Add-Member –MemberType NoteProperty –Name user –Value $username
        $object | Add-Member –MemberType NoteProperty –Name computer –Value $computer
        $object | select user, Computer | export-csv "C:\temp\GroupTask_Output_$time.csv" -Append -NoTypeInformation
        } 
}