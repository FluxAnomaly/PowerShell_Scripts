# Test splunk paths:

Test-Path 'C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe'

Test-Path 'C:\Program Files\SplunkUniversalForwarder\etc\apps\nms-aoc-winevents\default\inputs.conf'



Test-Path 'C:\Program Files\SplunkUniversalForwarder\etc\apps\nms-default-desktops'

Test-Path 'C:\Program Files\SplunkUniversalForwarder\etc\apps\nms-aoc-winevents'



# Test for SplunkForwarder service

Get-Service SplunkForwarder