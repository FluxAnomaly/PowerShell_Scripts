# *********************************************************************************************************
# GET USERS VAULTED ACCOUNTS: (Anthem stores the standard account name in the 'Office' attribute. Any other places?)
# Doesn't work with a variable inside the code block?
Get-ADUser -Filter {Office -eq "af75244"}  
get-aduser -Filter {surname -like 'wolfrey'} | Format-List

# Look up users vaulted accounts from their standard account, either command gives same output :
Get-ADUser -Filter {Office -eq "af75244"} -Properties * | ft name, DistinguishedName
Get-ADUser -Filter {Office -eq "af75244"} -Properties * | select name, DistinguishedName

# Look up user by surname, get all accounts output:
get-aduser -Filter {surname -like 'wolfrey'} -Properties * | select name, DistinguishedName


# Same results, cleaner output: 
Get-ADUser -Filter {Office -eq "af75244"} -Properties * | select name, @{l='OU';e={$_.DistinguishedName.split(',')[1].split('=')[1]}}


# Look for both T1 and T2 accounts, by email address.  Two commands on one line :
$userID = (Get-ADUser -Filter {EmailAddress -eq "terry.wolfrey@anthem.com"}).name; Get-ADUser -Filter {Office -eq $userID} -Properties * | select name, DistinguishedName

# Look for both T1 and T2 accounts, by email address..  Two commands on one line, with clean output :
$userID = (Get-ADUser -Filter {EmailAddress -eq "terry.wolfrey@anthem.com"}).name; Get-ADUser -Filter {Office -eq $userID} -Properties * | select Name, @{l='OU';e={$_.DistinguishedName.split(',')[1].split('=')[1]}}

# https://community.spiceworks.com/topic/825700-get-aduser-distinguishedname-powershell-help


