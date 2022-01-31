//DO THIS ON JANUARY 26, 2021 

//download the following report as a csv and upload into stata: https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VGlFUAW/view

//cleaning and saving locally the above file
	rename applicationschoolschool school
	rename futureyeargradespan gradesserved
	replace gradesserved =subinstr(gradesserved ,"K4 (Russell Byers) or K (Keystone Academy DOB 9/2 - 10/1)","K4",.)
	tempfile schoolgrades
	save `schoolgrades'
	clear
	
//download the following report as a csv and upload into stata: https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VDtBUAW/view

//cleaning the file and merging it with the `schoolgrades' file to find students who are applying to grades at schools that do not serve that grade
	rename application* *
	keep applicationid studentfirstname studentlastname school gradestudentisapplyin parentguardianfirstna parentguardianlastnam parentguardiancellpho parentguardianhomepho 
	rename parentguardiancellpho cellphone
	rename parentguardianhomepho homephone
	rename gradestudentisapplyin studentgrade
	gen parent name = parentguardianfirstna +" "+ parentguardianlastnam
	drop parentguardianlastnam parentguardianfirstnamerge m:1 school using `schoolgrades'
	drop _merge
	keep if !strpos(gradesserved ,studentgrade )

//download final product and send to Heather/the helpline to have them call parents and fix errors
