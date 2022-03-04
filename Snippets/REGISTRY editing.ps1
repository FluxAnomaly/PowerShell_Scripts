# REGISTRY editing with powershell:

# Test Machines:   
    $remotepc = 'D9GVKDH2'  # Cliff lab 2. 
    $remotepc = '30.239.67.139' 

#######################  Local Versions  ##################################################################

# Set Value:
    Set-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEMode" -Value 1
    Set-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEModeOnReboot" -Value 0
    Set-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "InvUpgradeConfig" 0


# Check value.
    Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEMode"
    Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEModeOnReboot"

    Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "InvUpgradeConfig"


#######################  Remotely Edit  ##################################################################
$remotepc = '30.239.147.32' 

# Set value
    Invoke-Command -ComputerName $remotepc -Command {Set-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEMode" -Value 2}
    Invoke-Command -ComputerName $remotepc -Command {Set-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEModeOnReboot" -Value 2}

# Confirm value
    Invoke-Command $remotepc {Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEMode"}
    Invoke-Command $remotepc {Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Services\swin\Parameters -Name "RTEModeOnReboot"}
    


# ==================================================================================================
# GDIPLUS.DLL issue:
    On the below Registry key, change the value to 2, which is Update Mode:

    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\swin\Parameters DWORD - RTEModeOnReboot
    0 = Disabled
    1 = Enabled
    2 = Update
    3 = Observe
# ==================================================================================================




# See also:

Get-ItemPropertyValue
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itempropertyvalue?view=powershell-6


