# DELETE files:     
# https://www.petri.com/delete-folder-file-from-command-line-powershell

$path = ''

# Works GREAT to delete folder and everything under it.
Remove-Item –path $path –recurse -FORCE

# It’s also possible to include a filter, like this:
Remove-Item –path c:\* -Filter *test* -whatif




# Doing it remotely:
$path = 'xxx'
$remotepc = 'xxx'
Invoke-Command -ComputerName $remotepc -ScriptBlock {Remove-Item –path $path –recurse -FORCE}

#short version:
Invoke-Command $remotepc {Remove-Item –path $path –recurse -FORCE}