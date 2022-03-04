# Get AD group members:

$TheGroup = "AWL_WKS_Enabled"   # THE VIP GROUP
$TheGroup = "AWL_WKS_CM_Enabled"  # THE CAREMORE VIP GROUP. Use jump box. 

$TheGroup = "AD-Role-LocalWSAdmin"
$TheGroup = "SC Admin - WKS"
$TheGroup = "TanPAdmins"
$TheGroup = "SC ADMIN PROD"


Get-Adgroupmember $TheGroup

Get-Adgroupmember -identity $TheGroup | ft name, DisplayName

Get-Adgroupmember -identity $TheGroup | ft samaccountname

Get-Adgroupmember -identity $TheGroup | ft samaccountname | Measure-Object -Line

# Get group members SamAccountName name and Display Name:
Get-Adgroupmember -identity $TheGroup | Get-ADUser -Properties * | Select-Object SamAccountName, DisplayName

# doesn't work?
Get-Adgroupmember -identity $TheGroup | select -expand member | get-adobject | Format-Table Name -AutoSize 


##################################################################################################
# WORKAROUND FOR CAREMORE.  Because 'Get-Adgroupmember' doesn't work there for some reason. 

get-adgroup $TheGroup -properties * | select -expand member | get-adobject | Format-Table Name -AutoSize

# WORKS IN CAREMORE
get-adgroup $TheGroup -properties * | select -expand member | Get-ADUser -ErrorAction SilentlyContinue 
(get-adgroup $TheGroup -properties * | select -expand member | Get-ADUser -ErrorAction SilentlyContinue).samaccountname

get-adgroup $TheGroup -properties * | select -expand member | Get-ADUser -ErrorAction SilentlyContinue | ft SamAccountName, UserPrincipalName 

get-adgroup $TheGroup -properties * | select -expand member | Get-ADUser -ErrorAction SilentlyContinue | Select-Object Name, SamAccountName, UserPrincipalName | Out-GridView 

get-adgroup $TheGroup -properties * | select -expand member | Get-ADUser -ErrorAction SilentlyContinue | Select-Object Name, SamAccountName, UserPrincipalName, DisplayName | ft -AutoSize




# what is "ft" ?  Alias for Format-Table.