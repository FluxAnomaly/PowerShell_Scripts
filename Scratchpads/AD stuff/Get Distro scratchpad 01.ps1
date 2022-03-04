

(get-aduser $_ -properties *).MemberOf

get-aduser af75244 -properties *

# This gets the 'fully qualified' names of groups.
(get-aduser af75244 -properties *).MemberOf

# this fails.
(get-aduser af75244 -properties *).MemberOf | Where-Object {$_.MemberOf -like "CN=dl-"}
# this fails.
(get-aduser af75244 -properties *).MemberOf | Where-Object {$_.GroupCategory -match "Distribution"}


get-adprincipalgroupmembership $username | Format-Table

get-adprincipalgroupmembership af75244 | Format-Table


get-adprincipalgroupmembership af75244 | Where-Object {$_.name -like "CN=dl-"}
get-adprincipalgroupmembership af75244 | Where {$_.name -like "CN=dl-"}


get-adprincipalgroupmembership af75244 | Format-Table 


# This works:
get-adprincipalgroupmembership af75244 | Where-Object {$_.GroupCategory -match "Distribution"} | Format-Table name -autosize

# This works better:
(get-adprincipalgroupmembership af75244 | Where-Object {$_.GroupCategory -match "Distribution"}).name


# This fails to match GroupCategory:
($thing = get-adprincipalgroupmembership af75244) | Where-Object {$thing.GroupCategory -match "Distribution"}

# This works:
$thing2 = (get-adprincipalgroupmembership af75244 | Where-Object {$_.GroupCategory -match "Distribution"}).name