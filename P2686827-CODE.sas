Libname exam '/home/u60858563/ASSESSMENT';

Filename FUREDU '/home/u60858563/ASSESSMENT/IMAT5168-FE.csv';
Filename FORM '/home/u60858563/ASSESSMENT/IMAT5168-6FORM.csv';


proc import
 datafile= FUREDU dbms= CSV out= facts1 replace;
    getnames= yes ;
run;

data FUREDU_College;

INFILE FUREDU
        LRECL=500
        ENCODING="WLATIN1"
        TERMSTR=CRLF
        DLM=','
        MISSOVER
        DSD 
		FIRSTOBS=2;

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

Filename FORM '/home/u60858563/ASSESSMENT/IMAT5168-6FORM.csv';

proc import datafile= FORM dbms= CSV out= facts2 replace;
    getnames= yes ;
run;

	
data Form_College;

INFILE FORM
        LRECL=500
        ENCODING="WLATIN1"
        TERMSTR=CRLF
        DLM=','
        MISSOVER
        DSD 
		FIRSTOBS=2;

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
     region             :         $CHAR25.
     totalGLHYear1      :         Best8.
     learnersYear1      :         Best5.
     totalGLHYear2      :         Best8.
     learnersYear2      :         Best5.
     totalGLHYear3      :         Best8.
     learnersYear3      :         Best5.
     Size				:		  $CHAR20.
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

run;	
	
/* Creating GLH per learner for each year */
data Form_College1; set Form_College;
 GLHHours_per_Learner_year1 = divide( totalGLHYear1, learnersYear1); 
 GLHHours_per_Learner_year2 = divide( totalGLHYear2, learnersYear2);  
 GLHHours_per_Learner_year3 = divide( totalGLHYear3, learnersYear3);   
 TotalGlh = sum(totalGLHYear1, totalGLHYear2, totalGLHYear3);
 TotalGLHperLearner = GLHHours_per_Learner_year1 + GLHHours_per_Learner_year2 + GLHHours_per_Learner_year3; 
  
  
  if REGION = " " then DELETE;
	 
run;	

proc sort data = Form_College1;
by region;
run;

proc print data = Form_College1;
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

/*Statistical Analysis of Region on GLHperLearner for 3 consecutive years*/
proc means 
data =  Total_data_all maxdec=3 N Mean median stddev min max q1 q3;
class region;
var GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
run;

proc means data= Total_data_all n nmiss min q1 median q3 max mean stddev maxdec= 0 ;
run;

/*Graphical Analysis(Box-plot) of Region on GLHperLearner in Year 1*/
ods graphics on;
proc sgplot
	data = Total_data_all;
	*scatter x=region y=TotalGLHperLearner;
	vbox GLHHours_per_Learner_year1  /group=region;
	xaxis min=0 max=4;
	yaxis min=0;
run;
ods graphics off;

/*Graphical Analysis(Box-plot) of Region on GLHperLearner in Year 2*/
ods graphics on;
proc sgplot
	data = Total_data_all;
	*scatter x=region y=TotalGLHperLearner;
	vbox GLHHours_per_Learner_year2 / group=region;
	xaxis min=0 max=4;
	yaxis min=0;
run;

/*Graphical Analysis(Box-plot) of Region on GLHperLearner in Year 3*/
ods graphics on;
proc sgplot
	data = Total_data_all;
	*scatter x=region y=TotalGLHperLearner;
	vbox GLHHours_per_Learner_year3 / group=region;
	xaxis min=0 max=4;
	yaxis min=0;
run;
ods graphics off;

/*Statistical Analysis of Region on GLHperLearner */
proc anova
	data = Total_data_all;
	class region;
	model GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3=region;
	means region /lsd; 
run;


/*Test for Normality for effect of Region on GLHperLearner, Tests for Normality p <0.05*/
proc univariate 
	data = Total_data_all normal;
	class region;
	var totalGLHYear1 totalGLHYear2 totalGLHYear3 GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3 TotalGlh;
	qqplot / normal(mu= est sigma= est) ;
	ppplot / normal(mu= est sigma= est) ;
 	histogram / normal;
 	inset n nmiss min median max skew kurt / position= SE ;
run;
/* normality observation for the 3 years moved away from normal distribution 
as they were way less than 0.05 so it did not pass the test for normality */

/*Statistical Distribution of Institution Size on GLHperLearner*/
proc means 
data =  Total_data_all maxdec=3 N Mean median std min max;
class Size;
var GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
run;

