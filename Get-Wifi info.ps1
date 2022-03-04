# This is a DOS shell command but works fine in PowerShell also.
# Type this command into the command line of a computer already connected to that WiFi: netsh wlan show profile WiFi-name key=clear
# Where WiFi-name = the SSID of your current connection.

netsh wlan show profile WiFi-name key=clear


# This short version will get a list of all the created wifi profiles on the machine.

netsh wlan show profile