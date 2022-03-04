
Get-ADUser AN291833AD -Properties * | ft DisplayName, HomePhone, GivenName, Surname


Get-ADUser AN644915AD -Properties * | ft DisplayName

Get-ADUser AN644915AD -Properties * | ft DisplayName




# Get users vaulted accounts: (Anthem stores this in the 'Office' attribute)
Get-ADUser -Filter {Office -eq "af75244"}



# ----------------------------------------------------------------

Get-ADUser AN644915AD -Properties * | Select-String -Pattern 'wolfrey'



Get-ADUser AN644915AD -Properties * | findstr s*
Get-ADUser AN644915AD -Properties * | Select-String 
Get-ADUser AN644915AD -Properties * | Where 


get-aduser ac89437 | Where-Object { $_.givenname -clike "Leo*"}

get-aduser AN644915AD | Where-Object {$_.value -eq "af75244"}

get-aduser AN644915AD -Properties * | Get-Member

get-aduser AN644915AD -Properties * | Get-ItemPropertyValue * | Where-Object {$_.properties.Value -like "*AF75244*"} 
get-aduser AN644915AD -Properties * | Where-Object {$_.properties.Value -contains "AF75244"}

get-aduser AN644915AD -Properties * | Select-Value "*af75244*"
get-aduser AN644915AD -Properties * | Select-Object -ExpandProperty * | Where-Object {$_.properties.Value -like "*AF75244*"} 
Get-ADUser AN644915AD -properties * | select-string -Pattern 'af752*'

get-item
get-itemproperty
Get-ItemPropertyValue


# THIS WORKS:  Find properties with matching values. 
$UserInfo = Get-ADUser AN644915AD -properties *
$UserInfo | Out-string -stream | select-string -simplematch 'af75244'

Get-ADUser AN644915AD -properties * | Out-string -stream | select-string -Pattern 'af752*'