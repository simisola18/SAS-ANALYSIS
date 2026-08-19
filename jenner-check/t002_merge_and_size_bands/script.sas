/* Adapted from P2686827-CODE.sas (lines 166-202): stacking the FE and
   Sixth-Form datasets with SET, deriving the institution "Size" band from
   TotalGlh, running PROC CONTENTS, and replacing missing numerics with 0 via
   PROC STDIZE (reponly missing=0) exactly as the original does. The two
   input datasets here are the same small real-row samples used in
   t001/t003-t007, built inline instead of via LIBNAME/FILENAME. */

data FUREDUColleges;
INFILE DATALINES DLM=',' MISSOVER DSD;
input institution_type : $CHAR20. region : $CHAR25. totalGLHYear1 : Best8.
      learnersYear1 : Best5. totalGLHYear2 : Best8. learnersYear2 : Best5.
      totalGLHYear3 : Best8. learnersYear3 : Best5.;
GLHHours_per_Learner_year1 = divide( totalGLHYear1, learnersYear1);
GLHHours_per_Learner_year2 = divide( totalGLHYear2, learnersYear2);
GLHHours_per_Learner_year3 = divide( totalGLHYear3, learnersYear3);
TotalGlh = sum(totalGLHYear1, totalGLHYear2, totalGLHYear3);
TotalGLHperLearner = GLHHours_per_Learner_year1 + GLHHours_per_Learner_year2 + GLHHours_per_Learner_year3;
if REGION = " " then DELETE;
datalines;
FE College,East Midlands,1299123,9919,1294331,7400,1107795,6630
FE College,East Midlands,3208343,20923,3088582,12716,2743416,11715
FE College,East Midlands,4402042,20514,4243906,17834,3739237,17359
FE College,East Midlands,553505,5748,527416,3519,,
FE College,East of England,2242458,13880,2170141,12976,2056575,13384
;
run;

data Form_College1;
INFILE DATALINES DLM=',' MISSOVER DSD;
input institution_type : $CHAR20. region : $CHAR25. totalGLHYear1 : Best8.
      learnersYear1 : Best5. totalGLHYear2 : Best8. learnersYear2 : Best5.
      totalGLHYear3 : Best8. learnersYear3 : Best5.;
GLHHours_per_Learner_year1 = divide( totalGLHYear1, learnersYear1);
GLHHours_per_Learner_year2 = divide( totalGLHYear2, learnersYear2);
GLHHours_per_Learner_year3 = divide( totalGLHYear3, learnersYear3);
TotalGlh = sum(totalGLHYear1, totalGLHYear2, totalGLHYear3);
TotalGLHperLearner = GLHHours_per_Learner_year1 + GLHHours_per_Learner_year2 + GLHHours_per_Learner_year3;
if REGION = " " then DELETE;
datalines;
Sixth Form College,East Midlands,1003088,1375,1115427,1513,1248720,1731
Sixth Form College,East of England,772705,1722,819897,1452,900882,1564
Sixth Form College,Greater London,1027776,1514,1020719,1485,856334,1299
Sixth Form College,Greater London,1700716,2097,1654886,2052,1578071,2095
;
run;

/* Joining the datasets for both colleges */
data Total_data;
 set FUREDUColleges
 	 Form_College1;
run;

/*Tabular view of all the data imported and variable details*/
proc contents DATA=Total_data;
run;

/*creating range categories for the size of an institution*/
data Total_data; set Total_data;

   	 If TotalGlh > 3000000 then Size = "Large";
   	 if TotalGlh >= 2000000 and TotalGlh < 3000000 then Size = "Large-Medium";
	 if TotalGlh >= 1000000 and TotalGlh < 2000000 then Size = "Medium";
	 if TotalGlh >= 500000 and TotalGlh < 1000000 then Size = "small-Medium";
	 if TotalGlh < 500000 then Size = "Small";

run;

proc print data=Total_data;
run;

/*replacing missing values in the data with 0*/
proc stdize data=Total_data out=no_missing_Total_data reponly missing=0;
run;

data Total_data_all;
	set work.no_missing_Total_data;
run;

proc print data=Total_data_all;
run;
