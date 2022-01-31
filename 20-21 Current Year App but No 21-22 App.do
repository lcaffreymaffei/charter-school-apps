//download this Salesforce base report as a csv and upload into stata: https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VGd6UAG/view?queryScope=userFolders

import delimited "C:\Users\Lucy Caffrey Maffei\Documents\report1608066433771.csv", bindquote(strict) varnames(1) 
gen currentyear2021 = 1 if applicationschoolyearname == "2020-2021" & recordtype =="Current Year" & status =="Submitted"
gen predeadline2122 = 1 if applicationschoolyearname =="2021-2022" & status =="Submitted"
tab currentyear2021
keep if currentyear2021 ==1 | predeadline2122 ==1
collapse (firstnm) parentguardianemailaddress currentyear2021 predeadline2122 ,by(contactid )
keep if currentyear2021 ==1 & mi(predeadline2122 )
drop currentyear2021 predeadline2122 contactid
duplicates drop parentguardianemailaddress ,force
drop if mi(parentguardianemailaddress )

//download and remove any email address of unsubscribers
