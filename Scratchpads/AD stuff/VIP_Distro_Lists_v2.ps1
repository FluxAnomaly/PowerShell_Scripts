# Get Distro Lists that VIPs belong to. 
    # Output is comma delimited file.

$time = Get-Date -format "yyMMdd_HHmm"    # Set date/time variable to be used in output name. In format: "Year Month Day Hour Minute"
# Input = Text file, one userID per line.
$InputFile = 'C:\Temp\VIP_List.txt'
# Output.  CSV formated text file.
$OutputFile = "C:\Temp\VIP_Distros_$time.txt"

# Create output file headers
"AccountID,Last Name,First Name,Distro Lists" | out-file $OutputFile 

cls
Write-Host Running script ... -f Green

get-content $InputFile | foreach {

$accountID = $_
$first = (get-aduser $_ -properties *).givenname
$last = (get-aduser $_ -properties *).surname

$DistroLists = (get-adprincipalgroupmembership $accountID | Where-Object {$_.GroupCategory -match "Distribution"}).name | sort -Descending
$DistroLists | foreach { 


    # Output to text file:
    "$accountID,$last,$first,$_" | Out-File $OutputFile -Append
    }

}

Write-Host Script complete, check results. -f Green