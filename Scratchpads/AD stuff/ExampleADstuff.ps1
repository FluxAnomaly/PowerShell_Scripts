cls
get-content c:\temp\users.txt | foreach {

$first = $null
$first = (get-aduser $_ -properties *).givenname
if ($first) { 

    $last = (get-aduser $_ -properties *).surname
    $tier = (get-aduser $_ -properties *).mobile            # This is where we store if it's t1 or t2 account.
    $regularaccount = (get-aduser $_ -properties *).physicalDeliveryOfficeName 
    $email = (get-aduser $regularaccount -Properties *).emailaddress
    $managerstring = (get-aduser $regularaccount -Properties *).manager
    $manager = $managerstring.split(",")[0].split("=")[1]
}
else {
    $first = $_
    $last = "not found"
    $tier = "not found"
    $regularaccount = "not found"
    $email = "not found"
    $manager = "not found"
}

"$first $last, $tier,$regularaccount,$email,$manager" 
"$first $last, $tier,$regularaccount,$email,$manager" | out-file c:\temp\examples.txt -Append

}