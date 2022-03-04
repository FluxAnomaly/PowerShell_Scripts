# Get Distro Lists that VIPs belong to. 
    # Working on making output Tab Delimited. 

# Input = Text file, one userID per line.
$InputFile = 'C:\Temp\VIP_List-2.txt'
# Output.  CSV formated text file.
$OutputFile = 'C:\Temp\VIP_Distros-2.txt'

# Create output file headers
"AccountID,Last Name,First Name,Distro Lists" | out-file $OutputFile 

# For Trouble Shooting:
# Start-Sleep -s 5

cls
Write-Host Running script ... -f Green

get-content $InputFile | foreach {

$accountID = $_
$first = (get-aduser $_ -properties *).givenname
$last = (get-aduser $_ -properties *).surname

$DistroLists = (get-adprincipalgroupmembership af75244 | Where-Object {$_.GroupCategory -match "Distribution"}).name | sort -Descending
$DistroLists | foreach { 


    # Output to text file:
    "$accountID,$last,$first,$_" | Out-File $OutputFile -Append
    #"$accountID $last $first $_" | export-csv -delimiter "`t" -path $OutputFile -Append
    }

}

Write-Host Script complete, check results. -f Green