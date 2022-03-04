# Author:  Terry Wolfrey.  7/14/20
# Check machines for presence of installer file in C:\FLAGS\BIN\.
# Write sucesses/fails to separate log files.

# Set file and path variables here:
$timestamp = Get-Date -format "MMdd-HHmm"                                     # Set date/time variable to be used in output name. 
$work_dir = 'C:\Temp\PROJECTS\Workstation remediation\08-03-20 NoComm\'
$input_file = "$work_dir"+"hosts"+".txt"                     # Manually edit input file name.

$success_file = "$work_dir"+"FlagsBin_FileCheck_Success"+"_$timestamp"+".txt"
$error_file = "$work_dir"+"FlagsBin_FileCheck_Failures"+"_$timestamp"+".txt"

Write-Host "BEGIN file check script:" "$(Get-Date)" -F Green       # Echo script START time.
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Success file = $success_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.

$items = (Get-Content $InputFile | Measure-Object -Line).Lines
Write-Host "$items items in list" -B Magenta

# Loop
Get-Content $input_file | foreach {
    
    $Computer = $_
    Write-Host ""   # Blank Line for readability. 
    #Write-Host "$Computer"

    Write-Host "Testing $Computer for copy success." -F Yellow
    IF (Invoke-Command -Computername $Computer -Command {Test-Path C:\Flags\BIN\FramePkg_5.6.2.209_RTW_EPO_300.exe}){
        Write-Host "File found on $Computer" -F Green
        $Computer | Out-File -filepath "$success_file" -Append
        # Success beep, upward tones let you know an iteration is successful.
        [console]::beep(2000,300)
        [console]::beep(4000,300)
        }

    ELSE {
        Write-Host "FAILURE on $Computer" -B Red
        $Computer | Out-File -filepath "$error_file" -Append
        # Fail beep, downward tones let you know an iteration failed.
        [console]::beep(1000,300)
        [console]::beep(400,300) 
        }

    $items = $items - 1
    Write-Host "$items items remain in list" -B Magenta
    }

# Exit_notifications:
#region Exit_info
Write-Host ""   # Blank Line for readability. 
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Success file = $success_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.
Write-Host "End of file check script:" "$(Get-Date)" -F Green       # Echo script completion time. 


# Play sounds:
(New-Object Media.SoundPlayer "C:\WINDOWS\Media\ring08.wav").Play();

# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
# Say something
$voice.speak("Hey Terry. The file check results are done.") | Out-Null  #Out-Null prevents the return code from showing.

#endregion Exit_info

