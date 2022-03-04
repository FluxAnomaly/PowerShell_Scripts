# Fetch Splunk inputs.conf files:

$work_dir = 'C:\Temp\PROJECTS\SPLUNK\422_Anthem_tests'   
$input_file = "$work_dir\Fetch.txt"    # Manually edit input file name.
$ConfFilePath = "Program Files\SplunkUniversalForwarder\etc\apps\nms-aoc-winevents\default"

Write-Host "Input file = $input_file" -B DarkGreen      # Echo name of input file.
Write-Host "Output destinatin = $work_dir" -B DarkGreen     # Echo name of output file.

$list = get-content $input_file
foreach ($item in $list) {
    Write-Host $item

    Copy-Item -Path "\\$item\c$\$ConfFilePath\inputs.conf" –Destination "$work_dir\$item-inputs.conf" -Verbose

}




