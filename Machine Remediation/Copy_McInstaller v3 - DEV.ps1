# Author:  Terry Wolfrey.  7/14/20
# Copy McAfee installer file to C:Flags\BIN\.
# Write sucesses/fails to separate log files.

# Set file and path variables here:
$timestamp = Get-Date -format "MMdd-HHmm"                                     # Set date/time variable to be used in output name. 
$work_dir = "C:\Temp\PROJECTS\Workstation remediation\07-14-20 NoComm\"       # Manually edit working path.
$input_file = "$work_dir"+"hosts.txt"                                      # Manually edit input file name.

$success_file = "$work_dir"+"Copy_Success"+"_$timestamp"+".txt"
$error_file = "$work_dir"+"Copy_Failures"+"_$timestamp"+".txt"

# Loop
Get-Content $input_file | foreach {
    $Computer = $_
    Write-Host ""   # Blank Line for legibility.
    Write-Host "Testing connection on $Computer" -F Yellow

    If (Test-Path "\\$Computer\c$\Flags\BIN\") {
        Write-Host "Test Connection Successful on $Computer" -F Green
        Write-Host "Attempting to copy file to $Computer" -F Black -B Yellow
        Copy-Item –Path "C:\TOOLS\McAffee_Tools\FramePkg_5.6.2.209_RTW_EPO_300.exe" –Destination "\\$Computer\c$\Flags\BIN\" -Verbose
        
# PUT AN IF/ELSE TEST HERE?  Ternary Operator?        Why was I doing this?  What's wrong with V2?
# This was unnecessary because the copy works even if WinRM doesn't, and almost always succeeds. 
        Test-Path "\\$Computer\c$\Flags\BIN\FramePkg_5.6.2.209_RTW_EPO_300.exe"
        
        $Computer | Out-File -filepath "$success_file" -Append
        Write-Host "Install file copied to $Computer" -F Green
        # Success beep, upward tones let you know an iteration is successful.
        [console]::beep(2000,300)
        [console]::beep(4000,300)
        }

    Else {
        # Fail
        Write-Host "Test-WSMan FAILURE on $Computer" -F Red -B White
        $Computer | Out-File -filepath "$error_file" -Append
        # Fail beep, downward tones let you know an iteration failed.
        [console]::beep(1000,300)
        [console]::beep(400,300) 
        }

} # End of loop.

#region: Exit_notifications:
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Success file = $success_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.
Write-Host "End of Script:" "$(Get-Date)" -F Green

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

