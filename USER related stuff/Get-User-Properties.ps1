# Getting various user properties:

# Simple examples:
get-aduser AF97537 -Properties *

get-aduser AF97537 -Properties emailaddress
get-aduser AF97537 -Properties *email*

# A little more complex :
get-aduser AF97537 -Properties * | Select-Object -Property *email*
get-aduser AF97537 -Properties * | Select-Object -Property *email*, DisplayName, Title, Company | Format-List
get-aduser AF97537 -Properties * | Select-Object -Property *email*, DisplayName, Title, Company | Format-Table
get-aduser AF97537 -Properties * | Select-Object -Property *email*, DisplayName, Title, Company, Department, City | Format-Table -AutoSize

#
Get-ADUser AB72902 -Properties * | ft name, Enabled, displayname, UserPrincipalName, description


# Get Members of group.
Get-Adgroupmember -identity  "SC Admin - WKS" | ft name
Get-Adgroupmember -identity  "AD-Role-LocalWSAdmin" | ft samaccountname


# *********************************************************************************************************
# *********************************************************************************************************
# Find a user by name :

Get-ADUser -Filter {legalDisplayName -like "wolfrey, terry"}
Get-ADUser -Filter {legalDisplayName -like "Garg, Vivek"}
    #Doesn't work with parenthesis
    Get-ADUser -Filter (legalDisplayName -like "wolfrey, terry")

# works
Get-ADUser -Filter "(Surname -like 'Wolfrey') -AND (GivenName -like 'Terry')"
Get-ADUser -Filter "(Surname -like 'Garg') -AND (GivenName -like 'Vivek')"

#DisplayName  # works
Get-ADUser -Filter {DisplayName -like "wolfrey, terry"}
Get-ADUser -Filter {DisplayName -like "Garg, Vivek"}

# UserPrincipalName  # works but not present in elevated accounts. 
Get-ADUser -Filter {UserPrincipalName -like "af75244*"}
# *********************************************************************************************************


# Get user ID by email address:
Get-ADUser -Filter {EmailAddress -eq "terry.wolfrey@anthem.com"}

