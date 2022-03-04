# Working with FILES

# New-Item           https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-6

# Create a directory
New-Item -Path "c:\" -Name "logfiles" -ItemType "directory"



# Remove-Item       https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-6

# Delete files in subfolders recursively
Get-ChildItem * -Include *.csv -Recurse | Remove-Item

# DELETE directory and all sub content
Remove-Item -Path C:\Test\hidden-RO-file.txt -Force    # book example

Remove-Item -Path "C:\program files\mcafee" -Recurse -Force

Invoke-Command $remotepc {Remove-Item -Path "C:\program files\mcafee" -Recurse -Force}








<# MISC NOTES 

Since 'del' is an alias for Remove-Item works like 'del /s /f' in DOS, or 'rmdir /s'.   (verify this)
del .\Solidcore -Recurse -Force


#>