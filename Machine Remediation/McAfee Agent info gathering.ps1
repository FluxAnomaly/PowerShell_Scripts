# McAfee Agent info gathering.  masvc

$timestamp = Get-Date -format "MMdd-HHmm"    # Set date/time variable to be used in output name. 
$work_dir = 'C:\Temp\PROJECTS\Tanium cleanup\06-01-20\'
$input_file = "$work_dir"+"hostlist.txt"    # Manually edit input file name.
$output_file = "$work_dir"+"$timestamp-McAgent-Checks"        # Manually edit output file name.

Write-Host "Input file = $input_file" -B DarkGreen      # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.

# Take input from text file and begin loop:
Get-Content $input_file | foreach {

        Write-Host "Testing $_" -F Yellow

        $HostIP = (Test-Connection -Count 1 $_).IPV4Address.IPAddressToString
            Write-Host "IP for $_ is $HostIP"
        
        $WinRM = Invoke-Command -ComputerName $_ {(GWMI Win32_Service -Filter "Name='WinRM'").state -eq 'Running'}
            Write-Host "WinRM on $_ : $WinRM"

        $masvc = Get-Service -Name masvc -computername $_ | select Status,StartType 
            Write-Host "McAfee Agent is ($masvc).Status"
            Write-Host ""

        # WRITE OUT RESULTS TO CSV FILE:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name Host –Value $_
        $object | Add-Member –MemberType NoteProperty –Name IP –Value $HostIP
        $object | Add-Member –MemberType NoteProperty –Name masvc_Status –Value ($masvc).Status
        $object | Add-Member –MemberType NoteProperty –Name StartType –Value ($masvc).StartType
        $object | Add-Member –MemberType NoteProperty –Name WinRM –Value $WinRM

        $object | select Host, IP, masvc_Status, StartType, WinRM | export-csv "$output_file.csv" -Append -NoTypeInformation

        }

Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.
Write-Host "End of Script:" "$(Get-Date)" -F Green