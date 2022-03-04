
$RestartTarget = 'xxx'

# Powershell method

# Gives user NO WARNING!  See if you can incorporate one someohow. 
Restart-Computer -ComputerName $RestartTarget -Force

Restart-Computer -ComputerName $RestartTarget -Force -Timeout 10          #Timeout in seconds.  300 = 5 min.



# Solidcore command to restart computer:
sadmin recover -f -z CA23AF68D11B1D7
sadmin ssreboot -t 5 -m "Rebooting machine in 5 seconds"

# SHUT DOWN a computer:
Stop-Computer -ComputerName $RestartTarget -Force



# DOS ====================================

# Restart
shutdown /r /m \\D3CQ8CH2 /t 0

# Shutdown
shutdown /s /m \\HOST /t 0


Stop-Computer $RestartTarget