# Check machines for presence of file in C:\ENDPOINTTOOLS\.

$timestamp = Get-Date -format "MMdd-HHmm"    # Set date/time variable to be used in output name. 

$work_dir = 'C:\Temp\PROJECTS\Workstation remediation\07-10-20 Tanium\'
$input_file = "$work_dir"+"Copy_Failures_0714-1552"+".txt"    # Manually edit input file name.
$success_file = "$work_dir"+"EPtools_FileCheck_Success"+"_$timestamp"+".txt"        # Manually edit output file name.
$error_file = "$work_dir"+"EPtools_FileCheck_Failures"+"_$timestamp"+".txt"

# Loop
Get-Content $input_file | foreach {
    $Computer = $_
    Write-Host ""   # Blank Line
    #Write-Host "$Computer"

    Write-Host "Testing $Computer for copy success." -F Yellow
    IF (Invoke-Command -Computername $Computer -Command {Test-Path C:\EndpointTools\FramePkg_5.6.2.209_RTW_EPO_300.exe}){
        Write-Host "File found on $Computer" -F Green
        $Computer | Out-File -filepath "$success_file" -Append
        
        }

    ELSE {
        Write-Host "FAILURE on $Computer" -B Red
        $Computer | Out-File -filepath "$error_file" -Append
        
        }

[console]::beep(800,300)   # Beeps to let you know one iteration is complete.
    }

# Exit_notifications:
#region Exit_info
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "End of Script:" "$(Get-Date)" -F Green

# Play sounds:
(New-Object Media.SoundPlayer "C:\WINDOWS\Media\ring08.wav").Play();

# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
# Say something
$voice.speak("Hey Terry. The file check results are done.")

#endregion Exit_info

