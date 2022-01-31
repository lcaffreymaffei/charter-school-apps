//download this report from salesforce as a csv and upload it into stata with variable names lowercase: https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VGulUAG/view

gen numberofacceptances = 1 if offerstatus =="Accepted"
collapse (firstnm) studentfirstname studentlastname gradestudentisapplyin parentguardianfirstna parentguardianlastnam parentguardiancellpho parentguardianhomepho parentguardianemailaddress  (sum) numberofacceptances ,by(applicationid)
keep if numberofacceptances > 1
sort parentguardiancellpho

//only do the following steps if running for email list. not necessary for helpline use
duplicates drop parentguardianemailaddress ,force
drop if mi(parentguardianemailaddress )

//export file and remove any emails from unsubscribers