/*Graphical Analysis(Box-plot) of Size on GLHHours_per_Learner_year1*/
ods graphics on;
proc sgplot
	data = Total_data_all;
	vbox GLHHours_per_Learner_year1 / group=Size;
	xaxis min=0 max=4;
	yaxis min=0;
run;

/*Graphical Analysis(Box-plot) of Size on GLHHours_per_Learner_year2*/
proc sgplot
	data = Total_data_all;
	vbox GLHHours_per_Learner_year2 / group=Size;
	xaxis min=0 max=4;
	yaxis min=0;
run;

/*Graphical Analysis(Box-plot) of Size on GLHHours_per_Learner_year3*/
proc sgplot
	data = Total_data_all;
	vbox GLHHours_per_Learner_year3 / group=Size;
	xaxis min=0 max=4;
	yaxis min=0;
run;
ods graphics off;

/*Test for Statitical Analysis of Size Type on GLHperLearner*/
proc anova
	data = Total_data_all;
	class Size;
	model GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3=Size;
	means Size/lsd; 
run; 


/*Test for Normality of Size Type on GLHperLearner, Tests for Normality p <0.05*/
proc univariate 
	data = Total_data_all normal;
	class Size;
	var GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
	qqplot /normal(mu=est sigma=est);
 	histogram /normal;
run;


/*Descriptive Summary Statistics of Institution type on GLHperLearner*/
proc means 
data =  Total_data_all maxdec=3 N Mean median std min max;
class institution_type;
var GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
run;

/*Graphical Analysis(Box-plot) of Institution type on GLHperLearner for the 3 years*/
ods graphics on;
proc sgplot
	data = Total_data_all;
	*scatter x=institution_type y=TotalGLHperLearner;
	vbox GLHHours_per_Learner_year1 / group=institution_type;
	xaxis min=0 max=4;
	yaxis min=0;
run;
ods graphics off;

ods graphics on;
proc sgplot
	data = Total_data_all;
	vbox GLHHours_per_Learner_year2 / group=institution_type;
	xaxis min=0 max=4;
	yaxis min=0;
run;
ods graphics off;

ods graphics on;
proc sgplot
	data = Total_data_all;
	vbox GLHHours_per_Learner_year3 / group=institution_type;
	xaxis min=0 max=4;
	yaxis min=0;
run;
ods graphics off;

/*Test for Statitical Analysis of Size Type on GLHperLearner*/
proc anova
	data = Total_data_all;
	class institution_type;
	model GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3=institution_type;
	means institution_type/lsd; 
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

/*Test for Normality for Effect of Institution type on GLHPerLearner, Tests for Normality p <0.05*/
proc univariate 
	data = Total_data_all normal;
	class institution_type;
	var GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3;
	qqplot /normal(mu=est sigma=est);
 	histogram /normal;
run;
	
/*creating a unique isentifier for the dataset*/
data Extreme_Total_data_all;
set Total_data_all ;
format ID 6.;
ID + 1;
output;
run;

ods select extremeobs;
proc univariate data= Extreme_Total_data_all nextrobs= 20;
    var 
    totalGLHYear1
    learnersYear1
    totalGLHYear2
    learnersYear2
    totalGLHYear3
    learnersYear3
    TotalGlh;
    id ID;
run;

ods select all;

/*Test for Regression Analysis of Year on GLHperLearner*/
ods graphics on;
proc reg data=Total_data_allyear;
  model GLHHours_per_Learner_year1 GLHHours_per_Learner_year2 GLHHours_per_Learner_year3 = year1 year2 year3 / p r cli clm;
  output out=man_pred p=yhat r=resid;
run;
ods graphics off;

proc sgplot data=Total_data_all;
   vbox TotalGLHperLearner  / category=size;
   xaxis label="Coleration";
   keylegend / title="distribution of each_learner vs Size";
run; 


proc sgplot data=Total_data_all;
   vbox TotalGLHperLearner  / category=Region;
   xaxis label="Coleration";
   keylegend / title="distribution of each_learner vs Region";
run; 

proc sgplot data=Total_data_all;
   vbox TotalGLHperLearner  / category=institution_type;
   xaxis label="Coleration";
   keylegend / title="distribution of per_learner vs institution_type";
run; 

proc sgplot data=transpose_Year;
   vbox TotalGLHperLearner  / category=Year;
   xaxis label="Coleration";
   keylegend / title="distribution of per_learner vs Year";
run;