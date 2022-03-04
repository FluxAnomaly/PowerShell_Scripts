# Find users by matching surname, DisplayName, EmailAddress, etc.

# ---------------------------------------------
# This will get a list of accounts where the user surname matches. 
Get-ADUser -Filter {Surname -like "Wolfrey"}

    # But trying to pass the surname in a variable in the codeblock fails. 
    $User = "Wolfrey"
    Get-ADUser -Filter {Surname -like "$User"}


# This allows you to focus more specifically using both first and last name.
Get-ADUser -Filter {legalDisplayName -like "wolfrey, terry"}

# DisplayName ALSO WORKS
Get-ADUser -Filter {DisplayName -like "wolfrey, terry"}
    
    #Doesn't work with parenthesis, so why are parens required and backets fail for the boolean AND examples below?
    Get-ADUser -Filter (legalDisplayName -like "wolfrey, terry")

    # Brackets DO NOT WORK with this boolean example:
    Get-ADUser -Filter "{Surname -like "Wolfrey"} -AND {GivenName -like "Terry"}"
    Get-ADUser -Filter "{Surname -like 'Wolfrey'} -AND {GivenName -like 'Terry'}"

    # PARENS DO WORK :
    Get-ADUser -Filter "(Surname -like 'Wolfrey') -AND (GivenName -like 'Terry')"


# UserPrincipalName  # works but not present in elevated accounts. So not of much use here.  
Get-ADUser -Filter {UserPrincipalName -like "af75244*"}

# ----------------------------------------------------
# Get user ID by email address:
Get-ADUser -Filter {EmailAddress -eq "terry.wolfrey@anthem.com"}



# ******************************************************************************
# Basic command gets a few lines of user info:
get-aduser AF97537

# Get ALL of the user info:
get-aduser AF97537 -Properties *

# Get basic info PLUS the specified property. 
get-aduser AF97537 -Properties emailaddress
get-aduser AF97537 -Properties *email*

# Get ONLY the specified property:
get-aduser AF97537 -Properties * | Select-Object -Property *email*
get-aduser AF97537 -Properties * | Select-Object -Property *email* | Format-List

# ******************************************************************************



# NOTES =========================================================

# These don't work, did they ever? Can't recall what I was doing with them. 
(get-aduser $_ -properties *).surname | Where-Object {$_.GroupCategory -match "xxx"}
(get-aduser -properties *) | Where-Object {$_.surname -match "Wolfrey"}





