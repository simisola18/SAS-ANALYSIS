/* Adapted from P2686827-CODE.sas (lines 196-235): the transpose-by-year step
   and the custom PROC FCMP log-transform function. Total_data_all here is
   rebuilt inline from a small real sample (merged FE + Sixth-Form rows,
   size-banded and missing-filled) instead of via the full upstream import
   chain, so this bundle stands alone; PROC TRANSPOSE, PROC FCMP and the
   glhyeartrfm() calls are unmodified. */

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
FE College,East Midlands,3208343,20923,3088582,12716,2743416,11715
FE College,East of England,2242458,13880,2170141,12976,2056575,13384
Sixth Form College,East Midlands,1003088,1375,1115427,1513,1248720,1731
Sixth Form College,Greater London,1027776,1514,1020719,1485,856334,1299
;
run;

/* Transposing the year variable to a category*/
Proc transpose data=Total_data_all
			   out = transpose_Year(drop=TotalGlh2)
			   name=Year
			   Prefix = TotalGlh;
			   Var  GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
			   by TotalGLHperLearner institution_type notsorted;
run;

proc print data=transpose_Year;
run;

/* Logarithmic Transformation of year variable*/
options cmplib=(work.project);
proc fcmp outlib=work.project.lib;
    function glhyeartrfm(x);  /* */
		return (log(x));
	endsub;
	run;

data Total_data_allyear;
set Total_data_all;
year1 = glhyeartrfm(totalGLHYear1);
year2 = glhyeartrfm(totalGLHYear2);
year3 = glhyeartrfm(totalGLHYear3);
label year1 = 'Year 1 Trf Value';
label year2 = 'Year 2 Trf Value';
label year3 = 'Year 3 Trf Value';
run;

proc print data = Total_data_allyear label;
run;
