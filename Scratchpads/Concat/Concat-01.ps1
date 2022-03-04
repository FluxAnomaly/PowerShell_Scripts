# Take input from a text file, contatenate with headers, footers & stored strings to create XML output. 

$inputfile = 'c:\temp\concatenate_test.txt'
$outputfile = 'c:\temp\concat.xml'

$docheader = '<list id="1">
  <query id="2">
    <dictionary id="3"/>
    <name>**RESEARCHING-TW**</name>
    <description></description>
    <target>EPOLeafNode</target>
    <table-uri>query:table?orion.table.order=asc&amp;orion.table.columns=EPOLeafNode.NodeName%3AEPOLeafNode.ManagedState%3AEPOComputerProperties.IPV6%3AEPOComputerProperties.UserName%3AEPOLeafNode.LastUpdate%3AEPOProdPropsView_EPOAGENT.productversion%3AEPOComputerProperties.OSType&amp;orion.table.order.by=EPOLeafNode.NodeName</table-uri>
    <condition-uri>query:condition?orion.condition.sexp=%28+where+%28+or+%28+eq+EPOLeafNode.NodeName+
    
    '

$lineheader = '%22'

$lineend = '%22+%29+%28+eq+EPOLeafNode.NodeName+'

$finallineend = '%22+%29+%29+%29</condition-uri>'

$docfooter = '    <summary-uri>query:summary?orion.query.type=table.table&amp;orion.sum.query=false</summary-uri>
  </query>
</list>'

Get-content $inputfile | foreach {



}


$testname01 = 'TERRY'
$testname02 = 'ALSTON'
$testname03 = 'WOLFREY'

$demo1 = "$lineheader" + "$testname01" + "$lineend"
$demo2 = "$lineheader" + "$testname02" + "$lineend"
$demo3 = "$lineheader" + "$testname03" + "$finallineend"

# Output section:
$docheader | Out-File -FilePath $outputfile -Append
$demo1 | Out-File -FilePath $outputfile -Append
$demo2 | Out-File -FilePath $outputfile -Append
$demo3 | Out-File -FilePath $outputfile -Append
$docfooter | Out-File -FilePath $outputfile -Append


# Open in notepad so you can clear old entries.   
notepad $outputfile



<# NOTES:

Get-Content
Add-Content

https://social.technet.microsoft.com/Forums/en-US/d7a84189-fa3f-4431-8b03-30a7d57d076a/getcontent-read-last-line-and-action?forum=winserverpowershell

#>


<# Concatenation examples:

$demo = 'abc' + 'def'

#>

