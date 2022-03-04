#$path = "C:\Users\xxxx\Downloads\report\*"

$path = "C:\temp\EXEL_MERGE"

#Merge all excel files into one
$ExcelObject=New-Object -ComObject excel.application
$ExcelObject.visible=$true
$filetype ="*xls"
$ExcelFiles=Get-ChildItem -Path $path -Include $filetype

$Workbook=$ExcelObject.Workbooks.add()
$Worksheet=$Workbook.Sheets.Item("Sheet1")

foreach($ExcelFile in $ExcelFiles)
{
    $Everyexcel=$ExcelObject.Workbooks.Open($ExcelFile.FullName)
    $Everysheet=$Everyexcel.sheets.item(1)
    $Everysheet.Copy($Worksheet)
    $Everyexcel.Close()
}

$Workbook.SaveAs("$path\Merge.xls")


$ExcelObject.Quit()