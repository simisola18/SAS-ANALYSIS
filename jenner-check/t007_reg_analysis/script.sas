/* Adapted from P2686827-CODE.sas (lines 216-232, 439-445): the log-transform
   step (PROC FCMP glhyeartrfm) followed by the PROC REG regression of
   GLH-per-learner on the log-transformed year totals, unmodified. Total_data
   is rebuilt inline from 8 real FE-college rows (IMAT5168-FE.csv) so the
   regression has enough observations for its p/r/cli/clm output options. */

data Total_data;
INFILE DATALINES DLM=',' MISSOVER DSD;
input institution_type : $CHAR20. region : $CHAR25. totalGLHYear1 : Best8.
      learnersYear1 : Best5. totalGLHYear2 : Best8. learnersYear2 : Best5.
      totalGLHYear3 : Best8. learnersYear3 : Best5.;
GLHHours_per_Learner_year1 = divide( totalGLHYear1, learnersYear1);
GLHHours_per_Learner_year2 = divide( totalGLHYear2, learnersYear2);
GLHHours_per_Learner_year3 = divide( totalGLHYear3, learnersYear3);
datalines;
FE College,East Midlands,1299123,9919,1294331,7400,1107795,6630
FE College,East Midlands,1593307,14459,2701354,16526,2543711,14930
FE College,East Midlands,3208343,20923,3088582,12716,2743416,11715
FE College,East Midlands,2615180,36433,3132412,30146,3027782,28989
FE College,East of England,2797131,23682,2510258,13905,2196053,11859
FE College,East of England,2612863,15868,2538786,13768,2407796,14721
FE College,East of England,1008615,5253,958223,3770,789400,2874
FE College,East of England,2892087,16785,2997842,14227,2666668,11531
;
run;

/* Logarithmic Transformation of year variable*/
options cmplib=(work.project);
proc fcmp outlib=work.project.lib;
    function glhyeartrfm(x);  /* */
		return (log(x));
	endsub;
	run;

data Total_data_allyear;
set Total_data;
year1 = glhyeartrfm(totalGLHYear1);
year2 = glhyeartrfm(totalGLHYear2);
year3 = glhyeartrfm(totalGLHYear3);
label year1 = 'Year 1 Trf Value';
label year2 = 'Year 2 Trf Value';
label year3 = 'Year 3 Trf Value';
run;

/*Test for Regression Analysis of Year on GLHperLearner*/
ods graphics on;
proc reg data=Total_data_allyear;
  model GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3 = year1 year2 year3 / p r cli clm;
  output out=man_pred p=yhat r=resid;
run;
ods graphics off;
