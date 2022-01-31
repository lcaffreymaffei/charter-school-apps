//download this base report from Salesforce as a CSV and import into Stata: https://applyphillycharter.my.salesforce.com/00O2G000006VGd6UAG?isdtp=p1

	gen appfor2122 = 1 if applicationschoolyearname == "2021-2022" & status =="Submitted"
	collapse (firstnm) parentguardianemailaddress appfor2122 ,by(contactid )
	keep if mi(appfor2122 )
	drop if mi(parentguardianemailaddress )
	duplicates drop parentguardianemailaddress ,force
	drop appfor2122
	
//export list and remove any email addresses of unsubscribers
