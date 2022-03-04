# Modify HOSTS file: 

# Adds the entry below to the hosts file, modify as needed:
"ip     hostname" | Out-File 'C:\Windows\System32\drivers\etc\hosts' -Append -Encoding ascii

"$HostIP     $HostName" | Out-File 'C:\Windows\System32\drivers\etc\hosts' -Append -Encoding ascii


# Open in notepad so you can clear old entries.   
notepad C:\Windows\System32\drivers\etc\hosts



# Misc stuff:

# How to reset the Hosts file back to the default
https://support.microsoft.com/en-us/help/972034/how-to-reset-the-hosts-file-back-to-the-default

# Hosts file backup:
<#
# Copyright (c) 1993-2006 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to host names. Each
# entry should be kept on an individual line. The IP address should
# be placed in the first column followed by the corresponding host name.
# The IP address and the host name should be separated by at least one
# space.
#
# Additionally, comments (such as these) may be inserted on individual
# lines or following the machine name denoted by a '#' symbol.
#
# For example:
#
#      102.54.94.97     rhino.acme.com          # source server
#       38.25.63.10     x.acme.com              # x client host
# localhost name resolution is handle within DNS itself.
#       127.0.0.1       localhost
#       ::1             localhost 


#>


<#
#For NC, no new entry above, between this and next comments
162.95.219.150      myconnection.antheminc.com
#end of NC entry
#>