//download this report from salesforce as a csv and import into salesforce (keeping the variable names lowercase): https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VGulUAG/view

keep if expirationdateonly =="3/12/2021" & offerstatus =="Outstanding Offer"
collapse (firstnm) studentfirstname studentlastname gradestudentisapplyin parentguardianfirstna parentguardianlastnam parentguardiancellpho parentguardianhomepho parentguardianemailaddress,by(applicationid )
sort parentguardiancellpho

//only do the following steps if running for email list. no necessary for helpline use
keep parentguardianemailaddress
drop if mi(parentguardianemailaddress)
duplicates drop parentguardianemailaddress, force

//export report and delete any email addresses from unsubscribers
