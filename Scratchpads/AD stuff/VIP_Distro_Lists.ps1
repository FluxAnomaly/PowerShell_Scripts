# Get Distro Lists that VIPs belong to. 


# Input = Text file, one userID per line.
$InputFile = 'C:\Temp\VIP_List.txt'
# Output.  CSV formated text file.
$OutputFile = 'C:\Temp\VIP_Distros.txt'

# Create headers
"AccountID,Last Name,First Name,Distro Lists" | out-file $OutputFile 

#cls

get-content $InputFile | foreach {

$accountID = $_
$first = (get-aduser $_ -properties *).givenname
$last = (get-aduser $_ -properties *).surname

# Try 1:
# This isn't working in the loop. Is there a conflict in the $_ usage? 
# $DistroLists = get-adprincipalgroupmembership $accountID | Where-Object {$_.GroupCategory -match "Distribution"} | Format-Table name -autosize


# Try 2:
#$DistroLists = get-adprincipalgroupmembership $accountID
#($DistroLists | Where-Object {$DistroLists.GroupCategory -match "Distribution"}).name # | Format-Table name -autosize

#Try 3:
$DistroLists = (get-adprincipalgroupmembership af75244 | Where-Object {$_.GroupCategory -match "Distribution"}).name | sort -Descending



# Output to text file:
"$accountID,$last,$first,$DistroLists"# | Out-File $OutputFile -Append

}