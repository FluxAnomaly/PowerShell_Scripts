<#
Merge multiple CSV files. 
https://gallery.technet.microsoft.com/scriptcenter/CombineMerge-multiple-CSV-23a53e83

More Information:
Refer to my blog post(http://techibee.com/powershell/merging-multiple-csv-files-into-one-using-powershell/2382) to know more information about this funciton.  

USAGE:
Merge-CSVFiles -CSVFiles C:\temp\file1.csv,C:\temp\file2.csv -OutputFile c:\temp\output.csv

EXAMPLE USAGE:
Merge-CSVFiles -CSVFiles C:\temp\EXCEL_MERGE\1Workstations-Stopped-McAfee.csv,C:\temp\EXCEL_MERGE\2Workstations-Stopped-McAfee.csv,C:\temp\EXCEL_MERGE\3Workstations-Stopped-McAfee.csv

#>


function Merge-CSVFiles { 
[cmdletbinding()] 
param( 
    [string[]]$CSVFiles, 
    [string]$OutputFile = "C:\temp\EXCEL_MERGE\merged.csv" 
) 
$Output = @(); 
foreach($CSV in $CSVFiles) { 
    if(Test-Path $CSV) { 
         
        $FileName = [System.IO.Path]::GetFileName($CSV) 
        $temp = Import-CSV -Path $CSV | select *, @{Expression={$FileName};Label="FileName"} 
        $Output += $temp 
 
    } else { 
        Write-Warning "$CSV : No such file found" 
    } 
 
} 
$Output | Export-Csv -Path $OutputFile -NoTypeInformation 
Write-Output "$OutputFile successfully created" 
 
}