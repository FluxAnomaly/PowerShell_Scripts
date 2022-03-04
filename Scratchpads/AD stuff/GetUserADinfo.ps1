# Input = Text file, one userID per line.
$InputFile = 'C:\Temp\418-Remediation\ADusers.txt'
# Output.  CSV formated text file.
$OutputFile = 'C:\Temp\418-Remediation\ADexamples.txt'

# Create headers
"AccountID,Last Name,First Name,Department,Title,E-Mail,ManagerID,Manager Last Name,Manager First Name,Manager E-Mail" | out-file $OutputFile 

cls

# Read input & start loop
get-content $InputFile | foreach {

$accountID = $_
$first = $null    # Clear any previous value
$first = (get-aduser $_ -properties *).givenname

if ($first) { 

    # Get user info
    $last = (get-aduser $_ -properties *).surname
    $department = (get-aduser $_ -properties *).department.replace(","," ")
    If ((get-aduser $_ -properties *).title) {$title = (get-aduser $_ -properties *).title.replace(","," ")}    
    $email = (get-aduser $_ -Properties *).emailaddress

    # Get Managers account Cononical Name, and Stip Cononical down to account name
    $managerstring = (get-aduser $_ -Properties *).manager
    $manager = $managerstring.split(",")[0].split("=")[1]

    # Get other manager info
    $MgrFirst = (get-aduser $manager -properties *).givenname
    $MgrLast = (get-aduser $manager -properties *).surname
    $MgrEmail = (get-aduser $manager -properties *).emailaddress
}

else {
    # If a field is empty or not found populate the output with "not found"
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

# Output to screen for visual reference:
"$accountID,$last,$first,$department,$title,$email,$manager,$MgrLast,$MgrFirst,$MgrEmail" 

# Output to text file:
"$accountID,$last,$first,$department,$title,$email,$manager,$MgrLast,$MgrFirst,$MgrEmail" | Out-File $OutputFile -Append

}
