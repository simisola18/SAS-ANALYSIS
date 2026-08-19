/* Adapted from P2686827-CODE.sas (lines 397-405, 447-451): the T-Test
   comparing GLH-per-learner between the two institution types (the only
   variable in the source with exactly two levels, as the author's own
   comment notes) plus one of the vbox summaries by Size, both unmodified.
   Total_data_all is rebuilt inline from 6 real rows (3 FE College, 3 Sixth
   Form College, sampled from IMAT5168-FE.csv / IMAT5168-6FORM.csv) with the
   Size band the original script derives from TotalGlh. */

data Total_data_all;
INFILE DATALINES DLM=',' MISSOVER DSD;
input institution_type : $CHAR20. region : $CHAR25. totalGLHYear1 : Best8.
      learnersYear1 : Best5. totalGLHYear2 : Best8. learnersYear2 : Best5.
      totalGLHYear3 : Best8. learnersYear3 : Best5.;
GLHHours_per_Learner_year1 = divide( totalGLHYear1, learnersYear1);
GLHHours_per_Learner_year2 = divide( totalGLHYear2, learnersYear2);
GLHHours_per_Learner_year3 = divide( totalGLHYear3, learnersYear3);
TotalGlh = sum(totalGLHYear1, totalGLHYear2, totalGLHYear3);
TotalGLHperLearner = GLHHours_per_Learner_year1 + GLHHours_per_Learner_year2 + GLHHours_per_Learner_year3;
if TotalGlh > 3000000 then Size = "Large";
if TotalGlh >= 2000000 and TotalGlh < 3000000 then Size = "Large-Medium";
if TotalGlh >= 1000000 and TotalGlh < 2000000 then Size = "Medium";
if TotalGlh >= 500000 and TotalGlh < 1000000 then Size = "small-Medium";
if TotalGlh < 500000 then Size = "Small";
datalines;
FE College,East Midlands,1299123,9919,1294331,7400,1107795,6630
FE College,East Midlands,3208343,20923,3088582,12716,2743416,11715
FE College,Greater London,3907484,17292,3716922,19167,3217344,17322
Sixth Form College,East Midlands,1003088,1375,1115427,1513,1248720,1731
Sixth Form College,East of England,772705,1722,819897,1452,900882,1564
Sixth Form College,Greater London,1700716,2097,1654886,2052,1578071,2095
;
run;

/*T-Test for Statitical Analysis of Institution type on GLHperLearner because it is the only variable that fits
into the t-test category of having not more than two levels or groups in a variable*/
ods graphics on;
proc ttest
	data = Total_data_all plots=histogram plots=box;
	class institution_type;
	var GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
run;
ods graphics off;

proc sgplot data=Total_data_all;
   vbox TotalGLHperLearner  / category=size;
   xaxis label="Coleration";
   keylegend / title="distribution of each_learner vs Size";
run;
