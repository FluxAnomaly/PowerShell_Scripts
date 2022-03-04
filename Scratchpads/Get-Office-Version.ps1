# Check machines Office version:

Get-WmiObject win32_product -ComputerName computername | where{$_.Name -like "Microsoft Office Professional Plus*"} | select Name,Version

$TargetHost = 'L4RN86H2'
Get-WmiObject win32_product -ComputerName $TargetHost | where{$_.Name -like "Microsoft Office*"} | select Name,Version | Format-Table -AutoSize



# Excel version:
Get-WmiObject win32_product -ComputerName $TargetHost | where{$_.Name -like "Microsoft Excel*"} | select Name,Version | Format-Table -AutoSize


L5B7MXY2

LG86HQN2
L4RN86H2