import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\All MCS Apps 1.9.20.csv", bindquote(strict) varnames(1)
keep studentnumber firstname lastname grade school stu_catchmentname stu_outsidecatchment stu_differentaddressfamily stu_addressstreet stu_apt stu_city stu_state stu_zip stu_zipcodepreference
rename * *_ps
rename studentnumber_ps applicationid
rename school_ps applicationschool
replace applicationschool = "Mastery Charter School: Pastorius-Richardson Elementary" if applicationschool== "Mastery Charter School: Francis D. Pastorius"
tempfile ps
save `ps'
clear

import delimited "C:\Users\Lucy Caffrey Maffei\Downloads\report1578601473571.csv", bindquote(strict) varnames(1)
rename applicationapplicationid applicationid
tempfile apc
save `apc'
clear

use `ps'
merge 1:1 applicationid applicationschool using `apc'
preserve
keep if _merge ==1
drop submitteddate-_merge
export delimited using "C:\Users\Lucy Caffrey Maffei\Documents\Mastery Apps - In PS but not APC.csv", replace
restore
preserve
keep if _merge ==3
gen grade_mismatch = 1 if grade_ps!= applicationgradestudentisapplyin
gen catchmentname_mismatch = 1 if stu_catchmentname_ps != applicationcatchmentname
gen outofcatchment_mismatch =1 if stu_outsidecatchment_ps != outofcatchment
gen difffamilyaddress_mismatch = 1 if stu_differentaddressfamily_ps != applicationhasdifferentparentadd
gen studentaddress_mismatch = 1 if stu_addressstreet_ps != applicationstreetstreetname
gen studentapt_mismatch = 1 if stu_apt_ps  != applicationapartment
gen studentcity_mismatch = 1 if stu_city_ps  != applicationcity
gen studentstate_mismatch = 1 if stu_state_ps != applicationstate
gen studentzip_mismatch = 1 if stu_zip_ps != applicationzipcode
gen studentzippreference_mismatch = 1 if haszipcodepreference != stu_zipcodepreference_ps
keep applicationid firstname_ps lastname_ps grade_ps applicationschool stu_outsidecatchment_ps stu_catchmentname_ps stu_differentaddressfamily_ps stu_addressstreet_ps stu_apt_ps stu_city_ps stu_state_ps stu_zip_ps stu_zipcodepreference_ps applicationgradestudentisapplyin outofcatchment applicationcatchmentname applicationhasdifferentparentadd applicationstreetstreetname applicationapartment applicationcity applicationstate applicationzipcode haszipcodepreference grade_mismatch catchmentname_mismatch outofcatchment_mismatch difffamilyaddress_mismatch studentaddress_mismatch studentapt_mismatch studentcity_mismatch studentstate_mismatch studentzip_mismatch studentzippreference_mismatch
rename applicationgradestudentisapplyin grade_apc
rename applicationstreetstreetname address_apc
rename applicationapartment apt_apc
rename applicationcity city_apc
rename applicationstate state_apc
rename applicationzipcode zip_apc
rename haszipcodepreference zippreference_apc
rename outofcatchment outofcatchment_apc
rename applicationcatchmentname catchmentname_apc
rename applicationhasdifferentparentadd differentparentaddress_apc
export delimited using "C:\Users\Lucy Caffrey Maffei\Documents\Mastery Apps - Updating PS records.csv", replace
