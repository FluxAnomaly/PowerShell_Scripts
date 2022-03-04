# Splunk info gathering.

$MyCred = Get-Credential -Credential US\an458060ad    # Run this line once to store credentials.

$timestamp = Get-Date -format "MMdd-HHmm"    # Set date/time variable to be used in output name. 
$work_dir = 'C:\Terry\420\'
$input_file = "$work_dir"+"hostlist.txt"    # Manually edit input file name.
$output_file = "$work_dir"+"$timestamp-Splunk-Checks"        # Manually edit output file name.
$error_file = "$work_dir"+"$timestamp-WinRM_Failed_.txt"     # Manually edit error file name.

Write-Host "Input file = $input_file" -B DarkGreen      # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.

# Take input from text file and begin loop:
Get-Content $input_file | foreach { 

    if (Test-WSMan $_ -ErrorAction Ignore) {
        Write-Host "Testing $_" -F Yellow

        $HostIP = (Test-Connection -Count 1 $_).IPV4Address.IPAddressToString
            Write-Host "IP for $_ is $HostIP"
        $Splunkexe = Test-Path "\\$_\C$\Program Files\SplunkUniversalForwarder\bin\splunk.exe"
            Write-Host "Splunk.exe present on $_ is $Splunkexe"
        $InputsConf = Test-Path "\\$_\c$\Program Files\SplunkUniversalForwarder\etc\apps\nms-aoc-winevents\default\inputs.conf"
            Write-Host "inputs.conf present on $_ is $InputsConf"
        $SplunkSVC = Invoke-Command -ComputerName $_ {(GWMI Win32_Service -Filter "Name='SplunkForwarder'").state -eq 'Running'} -credential $MyCred
            Write-Host "Splunk service running on $_ is $SplunkSVC"
        $WinVer = Invoke-Command -ComputerName $_ {[System.Environment]::OSVersion.Version.Major} -credential $MyCred
            Write-Host "$_ is running Windows $WinVer"
            Write-Host ""

        # WRITE OUT RESULTS TO CSV FILE:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name Host –Value $_
        $object | Add-Member –MemberType NoteProperty –Name IP –Value $HostIP
        $object | Add-Member –MemberType NoteProperty –Name Splunkexe –Value $Splunkexe
        $object | Add-Member –MemberType NoteProperty –Name InputsConf –Value $InputsConf
        $object | Add-Member –MemberType NoteProperty –Name SplunkSVC –Value $SplunkSVC
        $object | Add-Member –MemberType NoteProperty –Name WinVer –Value $WinVer

        $object | select Host, IP, Splunkexe, InputsConf, SplunkSVC, WinVer | export-csv "$output_file.csv" -Append -NoTypeInformation   

        }

    else {
        Write-Host "WinRM failed on $_" -F Red -B White
        Write-Host ""
        $_ | Out-File -filepath "$error_file" -Append
        }
}
Write-Host "Input file = $input_file" -B DarkGreen       # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.
Write-Host "Error file = $error_file" -B DarkGreen       # Echo name of error file.
Write-Host "End of Script:" "$(Get-Date)" -F Green