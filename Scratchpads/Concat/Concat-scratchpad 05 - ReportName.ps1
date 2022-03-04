# WORKING VERSION !!!!!!!!!!!!!!!!!
# Don't forget to change the query name between the tags <name></name>  in the $docheader section.
# Or you can edit that in the output file. 

# Set date/time variable to be used in output name. In format like: "0503_1403"
$time = Get-Date -format "ddmm_HHmm"

# Set input and output files here:
$ReportName = 'TERRY-TESTING-WhooHooItWorks'
$inputfile = 'c:\temp\Concatenation\concatenate_test.txt'
$outputfile = "c:\temp\Concatenation\$ReportName-$time.xml"

# XML chunks:
$docheader = "<list id='1'>
  <query id='2'>
    <dictionary id='3'/>
    <name>$ReportName</name>
    <description></description>
    <target>EPOLeafNode</target>
    <table-uri>query:table?orion.table.order=asc&amp;orion.table.columns=EPOLeafNode.NodeName%3AEPOLeafNode.ManagedState%3AEPOComputerProperties.IPV6%3AEPOComputerProperties.UserName%3AEPOLeafNode.LastUpdate%3AEPOProdPropsView_EPOAGENT.productversion%3AEPOComputerProperties.OSType&amp;orion.table.order.by=EPOLeafNode.NodeName</table-uri>
    <condition-uri>query:condition?orion.condition.sexp=%28+where+%28+or+%28+eq+EPOLeafNode.NodeName+"

$docfooter = '<summary-uri>query:summary?orion.query.type=table.table&amp;orion.sum.query=false</summary-uri>
  </query>
</list>'

$linestart = '%22'
$lineend = '%22+%29+%28+eq+EPOLeafNode.NodeName+'
$finallineend = '%22+%29+%29+%29</condition-uri>'

# Do the thing:  -------------------------------------------------
$docheader | Out-File -FilePath $outputfile -Encoding ascii
$list = get-content $inputfile

foreach ($line in $list) { 
    if ($line.ReadCount -gt ($list.Count - 1)) { 
        $line = $linestart + $line + $finallineend
        $line | Out-File -FilePath $outputfile -Encoding ascii -Append
        } 

    else { 
        $Line = $linestart + $line + $lineend
        $line | Out-File -FilePath $outputfile -Encoding ascii -Append
        }
}

$docfooter | Out-File -FilePath $outputfile -Encoding ascii -Append
# end