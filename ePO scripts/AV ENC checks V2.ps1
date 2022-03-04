# Set date/time variable to be used in output name. 
$time = Get-Date -format "MMdd-HHmm"    # If you don't want the timestamp don't run this line.

# Set input and output files here:
$QueryName = "AV_ENC_checks-$time"
$work_dir = 'C:\PROJECTS\AV ENC checks\2-23 special\'

$inputfile = "$work_dir"+"hostlist.txt"
$outputfile = "$work_dir"+"$QueryName.xml"

# DO NOT EDIT BELOW HERE:  -----------------------------------------------------------------------------------------
# XML chunks. 
$docheader = "<list id='1'>
  <query id='2'>
    <dictionary id='3'/>
    <name>$QueryName</name>
    <description></description>
    <target>EPOLeafNode</target>
    <table-uri>query:table?orion.table.order=asc&amp;orion.table.columns=EPOLeafNode.NodeName%3AEPOLeafNode.LastUpdate%3AEPOProdPropsView_MVISIONENDPOINT.productversion%3AMVIS_EP_CustomProps.DefenderAntivirusSigLastUpdated%3AEPOProdPropsView_TIECLIENTMETA.productversion%3AEPOProdPropsView_THREATPREVENTION.productversion%3AEPOProdPropsView_MCAFEE_MNE.productversion%3AMneFVProperties.MachineEncryptionStatus%3AMneFVProperties.BitlockerProtectionStatus%3AEPOProdPropsView_MCAFEE_EED.productversion%3AEPOProdPropsView_MCAFEE_EEPC.productversion%3AEPESystems.State%3AEPESystems.EncryptionProvider&amp;orion.table.order.by=EPOLeafNode.NodeName</table-uri>
    <condition-uri>query:condition?orion.condition.sexp=%28+where+%28+or+%28+eq+EPOLeafNode.NodeName+"

$docfooter = '<summary-uri>query:summary?orion.query.type=table.table&amp;orion.sum.query=false</summary-uri>
  </query>
</list>'

$linestart = '%22'
$lineend = '%22+%29+%28+eq+EPOLeafNode.NodeName+'
$finallineend = '%22+%29+%29+%29</condition-uri>'

# Do the things:  -------------------------------------------------
$docheader | Out-File -FilePath $outputfile -Encoding ascii
$list = get-content $inputfile

# Where the magic happens: 
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
