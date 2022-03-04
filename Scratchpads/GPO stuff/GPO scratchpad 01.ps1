(get-gpo -all).count

Get-GPOReport -All -Domain $env:USERDNSDOMAIN -ReportType Xml (Select-Xml -Xml $GpoReport -XPath '/GPOS') | Format-Table -AutoSize

Get-GPO -All | select -First 1 | select id

# How to export all group policies to HTML
Get-GPO -all | % { Get-GPOReport -GUID $_.id -ReportType HTML -Path "C:\Temp\PROJECTS\Admin Remediation\$($_.displayName).html" }

# How to export all group policies to XML
Get-GPO -all | % { Get-GPOReport -GUID $_.id -ReportType xml -Path "C:\Temp\PROJECTS\Admin Remediation\XML\$($_.displayName).xml" }



# Example 1: Generate an HTML report for the specified GPO
Get-GPOReport -Name "TestGPO1" -ReportType HTML -Path "C:\Temp\PROJECTS\Admin Remediation\GPOReport1.html"
 
# Example 2: Generate an XML report for each GPO in the specified domain
Get-GPOReport -All -Domain "sales.contoso.com" -Server "DC1" -ReportType XML -Path "C:\Temp\PROJECTS\Admin Remediation\GPOReportsAll.xml"


# Generate a report for the specified computer
Get-GPResultantSetOfPolicy -ReportType Xml -Computer "computer-08.contso.com" -Path "C:\Temp\PROJECTS\Admin Remediation\computer-08.xml"

Get-GPResultantSetOfPolicy -ReportType Xml -Computer "L4XW56M2" -User af75244 -Path "C:\Temp\PROJECTS\Admin Remediation\RSoP_L4XW56M2-af75244.xml"
Get-GPResultantSetOfPolicy -ReportType html -Computer "L4XW56M2" -User af75244 -Path "C:\Temp\PROJECTS\Admin Remediation\RSoP_L4XW56M2-af75244.html"

# 
# Generate a report for the default user that is running on the current session
Get-GPResultantSetOfPolicy -ReportType Xml -Path "C:\Temp\PROJECTS\Admin Remediation\LocalUserAndComputerReport.xml"