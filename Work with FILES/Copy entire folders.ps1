# Author:  Terry Wolfrey
# Copy entire folders and contents recursively

$target = 'L2X386M2'
Copy-Item -Path C:\TOOLS\PSTools -Destination "\\$target\c$\EndpointTools\" -Recurse -Verbose





# =============   Scratchpad below this point:   ================================================
# By default, Copy-Item will not overwrite it read-only files. To force the override, just add the Force parameter.
# It will however overwrite existing copies of a file which are not write protected.  (Can this be altered?)

$target = 'VA1-W7VM3714'

Copy-Item -Path C:\Temp\ -Destination C:\Temp1\ -Recurse -Verbose

Copy-Item -Path C:\Temp2\ -Destination "\\$target\c$" -Recurse -Verbose


# EXAMPLES: 

    Copy-Item –Path 'Path' –Destination 'path'
    Copy-Item –Path 'C:\Users\af75244\Downloads\McAffee Tools\MFERemoval100.exe' –Destination "\\$target\c$\temp" -Verbose

    C:\> Copy-Item -Path C:\EmptyFolder\ -Destination C:\PointB\

    # Not sure when you'd pipe like this?
    Get-ChildItem -Path C:\PointB\ -Recurse | Copy-Item -Destination C:\PointC
    
    # Copy the contents of a directory to another directory
    Copy-Item "C:\Logfiles" -Destination "C:\Drawings" -Recurse

    # Copy the contents of a directory to another directory and create the destination directory if it does not exist
    Copy-Item C:\Logfiles -Destination C:\Drawings\Logs -Recurse

    # Copying folder and sub-folders
    Copy-Item -Path C:\Temp\ -Destination C:\Temp1\ -Recurse -Verbose