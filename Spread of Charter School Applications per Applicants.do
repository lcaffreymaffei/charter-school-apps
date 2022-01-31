//to get applicant for all grade levels with the number of applications they applied to, complete the below section	
	import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1572457275268.csv", bindquote(strict) varnames(1) 
	keep applicationapplicationid submitteddate applicationstudentfirstname applicationstudentlastname applicationschool applicationgradestudentisapplyin
	rename applicationapplicationid applicationid
	rename applicationstudentfirstname firstname
	rename applicationstudentlastname lastname
	rename applicationgradestudentisapplyin grade
	drop if strpos(firstname, "Test")
	destring grade, force replace
	duplicates tag applicationid, gen(numberofapps)
	gen numberofapps_new = numberofapps +1
	drop numberofapps
	rename numberofapps_new numberofapps
	duplicates drop applicationid, force
	summarize numberofapps, detail
	egen mode = mode(numberofapps)
	tab numberofapps
	
//to get only high school applicants, complete the below section
	preserve
	drop mode
	keep if grade == 9|grade==10|grade==11|grade==12
	summarize numberofapps, detail
	egen mode = mode(numberofapps)
	tab numberofapps
	export excel using "C:\Users\Lucy Caffrey Maffei\Documents\High School Applications per Applicant 10.30.19 140pm.xlsx"

//to get only k-8 applicants, complete the below section
	restore
	preserve
	drop mode
	keep if grade != 9&grade!=10&grade!=11&grade!=12
	summarize numberofapps, detail
	egen mode = mode(numberofapps)
	tab numberofapps
	export excel using "C:\Users\Lucy Caffrey Maffei\Documents\K-8 School Applications per Applicant 10.30.19 140pm.xlsx", firstrow(variables)
