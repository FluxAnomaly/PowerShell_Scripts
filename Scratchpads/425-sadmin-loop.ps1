
$MyCred2 = Get-Credential -Credential AN644915AD    # Run this line once to store credentials.
 
$input_file = "C:\Temp\Oncall.txt"

Get-Content $input_file | foreach {
    Invoke-Command -computername $_ -command {
        Write-Host '';
        hostname | Write-Host -B Red;
        sadmin status | Write-Host -ForegroundColor yellow; 
        sadmin recover -z BE7WYKY64M572GU;
        sadmin bu;
        sadmin status  | Write-Host -ForegroundColor Magenta; 
        sadmin lockdown;
        sadmin status  | Write-Host -ForegroundColor green    
        }
    } #-Credential $MyCred2




Get-Content $input_file | foreach {
    Invoke-Command -computername $_ -command {
        Write-Host '';
        hostname | Write-Host -B Red;
        sadmin recover -z BE7WYKY64M572GU;
        sadmin eu;
        sadmin status | Write-Host -ForegroundColor yellow;
        sadmin lockdown   
        }
    } #-Credential $MyCred2