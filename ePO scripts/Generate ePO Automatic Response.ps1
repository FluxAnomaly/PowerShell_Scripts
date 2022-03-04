# Author:  Terry Wolfrey
# Date:    06/18/2020
# Generates the XML for an 'Automatic Response' in ePO which sends an email when hosts connect to ePO. 
# Input taken from text file list of host names.

# IMPORTANT NOTE: you'll need to change the filter once imported to ePO from AND to OR for it to work right.   I haven't figured out how to script that yet.
# ------------------------------------------------------------------------------------------------------------------

# Set date/time variable to be used in output name. 
$time = Get-Date -format "MMddyy_HHmm"    # If you don't want the timestamp don't run this line.

# Set input and output files here:
$FileName = "Terry-Testing_EndSecHosts_V6-$time"
$inputfile = "C:\Temp\hostlist.txt"
$output = "C:\Temp\$FileName.xml"

# Set rule name here:
$rulename = "$FileName"

# Set email body and subject here:
$body = '{hostName} Device has connected to console ePO 300'
$subject = '{hostName} Device has connected to console ePO 300'
$recipient = 'terry.wolfrey@anthem.com'

# DO NOT EDIT BELOW HERE:  -----------------------------------------------------------------------------------------

# XML chunks: 
$docheader = "<list id='1'>
  <ResponseRule id='2'>
    <name>$rulename</name>
    <description>Send notification when specific devices check in. (Can be tested with Agent Wakeup.</description>
    <eventType>epoClientStatusEvent</eventType>
    <locale>en</locale>
    <conditionURI>rule:condition?conditionSexp=%28+where+%28+and+%28"

$linestart = '+eq+epoClientStatusEvent.hostName+%22'
$lineend = '%22+%29+%28'
$finallineend = '%22+%29+%29+%28+newerThan+epoClientStatusEvent.receivedUTC+3600000++%29+%29+%29&amp;requiredFilter=%28+where+%28+descendsFrom+epoClientStatusEvent.definedAt+%222%22+%29+%29</conditionURI>'

$actionsdata = "<actions id='3'>
      <response-action id='4'>
        <commandId>response.send-email</commandId>
        <params id='5'>
          <entry>
            <string>body</string>
            <string>$body</string>
          </entry>
          <entry>
            <string>subject</string>
            <string>$subject</string>
          </entry>
          <entry>
            <string>importance</string>
            <string>HIGH</string>
          </entry>
          <entry>
            <string>recipients</string>
            <string>$recipient</string>
          </entry>
        </params>
      </response-action>
    </actions>
  </ResponseRule>
</list>"

# Do the things:  -----------------------------------------------------------------------------------------

$docheader | Out-File -FilePath $output -Encoding ascii
$list = get-content $inputfile

# Where the magic happens: 
foreach ($line in $list) { 
    if ($line.ReadCount -gt ($list.Count - 1)) { 
        
        # Last line of loop and 'actionsdata' added here.
        $line = $linestart + $line + $finallineend
        $line | Out-File -FilePath $output -Encoding ascii -Append
        } 
    
    else { 
        # Main body of work building hostname part of XML is done here.
        $Line = $linestart + $line + $lineend
        $line | Out-File -FilePath $output -Encoding ascii -Append
        }
}

# $throttling | Out-File -FilePath $output -Encoding ascii -Append
$actionsdata | Out-File -FilePath $output -Encoding ascii -Append

Write-Host "Generation complete. Import into ePO and make any final adjustments there." -F Green
# end


