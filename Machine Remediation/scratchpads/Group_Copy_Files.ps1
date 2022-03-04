# Group_Copy_Files
# Read machines names from file and copy files to them. Write sucesses/fail to separate log files. 

# NOTES:  Needs work.  Test-Connection can work but Invoke-Command might still fail. 
# Also no fail list gets created. 

# Set variables
$hostfile = "C:\Temp\PROJECTS\Workstation remediation\07-10-20 Tanium\MachineList.txt"
$timestamp = Get-Date -format "dd-MMM-yyyy_HH-mm"    # Set date/time variable to be used in output name. In format: "24-Sep-2018_17-24"

# Loop
Get-Content $hostfile | foreach {
    $Computer = $_
    Write-Host ""   # Blank Line

    If (Test-Connection $Computer -Count 1) {
    # Success
    Write-Host "Test Connection Successful on $Computer" -F Green

    Invoke-Command -Computername $Computer -Command {mkdir c:\EndpointTools}
    Invoke-Command -Computername $Computer -Command {dir C:\EndpointTools}
    Copy-Item –Path "C:\TOOLS\McAffee_Tools\FramePkg_5.6.2.209_RTW_EPO_300.exe" –Destination "\\$Computer\c$\EndpointTools" -Verbose
    Invoke-Command -Computername $Computer -Command {dir C:\EndpointTools}

    #$FilePresent = 
    #Invoke-Command -Computername $Computer -Command {Test-Path "c:\EndpointTools\FramePkg_5.6.2.209_RTW_EPO_300.exe"}

    
    $Computer | Out-File -filepath "C:\temp\FileCopy_Success_$timestamp.txt" -Append
    }

    Else {
    # Fail
    Write-Host "Connection FAILURE on $Computer" -F Red
    $Computer | Out-File -filepath "c:\temp\FileCopy_Fail_$timestamp.txt" -Append
    }
} # EOF


<#  NOTES



#>