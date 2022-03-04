Clear-Host
        # Setup Variables and output fields to output
$outputFile = "C:\Temp\getinfo.csv"
"ADPGM-Name`tADPGM-SAMname`tADPGM-Category`tADPGM-Scope`tADPGM-Class`tADPGM-DN`tADG-DispName`tADG-Name`tADG-Desc`tADG-Category`tADG-Scope`tADG-Type`tADG-Mail`tADG-MailNick" | out-file $outputFile
$inputFile = "c:\temp\input.txt"

        #For each user...
Get-content $inputFile | foreach {
    $user = $_
            # Getting ADPGM (get-adprincipalgroupmembership) info for each user
    $GroupInfo = get-adprincipalgroupmembership $_
    foreach ($Group in $GroupInfo) {
        $GroupInfoname = $Group.name
        $GroupInfoSAMname =$Group.SamAccountName
        $GroupInfoCategory = $Group.GroupCategory
        $GroupInfoScope = $Group.GroupScope
        $GroupInfoClass = $Group.objectClass
        $GroupInfoDN = $Group.distinguishedName
        #$GroupInfoGUID = $Group.objectGUID
     
                # Getting ADG (get-adgroup) info for each group
        $ADGroup = Get-ADGroup $GroupInfoSAMname -Properties *
        $ADGDisplayName = $ADGroup.DisplayName
        $ADGName = $ADGroup.Name
        $ADGDescription = $ADGroup.Description
        $ADGCategory = $ADGroup.GroupCategory
        $ADGScope = $ADGroup.GroupScope
        $ADGType = $ADGroup.groupType
        $ADGMail = $ADGroup.mail
        $ADGMailNick = $ADGroup.mailNickname
    
       # Time for some screen and logfile output
       "$User`t$GroupInfoname`t$GroupInfoSAMname`t$GroupInfoCategory`t$GroupInfoScope`t$GroupInfoClass`t$GroupInfoDN`t$ADGDisplayName`t$ADGName`t$ADGDescription`t$ADGCategory`t$ADGScope`t$ADGType`t$ADGMail`t$ADGMailNick"
       "$User`t$GroupInfoname`t$GroupInfoSAMname`t$GroupInfoCategory`t$GroupInfoScope`t$GroupInfoClass`t$GroupInfoDN`t$ADGDisplayName`t$ADGName`t$ADGDescription`t$ADGCategory`t$ADGScope`t$ADGType`t$ADGMail`t$ADGMailNick" | out-file $outputFile -Append
    
    }
}