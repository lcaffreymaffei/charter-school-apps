//download and import base report from salesforce as a csv.
//mostly you will just need to use this report: https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VDtBUAW/view
//if using the above report, keep in mind that it has all pre-deadline, post-deadline, and current year apps for SY 21-22,
//so if you are just looking for pre-deadline apps, only keep rows where recordtype=="Pre-Deadline"

rename application* *
duplicates drop applicationid ,force
gen appsperzip = 1
gen zip =substr(zipcode ,1,5)
collapse (sum) appsperzip ,by(zip)
rename zip zipcode
tempfile appsperzip
save `appsperzip'
clear

//import file containing numbers of school aged children in each zip code, which can be found in this folder: https://drive.google.com/drive/u/0/folders/14SsgLrlwEdcSm-ls4hUx8cbc8VTB0W42

tostring zipcode ,force replace
merge 1:1 zipcode using `appsperzip'
keep if _merge==3
drop _merge
gen pct_of_sac_with_apps = appsperzip/ numberofschoolagedchildren*100

//export as csv and follow directions in the Operations & Data Analyst Onboarding doc to create the heat map of Philadelphia
