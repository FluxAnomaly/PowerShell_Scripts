# Advanced version of Group-Task looping script.
# Input file is expected to be in same folder as script.
# Output file is also set to be in same folder as script.

$time = Get-Date -format "dd-MMM_HH-mm"    # Sets date/time variable to be used in output name. In format: 24-Sep_17-24
$input_file = '.\userlist.csv'                  
$output_tag = "$time-ENABLE-output"        # Manually Edit XX to modify that part of output file name.

Write-Host "Input file = $input_file" -B DarkGreen      # Echo name of input file.

# Take input from CSV and begin loop:
Import-Csv $input_file | foreach { 

    $computer = $_.computer
    $username = $_.user

    Write-Host ""     # Writes blank line for better on screen formatting.

    if (Test-WSMan -ComputerName $computer -ErrorAction Ignore) {

        Write-Host "Connecting to $computer" -ForegroundColor yellow

            # Commands to execute go between the {} braces here.  *See further notes below
            Invoke-Command -computername $computer -command { ` 
            sadmin recover -z CA23AF68D11B1D7;`
            sadmin eo;`
            sadmin eu;`
            sadmin enable;`
            sadmin status;`
            sadmin lockdown | Write-Host -ForegroundColor green
            }

        } 

    else {
        # Write error message to screen.
        Write-Host “Couldn’t connect to $computer” -B Magenta

        # WRITE OUT CSV LIST OF FAILED CONNECTIONS:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name computer –Value $computer
        $object | Add-Member –MemberType NoteProperty –Name user –Value $username
        $object | select Computer, User | export-csv ".\$output_tag.csv" -Append -NoTypeInformation
        } 

}
Write-Host “Error log saved to .\$output_tag.csv” -B DarkRed -F White

<# 
Notes:
Semicolons ; let you string multiple commands together.
back ticks ` tell powershell to move to the next line but treat it like it's on the same one. 
the last command does NOT need to be followed by ; or `

This script is designed to take a two colum CSV of Computername & Username.  But if you are only using one you can ignore the other with no problem. 
The output file is a list of failed connections.  
#>

<# 
Bug List:

1. Write-Host formatting commands needs some work. 

#>
