# WORKING VERSION !!!!!!!!!!!!!!!!!
# Don't forget to change the Name of the report in the $docheader section.

# Date/time stamp:
$time = Get-Date -format "ddmm_HHmm"    # Set date/time variable to be used in output name. In format: "0503_1403"

# Set input and output files here:
$inputfile = 'c:\temp\Concatenation\concatenate_test.txt'
$outputfile = "c:\temp\Concatenation\$time-concat-ascii.xml"
$ReportName = 'TERRY-TESTING'

# XML chunks:
$docheader = '<list id="1">
  <query id="2">
    <dictionary id="3"/>
    <name>TW - Testing XML structure 4.14pm</name>
    <description></description>
    <target>EPOLeafNode</target>
    <table-uri>query:table?orion.table.order=asc&amp;orion.table.columns=EPOLeafNode.NodeName%3AEPOLeafNode.ManagedState%3AEPOComputerProperties.IPV6%3AEPOComputerProperties.UserName%3AEPOLeafNode.LastUpdate%3AEPOProdPropsView_EPOAGENT.productversion%3AEPOComputerProperties.OSType&amp;orion.table.order.by=EPOLeafNode.NodeName</table-uri>
    <condition-uri>query:condition?orion.condition.sexp=%28+where+%28+or+%28+eq+EPOLeafNode.NodeName+'

$docfooter = '<summary-uri>query:summary?orion.query.type=table.table&amp;orion.sum.query=false</summary-uri>
  </query>
</list>'
$lineheader = '%22'
$lineend = '%22+%29+%28+eq+EPOLeafNode.NodeName+'
$finallineend = '%22+%29+%29+%29</condition-uri>'

# Do the thing:  -------------------------------------------------
$docheader | Out-File -FilePath $outputfile -Encoding ascii
$list = get-content $inputfile

foreach ($line in $list) { 
    if ($line.ReadCount -gt ($list.Count - 1)) { 
        $line = $lineheader + $line + $finallineend
        $line | Out-File -FilePath $outputfile -Encoding ascii -Append
        } 

    else { 
        $Line = $lineheader + $line + $lineend
        $line | Out-File -FilePath $outputfile -Encoding ascii -Append
        }
 }

$docfooter | Out-File -FilePath $outputfile -Encoding ascii -Append
# end