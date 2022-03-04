Get-ADPrincipalGroupMembership AF92217 | select name >>AF92217.txt 


<#
From Eric Bivens:

First, I created a PS1 with a command "Get-ADPrincipalGroupMembership AF92217 | select name >>AF92217.txt " for each userid.
so there were 15 lines.  When I ran it, it produced 15 files, each with the name of the userid with .TXT extension.
Then I put all the userids into a file called "vips.in" and ran the command:

for /f %a in (vips.in) do find "dl-" <%a.txt >dl-%a.out
which found only the groups with "dl-" in them.
so now I have 15 files with only "DL-" entries.

Then I made a command file that had the following line in it:
for /f "tokens=*" %%a in (dl-%a.out) do echo %1  <tab> %%a >>alldls.txt
where <tab> was a tab character.

Now in the file alldls.txt, each line has the userid, a tab, then the DL group.
open that in notepad, select all, copy, paste into Excel, and manipulate from there.

I had to mingle CMD and PS stuff.

#>