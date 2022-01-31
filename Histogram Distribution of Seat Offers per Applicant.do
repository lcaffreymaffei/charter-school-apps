//download and import base report from salesforce as a csv.
//mostly you will just need to use this report: https://applyphillycharter.lightning.force.com/lightning/r/Report/00O2G000006VDtBUAW/view
//if using the above report, keep in mind that it has all pre-deadline, post-deadline, and current year apps for SY 21-22,
//so if you are just looking for pre-deadline apps, only keep rows where recordtype=="Pre-Deadline"

	rename application* *
	gen numberofoffers = 1 if offerstatus =="Offer Extended"
	collapse (sum) numberofoffers ,by(applicationid )
	
//I recommend exporting this list to a csv/excel doc and using excel to generate a histogram, since excels histograms are more visually pleasing than stata's
//if you are using excel for the histogram, you can google instructions on how to do it, as it can be a little confusing.
//if you are using excel, you will have to create a column for what they call the bin.
//the bin column is just the range of numbers that should be at the bottom of the histogram,
//so you just want the range of # of offers gotten per applicant. do get that, so the below code

	sum numberofoffers
	
//then generate a column in excel called Bin the values are numbers from the minimum (from above) and the maximum (from above)
	


