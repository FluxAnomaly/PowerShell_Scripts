You can read XML simply by casting a string to [xml]:

$xml = [xml](Get-Content foo.xml)
Then you can use

$xml.ValCurs.Valute | Where-Object {$_.ID -eq 826} | Select-Object Nominal,Value






$fileLoc = "C:\TEMP\BOWLING\VPNDisable_ServiceProfile.xml"

[ xml ] $fileContents = Get-Content -Path $fileLoc

#$fileContents = Get-Content -Path $fileLoc
#Write-Host $fileContents


$fileContents.AnyConnectProfile.ClientInitialization.ServiceDisable | Where-Object {$_.ServiceDisable -eq "true"} | Select-Object ServiceDisable
$fileContents.AnyConnectProfile.ClientInitialization.ServiceDisable | Select-Object ServiceDisable

Write-Host $fileContents.AnyConnectProfile.ClientInitialization.ServiceDisable | Where-Object {$_.ServiceDisable -eq "true"} | Select-Object ServiceDisable
Write-Host $fileContents.AnyConnectProfile.ClientInitialization.ServiceDisable | Select-Object ServiceDisable


if ($fileContents.AnyConnectProfile.ClientInitialization.ServiceDisable -eq "true") {

Write-Host "This test is TRUE"

}

else {Write-Host "This test is FALSE"}