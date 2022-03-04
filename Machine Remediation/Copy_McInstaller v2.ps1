# Author:  Terry Wolfrey.  7/14/20
# Copy McAfee installer file to C:Flags\BIN\.
# Write sucesses/fails to separate log files.

# Set file and path variables here:
$timestamp = Get-Date -format "MMdd-HHmm"                                     # Set date/time variable to be used in output name. 
$work_dir = 'C:\Projects\Agent issues\10-19-20 Tanium\'
$input_file = "$work_dir"+"targets"+".txt"

# Outputs:
$success_file = "$work_dir"+"Copy_Success"+"_$timestamp"+".txt"
$error_file = "$work_dir"+"Copy_Failures"+"_$timestamp"+".txt"

# I/O statements:
Write-Host "BEGIN file copy script:" "$(Get-Date)" -F Green       # Echo script START time.
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
    Write-Host ""   # Blank Line for legibility.
    Write-Host "Testing connection on $Computer" -F Yellow

    # Changed the test because the copy works even if WinRM doesn't  (Before:  Test-WSMan $Computer)
    If (Test-Path "\\$Computer\c$\Flags\BIN\") {
        Write-Host "Test Connection SUCCESSFUL on $Computer" -F Green    
        Write-Host "Attempting to copy file to $Computer" -F Black -B Yellow
        Copy-Item –Path "C:\TOOLS\McAffee_Tools\FramePkg_5.6.2.209_RTW_EPO_300.exe" –Destination "\\$Computer\c$\Flags\BIN\" -Verbose
        
        $Computer | Out-File -filepath "$success_file" -Append
        Write-Host "Install file copied to $Computer" -F Green
        # Success beep, upward tones let you know an iteration is successful.
        [console]::beep(2000,300)
        [console]::beep(4000,300)
        }

    Else {
        # Fail
        Write-Host "Test Connection FAILURE on $Computer" -F Red -B White
        $Computer | Out-File -filepath "$error_file" -Append
        # Fail beep, downward tones let you know an iteration failed.
        [console]::beep(1000,300)
        [console]::beep(400,300)   
        }
    
    # Counter: lines remaining.
    $ItemsLeft = $ItemsLeft - 1
    Write-Host "$ItemsLeft of $items items remain" -B Magenta

} # End of loop.

#region: Exit_notifications:
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Success file = $success_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.
Write-Host "End of file copy script:" "$(Get-Date)" -F Green

# Play sound:
(New-Object Media.SoundPlayer "C:\WINDOWS\Media\ring08.wav").Play();

# PLAY SPEECH:
# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
# Say something
$voice.speak("Hey Terry. The file copy script is done.") | Out-Null  #Out-Null prevents the return code from showing.

#endregion: Exit_notifications.

