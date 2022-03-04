# Get users AD Group memberships of a user.

# DOS command :
net user /do af75244

# 4/23/20 : The new hotness, and how I should have done it all along.
$username = "XXX"
$username = "af75244"

# Same results, slightly different formatting. 2nd example has column header. 
(Get-ADPrincipalGroupMembership $username).name | sort -Descending
Get-ADPrincipalGroupMembership $username | select name | sort -Descending

# Get info by specified category :
(get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Distribution"}).name | sort -Descending
(get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Security"}).name | sort -Descending

get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Distribution"} | select name | sort -Descending


# ======================================================================================================================
# Do it with a FUNCTION, look up and output Disto and Security separately:
Function Get-UserGroups ($username) {
Write-Host ''
Write-Host 'SECURITY GROUPS: ' -F Red -B Yellow
(get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Security"}).name | sort -Descending

Write-Host ''
Write-Host 'DISTRO GROUPS: ' -F Green
(get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Distribution"}).name | sort -Descending
}
# ======================================================================================================================


# NOTES :

# Consider improving it like this:
# https://stackoverflow.com/questions/34900830/how-to-prompt-for-args-when-missing

##################################################################################################
# Another way I found somewhere, gets all Security and Distro groups :
$username = "af75244"
(get-aduser -Properties * $username).memberof |foreach {$_.split(",")[0].substring(3)}
##################################################################################################


# SCRATCHPAD BELOW HERE: ------------------------------------------------------------------------------------

# Single line, no modules necessary, uses current logged user:
(New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(samAccountName=$($env:username)))")).FindOne().GetDirectoryEntry().memberOf

# Specify a user. Works but output too verbose:  
# change the variable from $env:username to $username and set with $username = "testuser" to easily do variable substitution for other user lookups
$username = "af75244"
(New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(samAccountName=$($username)))")).FindOne().GetDirectoryEntry().memberOf




# https://blogs.technet.microsoft.com/heyscriptingguy/2010/08/24/use-the-powershell-adsisearcher-type-accelerator-to-search-active-directory/
# ---------------------------------------------------------

