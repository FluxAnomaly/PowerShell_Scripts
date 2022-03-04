#CREATING / ALTERING / ETC.

# Creates file in currect folder with contents:
New-Item -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."



# Other ways to Create file:
$text = 'Hello World'

$text | Set-Content 'file.txt'
#or
$text | Out-File 'file.txt'
#or
$text > 'file.txt'


# Append to file:
$text | Add-Content 'file.txt'
#or
$text | Out-File 'file.txt' -Append
#or
$text >> 'file.txt'

# Read contents of file to console:
get-Content dictionary.txt
Get-Content 'C:\Users\af75244\Downloads\McAffee Tools\ReadMe.txt'