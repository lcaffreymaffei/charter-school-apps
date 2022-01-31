
import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\All Application Schools with Grades Serving 2020-21.csv", bindquote(strict) varnames(1)
rename applicationschoolschool school
tempfile schools
save `schools'

import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\all applicants for export 1.22.20.csv", bindquote(strict) varnames(1) 
keep applicationapplicationid submitteddate applicationstudentfirstname applicationstudentlastname applicationschool applicationgradestudentisapplyin applicationparentguardianfirstna applicationparentguardianlastnam applicationparentguardiancellpho applicationparentguardianhomepho applicationparentguardianemailad
rename applicationgradestudentisapplyin grade
tempfile allapps
rename applicationschool school
save `allapps'
merge m:1 school using `schools'
drop _merge
replace futureyeargradespan =" 1; 2; 3; 4; 5; 6; 7; 8" if futureyeargradespan =="1; 2; 3; 4; 5; 6; 7; 8"
replace grade =" 1" if grade=="1"
replace grade =" 2" if grade =="2"
replace grade =grade+";"
replace  futureyeargradespan =futureyeargradespan+";"
gen mismatch=1 if !strpos(futureyeargradespan,grade)
preserve
keep if mismatch==1
