cls
"AccountID,Last Name,First Name,Department,Title,E-Mail,ManagerID,Manager Last Name,Manager First Name,Manager E-Mail" | out-file C:\Temp\418-Remediation\ADexamples.txt 

get-content C:\Temp\418-Remediation\ADusers.txt | foreach {

$accountID = $_
$first = $null
$first = (get-aduser $_ -properties *).givenname

if ($first) { 

    $last = (get-aduser $_ -properties *).surname

    $department = (get-aduser $_ -properties *).department.replace(","," ")
    $title = (get-aduser $_ -properties *).title.replace(","," ")
    $email = (get-aduser $_ -Properties *).emailaddress

    # Get Managers account Cononical Name
    $managerstring = (get-aduser $_ -Properties *).manager
    # Stips to it account name
    $manager = $managerstring.split(",")[0].split("=")[1]

    $MgrFirst = (get-aduser $manager -properties *).givenname
    $MgrLast = (get-aduser $manager -properties *).surname
    $MgrEmail = (get-aduser $manager -properties *).emailaddress
}

else {
    $first = "not found"
    $last = "not found"
    $tier = "not found"
    $department = "not found"
    $email = "not found"

    $manager = "not found"
    $MgrFirst = "not found"
    $MgrLast = "not found"
    $MgrEmail = "not found"
}

# Output
"$accountID,$last,$first,$department,$title,$email,$manager,$MgrLast,$MgrFirst,$MgrEmail" | Out-File C:\Temp\418-Remediation\ADexamples.txt -Append
#"$accountID,$last,$first,$department,$title,$email,$manager,$MgrLast,$MgrFirst,$MgrEmail" | Out-File C:\Temp\418-Remediation\ADexamples.csv -Append


}
