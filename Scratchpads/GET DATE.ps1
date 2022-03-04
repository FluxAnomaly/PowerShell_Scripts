# Get-Date

$time = Get-Date -format "dd-MMM-yyyy_HH-mm"    # Set date/time variable to be used in output name. In format: "24-Sep-2018_17-24"



# Jeremy did it this way in a script.
$filesuffix = $(get-date).ToString("yyyyMMddTHm")