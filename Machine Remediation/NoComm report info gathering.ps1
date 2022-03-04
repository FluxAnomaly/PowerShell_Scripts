# Author:  Terry Wolfrey.
# McAfee Agent info gathering.  masvc

$timestamp = Get-Date -format "MMdd-HHmm"    # Set date/time variable to be used in output name. 
$work_dir = 'C:\Temp\PROJECTS\Workstation remediation\07-27-20 NoComm\'
$input_file = "$work_dir"+"hostlist.txt"                     # Manually edit input file name.
$output_file = "$work_dir"+"$timestamp-NoComm-Checks"        # Manually edit output file name.

Write-Host "Input file = $input_file" -B DarkGreen      # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.

# Take input from text file and begin loop:
Get-Content $input_file | foreach {

        Write-Host "Testing $_" -F Yellow

        # Grab host IP address:
        $HostIP = (Test-Connection -Count 1 $_).IPV4Address.IPAddressToString
            Write-Host "IP for $_ is $HostIP"
        
        # Check if WinRM is running and store as Boolean TRUE/FALSE.
        Write-Host "Checking WinRM on $_"
        $WinRM = Invoke-Command -ComputerName $_ {(GWMI Win32_Service -Filter "Name='WinRM'").state -eq 'Running'}
            Write-Host "WinRM on $_ : $WinRM"

        # Check if McAfee Agent EXE exists.
        Write-Host "Checking path on $_"
        $McPath = Test-Path "\\$_\C$\Program Files\McAfee\agent\masvc.exe"
        
        # Check McAfee Agent status & start type. 
        Write-Host "Checking agent service on $_"
        $masvc = Get-Service -Name masvc -computername $_ | select Status,StartType 
            Write-Host "McAfee Agent is ($masvc).Status"
            Write-Host ""

        # WRITE OUT RESULTS TO CSV FILE:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name Host –Value $_
        $object | Add-Member –MemberType NoteProperty –Name IP –Value $HostIP
        $object | Add-Member –MemberType NoteProperty –Name Exe_found -Value $McPath
        $object | Add-Member –MemberType NoteProperty –Name masvc_Status –Value ($masvc).Status
        $object | Add-Member –MemberType NoteProperty –Name StartType –Value ($masvc).StartType
        $object | Add-Member –MemberType NoteProperty –Name WinRM –Value $WinRM

        $object | select Host, IP, Exe_exist, masvc_Status, StartType, WinRM | export-csv "$output_file.csv" -Append -NoTypeInformation

        # Beep to indicate completion of a loop.
        [console]::beep(2000,300)
        }


# Exit_notifications:
#region Exit_info
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.
Write-Host "End of Script:" "$(Get-Date)" -F Green

# Play sounds:
(New-Object Media.SoundPlayer "C:\WINDOWS\Media\ring08.wav").Play();

# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
# Say something
$voice.speak("The No Comm script has completed.") | Out-Null  #Out-Null prevents the return code from showing.

#endregion Exit_info
Write-Host ""  # Blank line for readability. 
