# Get Distro Lists that VIPs belong to. 
    # Output is comma delimited file.

# Input = Text file, one userID per line.
$InputFile = 'C:\Temp\VIP_List.txt'
# Output.  CSV formated text file.
$OutputFile = 'C:\Temp\VIP_Distros.txt'

# Create output file headers
"AccountID,Last Name,First Name,Distro Lists" | out-file $OutputFile 

cls
Write-Host Running script ... -f Green

get-content $InputFile | foreach {

$accountID = $_
$first = (get-aduser $_ -properties *).givenname
$last = (get-aduser $_ -properties *).surname

$DistroLists = (get-adprincipalgroupmembership af75244).name | sort -Descending 
$DistroLists | foreach { 

    $_
    "Email"
    (Get-ADGroup $_ -Properties *).email
    
    # Output to text file:
    #"$accountID,$last,$first,$_" #| Out-File $OutputFile -Append
    }

}

Write-Host Script complete, check results. -f Green