$lines = Get-Content someFile.txt
for ($x=0; $x -lt $lines.count -1; $x++) {
    # normal manipulation
    $lines[$x] = $lines[$x] -replace "this", "that"
}
# Last line manipulation
$lines[$x] = $lines[$x] -replace "foo", "bar"
$lines | Out-File newFile.txt