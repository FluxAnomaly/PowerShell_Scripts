# Get Members of group.  THIS CAN TAKE A WHILE TO RETURN RESULTS.
# https://community.spiceworks.com/topic/491222-powershell-get-all-users-in-an-adgroup-with-the-displayname?page=1#entry-4643913

Get-Adgroupmember -identity "JamfPro_Auditor" | ft name

Get-Adgroupmember -identity "JamfPro_Auditor" | ft samaccountname



