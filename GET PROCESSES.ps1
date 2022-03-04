# List processes CPU usage.      Remote Process Explorer is also very useful, is gui & gives time graph. 

# NOTE:  McAfee Solidcore process = scsrvc

# LOCAL versions:   ======================================================================================

#USE THIS VERSION:
# To get all McAfee services in one command I wound up with this:
Get-Process | Where-Object {$_.Description -like "Mc*"} | sort -Descending cpu | Format-Table name, product, cpu, description -autosize	

# Even more info including Mem use:
Get-Process | Where-Object {$_.Description -like "Mc*"} | sort -Descending cpu | Format-Table description, cpu, PSResources -autosize

#(What are normal CPU levels like for these services?  Can I list them as percent of total?)



# ======================================================================================================================================
# REMOTE host process info: 
# ======================================================================================================================================
    
    $remotepc = 'ld8vc4q2'     #  Who?                 
    $remotepc = "LJWPK5Q2"     #  Who?
    $remotepc = 'ad85943'      #  Aaron Merrill
    
#USE THIS VERSION:
# To get all McAfee services in one command I wound up with this:
Invoke-Command $remotepc {Get-Process | Where-Object {$_.Description -like "Mc*"} | sort -Descending cpu | Format-Table name, product, cpu, description -autosize}

    # Nicely formatted with Name, Product, CPU usage, and Description columns.
    Invoke-Command $remotepc {Get-Process m* | where {$_.Product} | Format-Table name, product, cpu, description -autosize}
    # Also sorted by descending:
    Invoke-Command $remotepc {Get-Process m* | where {$_.Product} |sort -Descending cpu | Format-Table name, product, cpu, description -autosize}

    #NOTE:  These don't seem to work right on servers.  Why?

# ==================================================================================
# Original solutions:
# ==================================================================================

    # Lists all processes starting with M. Heaviest usage shown at top.
    Get-Process m* | sort -Descending cpu | Format-Table -autosize
    Get-Process m* | sort -Descending cpu | sort -Descending cpu | Format-Table -autosize 

    # Remote version:
    # Lists all processes starting with M. Heaviest usage shown at top.
    Invoke-Command $remotepc {Get-Process m* | sort -Descending cpu | Format-Table -autosize}


    # ------------------------------------------------------------------------------------------------------------------------------------------
    # Nicely formatted with Name, Product, CPU usage, and Description columns.
    Get-Process m* | where {$_.Product} | sort -Descending cpu | Format-Table name, product, cpu, description -autosize

    # Solidifier Process "scsrvc".
    Get-Process scsrvc | where {$_.Product} | sort -Descending cpu | Format-Table name, product, cpu, description -autosize  
    
    # ------------------------------------------------------------------------------------------------------------------------------------------

