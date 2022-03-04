# Author:  Terry Wolfrey.  7/14/20
# Try to get WinRM service running on list of machines.
# Write sucesses/fails to separate log files.
# Control + M. Collapses all Regions.   https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/ise/keyboard-shortcuts-for-the-windows-powershell-ise?view=powershell-7

# Set file and path variables here:
$timestamp = Get-Date -format "MMdd-HHmm"                                     # Set date/time variable to be used in output name. 
$work_dir = 'C:\Projects\Agent issues\10-19-20 Tanium\'
$input_file = "$work_dir"+"Copy_Success_1021-1043"+".txt"                    # Manually edit input file name.

# Outputs:
$success_file = "$work_dir"+"WinRM-Fix_Success"+"_$timestamp"+".txt"
$error_file = "$work_dir"+"WinRM-Fix_Failures"+"_$timestamp"+".txt"

# I/O statements:
Write-Host "BEGIN WinRM repair script:" "$(Get-Date)" -F Green       # Echo script START time. 
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Success file = $success_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.

# Initialize line counter:
$Items = (Get-Content $input_file | Measure-Object -Line).Lines
Write-Host "$Items items in list" -B Magenta
$ItemsLeft = $Items

# Loop
Get-Content $input_file | foreach {
    $Computer = $_
    Write-Host ""   # Blank Line
    Write-Host "Attempting to fix WinRM on $Computer." -F Yellow

    $HostIP = (Test-Connection -Count 1 $Computer).IPV4Address.IPAddressToString; Write-host $hostip

    # Attempt to Use PsExec to connect to host and start winrm.cmd (Windows Remote Mgmt.) You can use HOSTNAME or IP. 
    c:\tools\pstools\psexec -h -s -e -d \\$HostIP winrm.cmd quickconfig -q  
    # When you can't start a PSsession, use this with HOSTNAME or IP:
    C:\tools\PSTools\PsExec64.exe -s -d \\$HostIP powershell.exe "enable-psremoting -force"

    If (Test-WSMan $Computer) {
        $Computer | Out-File -filepath "$success_file" -Append
        Write-Host "WinRM fixed on $Computer" -F Green
        # Success beep, upward tones let you know an iteration is successful.
        [console]::beep(2000,300)
        [console]::beep(4000,300)
        }

    Else {
        $Computer | Out-File -filepath "$error_file" -Append
        Write-Host "WinRM FAILED on $Computer" -F Red -B White
        # Fail beep, downward tones let you know an iteration failed.
        [console]::beep(1000,300)
        [console]::beep(400,300)         
        }

    # Counter: lines remaining.
    $ItemsLeft = $ItemsLeft - 1
    Write-Host "$ItemsLeft of $items items remain" -B Magenta

    } # End of loop.

# Exit_notifications:
#region Exit_info
Write-Host ""   # Print blank line for on-screen legibility. 
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Success file = $success_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.
Write-Host "End of WinRM repair script:" "$(Get-Date)" -F Green       # Echo script completion time. 


# Play sound:
(New-Object Media.SoundPlayer "C:\WINDOWS\Media\ring08.wav").Play();

# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
# Say something
$voice.speak("The WinRM repair script has completed.") | Out-Null  #Out-Null prevents the return code from showing.

#endregion Exit_info
Write-Host ""
Write-Host ""

