# Put the computer in update mode
# Flush all the policies: 
# Force a Wake-UP so that the computer gets new policy
# End Update mode in 2-3 days. You will need to keep track of this. 



sadmin updaters flush
sadmin skiplist flush
sadmin ruleengine flush
sadmin attr flush
sadmin aef flush
sadmin cert flush
sadmin trusted -f
