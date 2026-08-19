/* Adapted from P2686827-CODE.sas (lines 237-285): the region-level
   descriptive statistics (PROC MEANS by class region) and the one-way ANOVA
   testing region's effect on GLH-per-learner, unmodified. Total_data_all is
   rebuilt inline from 12 real FE-college rows (4 each from East Midlands,
   East of England and Greater London, sampled from IMAT5168-FE.csv) so
   the ANOVA has enough observations per group to run. */

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
datalines;
FE College,East Midlands,1299123,9919,1294331,7400,1107795,6630
FE College,East Midlands,1593307,14459,2701354,16526,2543711,14930
FE College,East Midlands,3208343,20923,3088582,12716,2743416,11715
FE College,East Midlands,2615180,36433,3132412,30146,3027782,28989
FE College,East of England,2797131,23682,2510258,13905,2196053,11859
FE College,East of England,2612863,15868,2538786,13768,2407796,14721
FE College,East of England,1008615,5253,958223,3770,789400,2874
FE College,East of England,2892087,16785,2997842,14227,2666668,11531
FE College,Greater London,2030222,11639,2133239,10316,2099001,10097
FE College,Greater London,3907484,17292,3716922,19167,3217344,17322
FE College,Greater London,1047779,5171,1029503,5120,820710,4165
FE College,Greater London,1534064,8887,1581113,6567,1366716,5664
;
run;

/*Statistical Analysis of Region on GLHperLearner for 3 consecutive years*/
proc means
data =  Total_data_all maxdec=3 N Mean median stddev min max q1 q3;
class region;
var GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
run;

proc means data= Total_data_all n nmiss min q1 median q3 max mean stddev maxdec= 0 ;
run;

/*Statistical Analysis of Region on GLHperLearner */
proc anova
	data = Total_data_all;
	class region;
	model GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3=region;
	means region /lsd;
run;
