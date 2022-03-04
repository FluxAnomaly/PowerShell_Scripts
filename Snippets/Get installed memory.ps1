# Get installed memory in a machine:

$remotepc = 'xx'; Get-CimInstance -ComputerName $remotepc Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | Foreach {"{0:N2} GB" -f ($_.Sum / 1GB)} 