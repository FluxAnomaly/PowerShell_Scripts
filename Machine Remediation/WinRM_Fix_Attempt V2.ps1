# Author:  Terry Wolfrey.  8/3/20
# Test list of machines for WinRM working. 
# If fail try fix.
# Write sucesses/fails to separate log files.

# NOTE:  Trying to shave time off by not running repair attempts on machines which already have WinRM running. 

# Set file and path variables here:
$timestamp = Get-Date -format "MMdd-HHmm"                                     # Set date/time variable to be used in output name. 
$work_dir = 'C:\Temp\PROJECTS\Workstation remediation\07-29-20 Tanium\'
$input_file = "$work_dir"+"targetlist"+".txt"                    # Manually edit input file name.

$success_file = "$work_dir"+"WinRM-Fix_Success"+"_$timestamp"+".txt"
$error_file = "$work_dir"+"WinRM-Fix_Failures"+"_$timestamp"+".txt"

# Loop
Get-Content $input_file | foreach {
    $Computer = $_
    Write-Host ""   # Blank Line
    Write-Host ""   # Blank Line
    Write-Host "$Computer : Attempting to fix WinRM" -B Black -F Yellow

    Write-Host "Getting IP address. But not currently used in script."
    $HostIP = (Test-Connection -Count 1 $Computer).IPV4Address.IPAddressToString; Write-host $hostip
    
    if (Test-WSMan $Computer -ErrorAction SilentlyContinue) {$testWinRM = $true} else {$testWinRM = $false}
    #$WinRMstatus = Invoke-Command -ComputerName $Computer {(GWMI Win32_Service -Filter "Name='WinRM'").state -eq 'Running'}
    #Write-Host "WinRM running on $Computer is: $WinRMstatus"
    
    If ($WinRMstatus) {
        Write-Host "$Computer : WinRM WORKING" -F Green
        $Computer | Out-File -filepath "$success_file" -Append

        # SUCCESS beep, upward tones let you know an iteration is successful.
        [console]::beep(2000,300)
        [console]::beep(4000,300)
        }

    Else {
        Write-Host "$Computer : WinRM test failed, attempting repair..." -F Red -B White

        if ($WinRMstatus -ne $true) {
        
            Write-Host "$Computer : Starting PSexec" -F Yellow
            # Attempt to Use PsExec to connect to host and start winrm.cmd (Windows Remote Mgmt.) You can use HOSTNAME or IP. 
            #C:\tools\pstools\psexec -h -s -e -d \\$HostIP winrm.cmd quickconfig -q  
            # When you can't start a PSsession, use this with HOSTNAME or IP:
            #C:\tools\PSTools\PsExec64.exe -s -d \\$HostIP powershell.exe "enable-psremoting -force"

            # Attempt to Use PsExec to connect to host and start winrm.cmd (Windows Remote Mgmt.) You can use HOSTNAME or IP. 
            C:\tools\pstools\psexec -h -s -e -d \\$Computer winrm.cmd quickconfig -q 
            # When you can't start a PSsession, use this with HOSTNAME or IP:
            C:\tools\PSTools\PsExec64.exe -s -d \\$Computer powershell.exe "enable-psremoting -force"
        
            # Give service time to start.
            Start-Sleep -Seconds 3

            if (Test-WSMan $Computer -ErrorAction SilentlyContinue) {$testWinRM = $true} else {$testWinRM = $false}
            #$WinRMstatus = Invoke-Command -ComputerName $_ {(GWMI Win32_Service -Filter "Name='WinRM'").state -eq 'Running'}

                if ($WinRMstatus) {
                    Write-Host "$Computer : WinRM REPAIRED" -F Black -B Green
                    $Computer | Out-File -filepath "$success_file" -Append
                
                    # SUCCESS beep, upward tones let you know an iteration is successful.
                    [console]::beep(2000,300)
                    [console]::beep(4000,300)
                    }

                else {
                    Write-Host "$Computer : WinRM repair attempt FAILED" -F White -B Red 
                    $Computer | Out-File -filepath "$error_file" -Append
                
                    # FAIL beep, downward tones let you know an iteration failed.
                    [console]::beep(1000,300)
                    [console]::beep(400,300)
                    }

            }

            #else {}  # This ELSE is NOT used.
                
        }

    } # End of loop.


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
$voice.speak("The WinRM repair script has completed.") | Out-Null  #Out-Null prevents the return code from showing.

#endregion Exit_info

