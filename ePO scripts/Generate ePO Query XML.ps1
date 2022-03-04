# Set date/time variable to be used in output name. 
$time = Get-Date -format "MMddyy_HHmm"    # If you don't want the timestamp don't run this line.

# Set input and output files here:
$QueryName = "QUERYNAME-$time"
$inputfile = "C:\PROJECTS\hostlist.txt"
$outputfile = "C:\PROJECTS\$QueryName.xml"


# DO NOT EDIT BELOW HERE:  -----------------------------------------------------------------------------------------

# XML chunks. 
$docheader = "<list id='1'>
  <query id='2'>
    <dictionary id='3'/>
    <name>$QueryName</name>
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


<# NOTES: ----------------------------------------

Get-Content :
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7

.Count :
Count number of lines in machine name list file.

.ReadCount (This is a PowerShell NoteProperty. Look it up.)
I don't recall how this works. 
Doing $list.readcount counted out the number of lines in the list. So I"m guessing it counts/numbers each line.  
So then if ReadCount is greater than the next to last line (ie: on the last line ($list.Count - 1), go to the else statement.


****************************************
foreach ($line in $list) { 
if ($line.ReadCount -gt ($list.Count - 1))


======================================
Other possible last line solutions?

Build on this:
Get-Content $inputfile | Select-Object -last 1

https://www.reddit.com/r/PowerShell/comments/f7jlmb/forgot_how_varreadcount_works_cant_find_info_help/
        $Lines = Get-Content .\Lines.txt
        $LastLine = Get-Content .\Lines.txt -Tail 1

        foreach ($Line in $Lines) {

            switch($Line) {

                Default {$Line}
        
                # Last line handled differently
                $LastLine {Write-Host "$Line is last line"}
            }
        }


#>