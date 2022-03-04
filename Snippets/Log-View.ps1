<#  
# Author:  Terry Wolfrey
# Open cmtrace.exe log viewer to remote pc solidcore.log file. 
# Depending on how you put cmtrace on your system you may need to specify the path to its exe file. (Ex:  C:\TOOLS\cmtrace.exe)
# If installed as part of Microsoft System Center 2012 R2 Configuration Manager it installs to C:\Windows\System32\cmtrace.exe and is in path.

Log paths:  
McAfee SolidCore logs: \\machinename\c$\ProgramData\McAfee\Solidcore \Logs
McAfee Agent logs:  \\machinename\c$\ProgramData\McAfee\Agent\logs
Windows logs:  \\machinename\c$\WINDOWS\system32\config     <-- is this right?
Windows logs:  C:\Windows\System32\Winevt\Logs\
#>

$RemotePC = 'L4GVZR72'  #Rick
$RemotePC = 'L4JKGWF2'  #Leo

$RemotePC = 'D6C7N1S2'

# Open File Explorer to a remote machines log files:    Figure out how to do this from PowerShell.
xxx

# Windows system logs:
# CMtrace won't open Windows event logs. 

# Attack Surface Reduction (ASR) events:
# Windows Defender:
# Event when rule fires in Block-mode
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1121} | Select-Object timecreated,message -First 50} | Out-GridView
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1121} | Select-Object timecreated,message -First 5} | Format-List

# Event when rule fires in Audit-mode
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=1122} | Select-Object timecreated,message -First 50} | Out-GridView
# Event when settings are changed
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=5007} | Select-Object timecreated,message -First 50} | Out-GridView

# "Do not allow child processes block"
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=4} | Select-Object timecreated,message -First 50} | Out-GridView


# Windows firewall events:
Invoke-Command -Computer $RemotePC {Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall";id=2011} | Select-Object timecreated,message -First 50} | Out-GridView  


    # C:\WINDOWS\system32\config\
    \\LFWPFZY2\c$\WINDOWS\system32\config\
    \\LFWPFZY2\c$\WINDOWS\System32\winevt\Logs\


    # All event ID's:
    # THIS DOESN'T WORK, IT DOESN'T LIKE THE * BUT I THOUGHT I REMEBERED IT WORKING BEFORE. 8/27/20.
    Invoke-Command -Computer "$RemotePC" {Get-WinEvent -FilterHashtable @{logname="microsoft-windows-windows defender/operational";id=*} | Select-Object timecreated,message -First 100} | Out-GridView




# fix the variable in this:
C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Agent\logs\macmnsvc_$RemotePC_backup_1.log"
C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Agent\logs\macmnsvc_L88HYJR2_backup_1.log"


# c:\ProgramData\McAfee\Agent\logs\macmnsvc_L4XW56M2.log 

# Solidcore logs:
C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Solidcore\logs\solidcore.log"
    C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Solidcore\logs\solidcore_1.log"
    C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Solidcore\logs\solidcore_2.log"
    C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Solidcore\logs\solidcore_3.log"


# Agent 5.5.1 install logs:
C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\Flags\McAfee_Agent_5-5-1-388_EN_17_PSAppDeployToolkit_install.log"


# Agent logs:
# if you see UV errors in the agent log the agent is corrupt and needs to be removed/reinstalled. 
C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Agent\logs\masvc_$RemotePC.log"

# McAfee Agent logs:
C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\ProgramData\McAfee\Agent\logs\macmnsvc_$RemotePC.log"

    # see below for listing of other files in this dir. 


# ENS 10.6.1 install logs:
C:\TOOLS\cmtrace.exe "\\$RemotePC\c$\Flags\McAfee_EndpointSecurity_10-6-1-1060_EN_18_PSAppDeployToolkit_Install.log"

\\LB6S3VN2\c$\ProgramData\McAfee\Solidcore\logs\



<#
Directory: C:\ProgramData\McAfee\Agent\logs


Mode                LastWriteTime         Length Name                                                                                                                   
----                -------------         ------ ----                                                                                                                   
-a----       10/23/2019  11:02 AM              0 macmnsvc_L4XW56M2.log                                                                                                  
-a----       10/23/2019  11:02 AM        2105461 macmnsvc_L4XW56M2_backup_1.log                                                                                         
-a----       10/23/2019   9:20 AM         199014 macompatsvc_L4XW56M2.log                                                                                               
-a----       10/23/2019  12:32 AM        2100963 macompatsvc_L4XW56M2_backup_1.log                                                                                      
-a----       10/23/2019   9:20 AM        1137083 masvc_L4XW56M2.log                                                                                                     
-a----       10/21/2019   1:45 PM        2098924 masvc_L4XW56M2_backup_1.log                                                                                            
-a----       10/23/2019  12:49 PM         647694 McScript.log                                                                                                           
-a----       10/22/2019  11:28 PM        2097198 McScript_backup_1.log                                                                                                  
-a----         8/5/2019   1:21 PM         785346 McScript_deploy.log                                                                                                    
-a----        6/18/2019  11:53 AM        2097156 McScript_deploy_backup_1.log                                                                                           
-a----         8/5/2019   1:21 PM         358913 McScript_deploy_error.log                                                                                              
-a----        10/7/2019  11:09 AM         503375 McScript_error.log                                                                                                     
-a----        10/5/2019   2:29 PM        2097210 McScript_error_backup_1.log                                                                                            
-a----       10/22/2019  12:34 PM        1376608 mfemactl.log                                                                                                           
-a----       10/22/2019  12:00 PM         206374 mfemactl_c.log 

#>