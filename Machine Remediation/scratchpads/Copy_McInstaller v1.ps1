# Group_Copy_Files
# Read machines names from file and copy McAfee Installer to them. Write sucesses/fail to separate log files.
 
$timestamp = Get-Date -format "MMdd-HHmm"    # Set date/time variable to be used in output name. 
$work_dir = 'C:\Temp\PROJECTS\Workstation remediation\07-10-20 Tanium\'

$input_file = "$work_dir"+"CopyList.txt"    # Manually edit input file name.
$output_file = "$work_dir"+"Copy_Success"+"_$timestamp"+".txt"        # Manually edit output file name.
$error_file = "$work_dir"+"Copy_Failures"+"_$timestamp"+".txt"

Write-Host "Input file = $input_file" -B DarkGreen      # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.

# Loop
Get-Content $input_file | foreach {
    $Computer = $_
    Write-Host ""            # Blank Line for legibility.
    Write-Host "Preparing to Test-Connection on $Computer" -F Yellow

    If (Test-Connection $Computer -Count 1) {
    Write-Host "Test Connection Successful on $Computer" -F Green
    
    Write-Host "Attempting to create directory on $Computer" -F Black -B Yellow
    Invoke-Command -Computername $Computer -Command {mkdir c:\EndpointTools}
    Invoke-Command -Computername $Computer -Command {dir C:\EndpointTools}

    Write-Host "Attempting to copy file to $Computer" -F Black -B Yellow
    Copy-Item –Path "C:\TOOLS\McAffee_Tools\FramePkg_5.6.2.209_RTW_EPO_300.exe" –Destination "\\$Computer\c$\EndpointTools" -Verbose
    
    Write-Host "Testing $Computer for copy success" -F Yellow
    Invoke-Command -Computername $Computer -Command {Test-Path C:\EndpointTools\FramePkg_5.6.2.209_RTW_EPO_300.exe}
        
    $Computer | Out-File -filepath "$output_file" -Append
    }

    Else {
    # Fail
    Write-Host "Test-Connection FAILURE on $Computer" -F Red
    $Computer | Out-File -filepath "$error_file" -Append
    }

} # End of loop.

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
$voice.speak("Hey Terry. The files are done copying.")

#endregion Exit_info

