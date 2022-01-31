//download this report as a csv and import into stata (making variable names in lowercase): https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VGd6UAG/view?queryScope=userFolders

gen appfor2122 = 1 if applicationschoolyearname == "2021-2022" & status =="Submitted" & recordtype =="Pre-Deadline"
collapse (firstnm) parentguardianemailaddress appfor2122,by(contactid )
tab appfor2122
keep if !mi(appfor2122 )
drop if mi(parentguardianemailaddress )
duplicates drop parentguardianemailaddress ,force
drop appfor2122 contactid

//download list of emails and remove any emails of unsubscribers
