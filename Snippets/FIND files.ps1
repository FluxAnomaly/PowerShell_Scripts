# Find files on system:
    # http://www.powershellcookbook.com/recipe/lvCW/find-files-that-match-a-pattern
    # https://blogs.technet.microsoft.com/heyscriptingguy/2016/06/27/use-windows-powershell-to-search-for-files/


# WORKING EXMAPLES:

# I like how this works but it may be TOO verbose:   https://stackoverflow.com/a/8677658
Get-Childitem –Path C:\ -Filter KTEMAI*.dll -Recurse -ErrorAction SilentlyContinue -Force

Get-Childitem –Path C:\ -Filter myfunc.* -Recurse -ErrorAction SilentlyContinue -Force


Get-ChildItem -Path c:\temp\*.txt -Recurse






######################################################################################################
# Notes and scratchpad below here:
######################################################################################################

# Find Files That Match a Pattern:
Get-ChildItem

# To find all items in the current directory that match a PowerShell wildcard, supply that wildcard to the Get-ChildItem cmdlet:
Get-ChildItem *.txt

# To find all items in the current directory that match a provider-specific filter, supply that filter to the -Filter parameter:
Get-ChildItem -Filter *~2*

# To find all items in SUBDIRECTORIES that match a PowerShell wildcard, use the -Include and -Recurse parameters, or use the wildcard as part of the -Path parameter:
Get-ChildItem -Include *.txt -Recurse
Get-ChildItem *.txt -Recurse
Get-ChildItem -Path c:\temp\*.txt -Recurse

# -------------------------------------------------

Get-ChildItem -Include j2018.1808.10.400-enu-x64.exe -Recurse

# These work:
Get-ChildItem -Filter  j2018.1808.10.400-enu-x64.exe -Recurse
Get-ChildItem -Filter  j*enu-x64.exe -Recurse



# From original scratchpad.
# ----------------------------------------------------------------------------------------------------------
# Find files:   https://blogs.technet.microsoft.com/heyscriptingguy/2016/06/27/use-windows-powershell-to-search-for-files/
Get-Childitem –Path C:\ -Include *KTEMAI* -File -Recurse

# I like how this works but it may be TOO verbose:   https://stackoverflow.com/a/8677658
Get-Childitem –Path C:\ -Filter KTEMAI*.dll -Recurse -ErrorAction SilentlyContinue -Force