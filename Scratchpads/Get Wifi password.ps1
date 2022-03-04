# Get wifi password from command line
# https://helpdeskgeek.com/how-to/find-the-wifi-password-in-windows-10-using-cmd/


# To see stored network profiles, Type the following command line and hit Enter:
NETSH WLAN SHOW PROFILE

# Type the following command and replace “WIFI” with the network name.
# Then look for 'Key Content' in the security section.
NETSH WLAN SHOW PROFILE WIFI KEY=CLEAR

$wifi = "Sole Clubroom"
NETSH WLAN SHOW PROFILE $wifi KEY=CLEAR


    # Example:
    NETSH WLAN SHOW PROFILE FuelPumpGuest KEY=CLEAR

