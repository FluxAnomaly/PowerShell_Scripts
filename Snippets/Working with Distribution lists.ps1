# 02/03/2020
# Working with Distribution lists:

#----------------------------------------------------------------

# Works. Gets name of members of distro group.
get-adgroup DL-Avatar-Support -Properties * | Get-ADGroupMember | foreach {(Get-ADUser $_ -Properties *).DisplayName}

# Also Works. Gets name of members of distro group.
(get-adgroup DL-Avatar-Support -Properties *).members | foreach {(Get-ADUser $_ -Properties *).DisplayName}

# Also Works. Gets name of members of distro group.
(Get-ADGroupMember DL-Avatar-Support).name | foreach {(Get-ADUser $_ -Properties *).DisplayName}

# =========================================================================================================
# Gets name of members of distro group, including Name, Email, Phone and Title. 
# Formatted as table.     NOTE:  This can take a long time on large distro lists. 

$DISTRO_LIST = 'dl-ITSM Reporting Users'
(Get-ADGroupMember $DISTRO_LIST).name | foreach {Get-ADUser $_ -Properties *} | Format-Table DisplayName, EmailAddress, telephoneNumber, Title -autosize

# Export to TXT file.
$DISTRO_LIST = 'DL-Avatar-Support'
(Get-ADGroupMember $DISTRO_LIST).name | foreach {Get-ADUser $_ -Properties *}`
 | Format-Table DisplayName, EmailAddress, telephoneNumber, Title -autosize `
  | Out-File -FilePath "c:\temp\Distro_Members_$DISTRO_LIST.txt"

# Export to CSV.   https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7
$DISTRO_LIST = 'dl-ITSM Reporting Users'
(Get-ADGroupMember $DISTRO_LIST).name | foreach {Get-ADUser $_ -Properties *}`
 | Select-Object -Property DisplayName, EmailAddress, telephoneNumber, Title `
   | Export-Csv -Path "c:\temp\Distro_Members_$DISTRO_LIST.csv" -NoTypeInformation

# =========================================================================================================

#----------------------------------------------------------------

# Related:  
# Gets groups that user is member of.
$username = 'af75244'
get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Security"} | sort -Descending | Format-Table name -autosize

get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Distribution"} | sort -Descending | Format-Table name -autosize

get-adprincipalgroupmembership $username | Where-Object {$_.GroupCategory -match "Security" -OR "Distribution"} | sort -Descending | Format-Table name -autosize

