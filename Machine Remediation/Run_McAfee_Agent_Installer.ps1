# Author:  Terry Wolfrey.  7/14/20
# McAfee Agent Installer:  Iterates through list of machines and runs Agent install.
# Write sucesses/fails to separate log files.

# Set file and path variables here:
$timestamp = Get-Date -format "MMdd-HHmm"                                     # Set date/time variable to be used in output name.
$work_dir = 'C:\Projects\Agent issues\10-19-20 Tanium\'
$input_file = "$work_dir"+"targets"+".txt"                                   # Manually edit input file name.

# Outputs:
$success_file = "$work_dir"+"Install_Successes"+"_$timestamp"+".txt"
$error_file = "$work_dir"+"Install_Failures"+"_$timestamp"+".txt"

# I/O statements:
Write-Host "BEGIN Agent Installer Script:" "$(Get-Date)" -F Green       # Echo script START time.
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
    Write-Host ""   # Print blank line for on-screen legibility. 
    Write-Host ""   # Print blank line for on-screen legibility. 
    Write-Host "$(Get-Date)" -F Yellow 
    Write-Host "Testing connection to $Computer" -F Black -B Yellow
    
    IF (Invoke-Command $Computer {Test-Path -Path c:\Flags\BIN\FramePkg_5.6.2.209_RTW_EPO_300.exe}) {
        Write-Host "Attempting to install on $Computer. Please wait, this make a take a while." -F Yellow
        Invoke-Command -Computername $Computer -Command {c:\Flags\BIN\FramePkg_5.6.2.209_RTW_EPO_300.exe /install=agent /forceinstall /SILENT}
        Write-Host "Completed attempt on $Computer" -F Green

        # ============================================================================================
        # I really should put a test condition here where failure writes to the fail log.
        Write-Host "Checking $Computer for running agent service MASVC"
        Invoke-Command -Computername $Computer -Command {Get-Service -Name "MASVC"}
        $Computer | Out-File -filepath "$success_file" -Append

        # Success beep, upward tones let you know an iteration is successful.
        [console]::beep(2000,300)
        [console]::beep(4000,300)
        }

    ELSE {
        Write-Host "Install file not found on $Computer" -F Red
        $Computer | Out-File -filepath "$error_file" -Append      
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
Write-Host "End of Agent Installer Script:" "$(Get-Date)" -F Green       # Echo script completion time. 


# Play sound:
(New-Object Media.SoundPlayer "C:\WINDOWS\Media\ring08.wav").Play();

# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
# Say something
$voice.speak("Yo homeboy. Your installer script is finished running.") | Out-Null  #Out-Null prevents the return code from showing.
#endregion