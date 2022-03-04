# Splunk info gathering.
# Input file is expected to be in same folder as script.
# Output file is also set to be in same folder as script.

# WARNING WARNING WARNING WARNING WARNING WARNING 
                    # COLORIZATION OF TRUE FALSE HAS BROKEN SOMETHING. 

$MyCred = Get-Credential -Credential US\an458060ad    # Run this line once to store credentials.

$time = Get-Date -format "HH-mm"    # Set date/time variable to be used in output name. 
$input_file = 'C:\Terry\415\CheckHosts.txt'                  
$output_file = "C:\Terry\415\$time-Splunk-Checks"        # Manually Edit XX to modify that part of output file name.

$TrueMsg = {Write-Host "True" -F Green}
$FalseMsg = {Write-Host "False" -F Red}

Write-Host "Input file = $input_file" -B DarkGreen      # Echo name of input file.
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.

# Take input from text file and begin loop:
Get-Content $input_file | foreach { 

    if (Test-WSMan $_ -ErrorAction Ignore) {
        Write-Host "Testing $_" -F Yellow

        $HostIP = (Test-Connection -Count 1 $_).IPV4Address.IPAddressToString
            Write-Host "IP for $_ is $HostIP"
        $Splunkexe = Test-Path "\\$_\C$\Program Files\SplunkUniversalForwarder\bin\splunk.exe"
            Write-Host "Splunk.exe present on $_ " -nonewline; If ($Splunkexe) {& $TrueMsg} Else {& $FalseMsg}

         $SplunkSVC = Invoke-Command -ComputerName $_ {(GWMI Win32_Service -Filter "Name='SplunkForwarder'").state -eq 'Running'} -credential $MyCred
            Write-Host "Splunk service running on $_ " -nonewline; If ($SplunkSVC) {& $TrueMsg} Else {& $FalseMsg}

        $InputsConf = Test-Path "\\$_\c$\Program Files\SplunkUniversalForwarder\etc\apps\nms-aoc-winevents\default\inputs.conf"
            Write-Host "inputs.conf present on $_ " -nonewline; If ($InputsConf) {& $TrueMsg} Else {& $FalseMsg}

        $WinVer = Invoke-Command -ComputerName $_ {[System.Environment]::OSVersion.Version.Major} -credential $MyCred
            Write-Host "$_ is running Windows $WinVer"
            Write-Host ""

        # WRITE OUT RESULTS TO CSV FILE:
        $object = New-Object –TypeName PSObject
        $object | Add-Member –MemberType NoteProperty –Name Host –Value $_
        $object | Add-Member –MemberType NoteProperty –Name IP –Value $HostIP
        $object | Add-Member –MemberType NoteProperty –Name Splunkexe –Value $Splunkexe
        $object | Add-Member –MemberType NoteProperty –Name SplunkSVC –Value $SplunkSVC
        $object | Add-Member –MemberType NoteProperty –Name InputsConf –Value $InputsConf
        $object | Add-Member –MemberType NoteProperty –Name WinVer –Value $WinVer

        $object | select Host, IP, Splunkexe, SplunkSVC, InputsConf, WinVer | export-csv "$output_file.csv" -Append -NoTypeInformation   

        }

    else {
        Write-Host "WinRM failed on $_" -F Red -B White
        Write-Host ""
        }
}
Write-Host "Output file = $output_file" -B DarkGreen     # Echo name of output file.
Write-Host 'End of Script' -F Green

