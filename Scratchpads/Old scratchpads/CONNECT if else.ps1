$remotepc = '30.56.10.196'
$remotepc = '10.0.1.12'

Function Connect-To {
#$RemotePC = read-host -Prompt 'Input Host Name or IP to connect to';
Write-Host "Attempting connection to $RemotePC."
Enter-PSSession -computer $RemotePC -SessionOption (New-PSSessionOption -NoMachineProfile) -credential $MyCred
if ($?) {
    Clear;Write-Host "Connected to $RemotePC."
    }
    else { Write-Host "Connection failed, attempting to start WinRM on $RemotePC."
    c:\tools\pstools\psexec -h -s -e -d \\$RemotePC winrm.cmd quickconfig -q 
    }
}


# To run the function after it's saved to memory during testing. 
Connect-To


<# 
# PowerShell’s return value, or exit code…
# The PowerShell operator $? contains True if the last operation succeeded and False otherwise.
$?

$LASTEXITCODE

# Example if else syntax:
if(Boolean_expression) {
   // Executes when the Boolean expression is true
}else {
   // Executes when the Boolean expression is false
}

#>