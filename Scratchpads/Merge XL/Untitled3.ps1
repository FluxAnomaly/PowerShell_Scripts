# This will append all the files together reading them one at a time:
# https://gallery.technet.microsoft.com/scriptcenter/CombineMerge-multiple-CSV-23a53e83

$path = "C:\temp\EXEL_MERGE"

get-childItem "$path\*.txt" 
| foreach {[System.IO.File]::AppendAllText
 ("Merged_File", [System.IO.File]::ReadAllText($_.FullName))}