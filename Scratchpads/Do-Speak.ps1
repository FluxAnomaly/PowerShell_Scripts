# Do-Speak:  Have computer speak any sentence you type in. 
# https://sid-500.com/2018/03/07/do-speak-start-talking-with-remote-computers-system-speech/

Function Do-Speak {
 
[CmdletBinding()]
 
param
(
 
[Parameter(Position=0)]
 
$Computer
 
)
 
If (!$computer)
 
{
 
$Text=Read-Host 'Enter Text'
 
[Reflection.Assembly]::LoadWithPartialName('System.Speech') | Out-Null
$object = New-Object System.Speech.Synthesis.SpeechSynthesizer
$object.Speak($Text)
 
}
 
else {
 
$cred=Get-Credential
 
$PS=New-PSSession -ComputerName $Computer -Credential $cred
 
Invoke-Command -Session $PS {
$Text=Read-Host 'Enter Text'
 
[Reflection.Assembly]::LoadWithPartialName('System.Speech') | Out-Null
$object = New-Object System.Speech.Synthesis.SpeechSynthesizer
$object.Speak($Text)
}
 
}
 
}