# Merging CSV files
# https://stackoverflow.com/questions/27892957/merging-multiple-csv-files-into-one-using-powershell


# This works but is expecting headers it removes the first line of every file after the first.  Since my files don't have headers this is a problem. 
$getFirstLine = $true

get-childItem "C:\Users\AF75244\OneDrive - Anthem\Documents\PROJECTS\Workstation remediation\09-17-20 Tanium\test\*.csv" | foreach {
    $filePath = $_

    $lines =  $lines = Get-Content $filePath  
    $linesToWrite = switch($getFirstLine) {
           $true  {$lines}
           $false {$lines | Select -Skip 1}

    }

    $getFirstLine = $false
    Add-Content "combine.csv" $linesToWrite
    }

# ---------------------------------------------------------------------------------

# This works.  Removing the logic to skip first lines also simplified it greatly. 
get-childItem "C:\Projects\Workstation remediation\10-19-20 Tanium\*.csv" | foreach {
$filePath = $_

$lines = Get-Content $filePath  

Add-Content "Combined.csv" $lines
}