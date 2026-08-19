/* Adapted from P2686827-CODE.sas (lines 1-83): the FE-college data preparation
   stage. Original read via LIBNAME/FILENAME pointing at
   /home/u60858563/ASSESSMENT/IMAT5168-FE.csv on SAS Studio; here the same
   fixed-format INPUT/LENGTH/LABEL block reads a bundled sample of real rows
   from IMAT5168-FE.csv via inline DATALINES instead. GLH-per-learner
   calculation, sort, and print are unmodified. */

data FUREDU_College;

INFILE DATALINES
        DLM=','
        MISSOVER
        DSD ;

     LENGTH
     institution_type            $20
     region                      $25
     totalGLHYear1                8
     learnersYear1                5
     totalGLHYear2                8
     learnersYear2                5
     totalGLHYear3                8
     learnersYear3                5
     Size						$20
;
 INPUT
     institution_type   :         $CHAR20.
     region             :        $CHAR25.
     totalGLHYear1      :          Best8.
     learnersYear1      :         Best5.
     totalGLHYear2      :          Best8.
     learnersYear2      :          Best5.
     totalGLHYear3      :         Best8.
     learnersYear3      :         Best5.
     Size				:			$CHAR20.
     ;

Label
		institution_type   = 'Institution Type'
                region    = 'Region'
                totalGLHYear1 = ' Total Guided Learning Hours Year 1'
		learnersYear1 = ' No of learners in Year 1'
		totalGLHYear2 = ' Total Guided Learning Hours Year 2'
		learnersYear2 = ' No of learners in Year 2'
		totalGLHYear3 = ' Total Guided Learning Hours Year 3'
		learnersYear3 = ' No of learners in Year 3'
		GLHHours_per_Learner_year1 = ' Total Guided Learning Hours Year 1/Learner Year 1'
		GLHHours_per_Learner_year2 = ' Total Guided Learning Hours Year 2/Learner Year 2'
		GLHHours_per_Learner_year3 = ' Total Guided Learning Hours Year 3/Learner Year 3'
		TotalGlh  = ' Total Guided Learning Hours'
		TotalGLHperLearner  = ' Total Guided Learning Hours/Learner'
		Size     = 'Size of Institution'
		;

datalines;
FE College,East Midlands,1299123,9919,1294331,7400,1107795,6630
FE College,East Midlands,1593307,14459,2701354,16526,2543711,14930
FE College,East Midlands,3208343,20923,3088582,12716,2743416,11715
FE College,East Midlands,2615180,36433,3132412,30146,3027782,28989
FE College,East Midlands,1015354,7449,933109,5445,890615,5214
FE College,East Midlands,3713574,27503,3625550,23288,3246155,22447
FE College,East Midlands,2258863,10548,2226036,9825,2648944,13113
FE College,East Midlands,1731174,10303,1841059,9827,1977806,9863
FE College,East Midlands,1006989,4042,1013632,3584,1010010,3725
FE College,East Midlands,4402042,20514,4243906,17834,3739237,17359
FE College,East Midlands,553505,5748,527416,3519,,
FE College,East Midlands,983090,8392,1007053,7541,884089,6781
FE College,East Midlands,3131609,15034,3041629,12935,2833867,11827
FE College,East Midlands,1162894,12638,1212173,7834,1008295,5465
FE College,East Midlands,752800,5880,853424,4321,782766,4081
;
run;

/* Creating GLH per learner for each year */
data FUREDUColleges; set FUREDU_College;
 GLHHours_per_Learner_year1 = divide( totalGLHYear1, learnersYear1);
 GLHHours_per_Learner_year2 = divide( totalGLHYear2, learnersYear2);
 GLHHours_per_Learner_year3 = divide( totalGLHYear3, learnersYear3);
 TotalGlh = sum(totalGLHYear1, totalGLHYear2, totalGLHYear3);
 TotalGLHperLearner = GLHHours_per_Learner_year1 + GLHHours_per_Learner_year2 + GLHHours_per_Learner_year3;


  if REGION = " " then DELETE;

run;

proc sort data = FUREDUColleges;
by region;
run;

proc print data = FUREDUColleges;
run;
