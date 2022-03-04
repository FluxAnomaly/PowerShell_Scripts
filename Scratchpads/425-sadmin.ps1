
$MyCred2 = Get-Credential -Credential AN644915AD    # Run this line once to store credentials.

$machine = 'DVA10PWPSQL072A'

Invoke-Command -computername $machine -command {
    hostname | Write-Host -B Red;
    sadmin status | Write-Host -ForegroundColor yellow; 
    sadmin recover -z BE7WYKY64M572GU;
    sadmin bu;
    #sadmin status  | Write-Host -ForegroundColor Magenta; 
    sadmin lockdown;
    sadmin status  | Write-Host -ForegroundColor green    
    } #-Credential $MyCred2


Invoke-Command -computername $machine -command {
    hostname | Write-Host -B Red;
    sadmin recover -z BE7WYKY64M572GU;
    sadmin eu; 
    sadmin lockdown;
    sadmin status  | Write-Host -ForegroundColor green    
    }



Invoke-Command -computername $machine -command {hostname; sadmin status  | Write-Host -ForegroundColor Cyan} -Credential $MyCred2
Invoke-Command -computername $machine -command {sadmin recover -z BE7WYKY64M572GU}

Invoke-Command -computername $machine -command {sadmin eu}
Invoke-Command -computername $machine -command {sadmin lockdown}
clear

Write-Host 'Hello' -ForegroundColor Cyan