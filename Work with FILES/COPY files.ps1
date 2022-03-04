# WORKING WITH FILES.  

$RemotePC = 'L42C2ZW2'
$LocalPC = 'L8S3X333'

# COPYING FILESs from one YOUR HOST to another.
mkdir c:\temp    # run this command from the host to make the folder first, then ...

# run these lines from YOUR machine.
Copy-Item –Path 'C:\Users\af75244\Downloads\McAffee Tools\MFERemoval100.exe' –Destination "\\$RemotePC\c$\temp" -Verbose
Copy-Item –Path 'C:\Users\af75244\Downloads\McAffee Tools\SC_Cleanup.exe' –Destination "\\$RemotePC\c$\temp"
Copy-Item –Path 'C:\Users\af75244\Downloads\McAffee Tools\FramePkg.exe' –Destination "\\$RemotePC\c$\temp"

Copy-Item 'C:\Users\af75244\Downloads\McAffee Tools\readme.txt' –Destination "\\10.128.110.139\c$\temp2"

Copy-Item –Path 'Path' –Destination 'path'



# ----------------------------------------------------------------------------------------------------------
# COPYING FILESs from one host to another.
Copy-Item –Path 'C:\temp\ProcessExplorer\procexp64.exe' –Destination '\\LGVQBYF2\c$\temp'

# Copy file from remote host to my machine:
    #but this has no source host name, so how would this work?
Copy-Item –Path 'C:\Program Files (x86)\UltiDev\Cassini Web Server for ASP.NET 2.0\AboutCassini.htm' –Destination '\\L3KC2YZ1\c$\temp\'


#Copy from remote machine to mine:
Copy-Item –Path "\\$RemotePC\Users\moorenr\AppData\Local\Temp\1\c8wmhb9k.dll" –Destination "\\$LocalPC\c$\temp\"

Test-Path "\\$RemotePC\Windows\"



C:\Windows\Microsoft.NET\Framework\v2.0.50727\csc.exe
