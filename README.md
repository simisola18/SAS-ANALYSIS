# SAS-ANALYSIS
REPORT ON GUIDED LEARNING HOURS IN FURTHER EDUCATION AND SIXTH FORM COLLEGES
# SUMMARY OF THE REPORT
This report aims at analyzing guided learning hours in further education and sixth form colleges. The effect of region, institution type, institution size, and year on guided learning hours per learner was analyzed. The data preparation, import, and cleansing to the exploratory analysis was done using some statistical means. The results from this analysis show that the size of the institution, the type, the region institution is in and the year also affects the learning hours per learner in an institution.

# METHODS
SAS studio was used for the analysis of this report. The data used in this report is a comma-delimited file (CSV) which was uploaded into a folder on SAS studio. The data consists of the two files below:
	IMAT5168-6FORM.csv - containing data about guided learning hours for UK 6th form colleges
	IMAT5168-FE.csv - containing data about guided learning hours for UK further education colleges.

# DATA IMPORT
The data was uploaded into a New SAS program with a library name and file name created for both files. Some of the Codes used are explained below.
 ![image](https://github.com/user-attachments/assets/7d7409f4-d5bf-43e7-84a3-0c7a4df7e130)

“Proc import” was used to import the data into the SAS program. “Proc import” is an import procedure that reads data from an external data source and writes it to a SAS data set. Base SAS can import delimited files such as the comma-delimited file used in this analysis. Proc import reads the input file and writes the data to a SAS data set when it is run. The SAS variable definitions are based on the input records. When PROC IMPORT reads a delimited file, it generates a DATA step code to import the data to the SAS log. The files are then named using Data which provides names for any output SAS data sets.
The procedure "Proc Print" is used to print the observations in the data set using some or all variables. The set statement is used also to join the two files together which then creates a new dataset from an existing dataset. “Proc Contents” provides a summary of the dataset characteristics, including the number of observations and variables, and the attributes of the variables, such as variable name, data type, data length, etc.
“Proc stdize” this procedure standardizes one or more numeric variables in a SAS data set. In this data analysis, it was used to replace missing data with the location measure (it does not standardize the data). There are some missing values in the dataset being worked on and this was used to remove them.
“Proc transpose” is used to create an output data set by restructuring the values in a SAS data set, transposing selected variables into observations.

# EXPLORATORY ANALYSIS
In the exploratory analysis of this work, Proc means and Proc Univariate was used, also some exploration of data with tables and graphs was used.
“Proc means” is used to show some descriptive statistics, estimate the quartiles of the data, calculate the mean, median, percentiles and ranges, sum, standard deviation etc.
“Proc Univariate” also provides some descriptive statistics based on moments (including skewness and kurtosis), quantiles or percentiles (such as the median), frequency tables, and extreme values etc.

# STATISTICAL MODEL
While statistical analysis is different from test to test, there are some assumptions that are common across all tests. There are few models that can be used to analyze the data. Proc sgplot, Proc Anova, Proc ttest , Proc univariate and Proc reg are a few I used in this analysis.
“Proc Univariate” is used with ods tests for normality in the variety of distributions. Plots are created using quantile-quantile (Q-Q plots) and probability-probability (P-P plots). Plots like these make it easier to compare data distributions with theoretical distributions. Besides producing summary statistics, it also generates histogram intervals and parameters of fitted curves in the outputs.
“Proc sgplot” helps creates one or more plots and overlays them on a single set of axes. The minimum, maximum, 25th percentile, 75th percentile, Mean, Median, Outliers, etc. can all be seen on this plot.
“Proc Anova” is used for the analysis of balanced data only, it was used for the statistical analysis of size, institution type, region, etc. against GLHperlearner.
“Prog reg” is used to perform basic regression analysis.

# RESULTS
After the data was imported into SAS using the code below, the result of the import showed 8 Variables, 263 observations in the FE college dataset, and 8 Variables,110 observations in the Sixth form college dataset.
![image](https://github.com/user-attachments/assets/80ee7c72-4473-46c9-b0f0-37caf308904a)
![image](https://github.com/user-attachments/assets/fe95478d-caf6-4bc6-950c-e0084d863330)
![image](https://github.com/user-attachments/assets/65bdaabd-db89-4fe3-b127-a76c4676ef41)
![image](https://github.com/user-attachments/assets/235dc89e-22f2-43aa-b086-b9e944800e72)
The data variables were inputted and with their labels also as this can be seen in the code. GLH per learner for both FE and 6th form colleges was created as instructed in the data analysis, code for creation.
![image](https://github.com/user-attachments/assets/c666c4b0-a020-418e-bb31-de37a5521fd1)
FE college and 6th form college were merged using the SET statement and the result of the merger as seen in the proc content table below is that the dataset has 14 variables with 354 observations
![image](https://github.com/user-attachments/assets/5abd2487-47bf-4b54-bea4-21e0ea2e715c)
![image](https://github.com/user-attachments/assets/479e3c6d-9f33-4a53-9a60-e1958392f308)

The results of the added categories to get the size of an institution for a better analysis of the data is seen below.
![image](https://github.com/user-attachments/assets/d3fe9b8d-4527-4726-83ed-9cbacfd5abc8)
![image](https://github.com/user-attachments/assets/9a56c628-a132-402d-aa25-bd51c05edfab)
The code below was used to remove missing values in the data set as a method of cleaning the data
![image](https://github.com/user-attachments/assets/2c49b230-11e2-4749-bde2-2c6c386eb53d)

# EXPLORATORY ANALYSIS RESULTS
The purpose of exploratory analysis is to use summary statistics and graphic representations to perform preliminary investigations on data in order to identify patterns, detect anomalies, test hypotheses, and verify assumptions.
From the Proc means analysis it was deducted that the Northwest region has the highest number of observations in the data and the highest number of learning hours in the data with 937.3hours in year 3. The region Northeast has the lowest number of observations with 21 observations and Yorkshire and the Humber has the lowest number of guided learning hours per learner at 60.6 hours. A lot more details can be seen on the box plot representation of the data
![image](https://github.com/user-attachments/assets/485ef5f4-d645-4acf-a645-09494f6e3573)
The choice of the different statistical models used was to give a clearer view and understanding of the data, to also identify the various relationships between the variables and make useful predictions from the data. Proc sgplot, Proc Anova, Proc ttest, Proc univariate and Proc reg are some of the statistical models used. The assumptions for each model differ but there are some assumptions that are distinct in all models.
The Proc Anova test: the analysis was done using a one-way anova analysis format which has the class and model statements. From the test results based on the region, it can be seen that for GLHHours_per_Learner_year1 has a P-value of 0.0525 hence we would accept the null hypothesis and conclude that the learning hours per learner were the same for the year1 students since P is >0.05. While that of GLHHours_per_Learner_year1 and year 2 were 0.2603 and 0.3178 respectively which is less than <0.05 hence we would reject our null hypothesis and conclude that there is a statistically significant difference in learning hours per learner in those years.
![image](https://github.com/user-attachments/assets/616c0ab2-3719-4d3a-a947-343f3e318ceb)
![image](https://github.com/user-attachments/assets/2328eb85-9454-43e0-bf01-e97a57ac3f6b)
![image](https://github.com/user-attachments/assets/6fbbc1ba-6744-40b3-a69b-24cf09cfbafe)
![image](https://github.com/user-attachments/assets/82e51b60-6def-49b9-8131-203a7cb9d3eb)
Using the Proc univariate, test for normality and skewness was examined, skewness for the learners for the 3 years was positively skewed and the normality observation for the 3 years moved away from normal distribution as they were way less than 0.05 so it did not pass the test for normality.
![image](https://github.com/user-attachments/assets/05b13b7f-d830-4c69-91a9-cda5bd78c7d3)
![image](https://github.com/user-attachments/assets/585e2d12-c534-47c1-8f81-c9466c463775)
![image](https://github.com/user-attachments/assets/cd1999f6-caa8-42bf-9f4f-939c728cb4f5)
The Proc Ttest could only be run on the Institution type variable as this is the only variable that is within the two groups or levels size for Ttest. It compares the means of the groups in the variable. According to the test results, the variances between the three years are unequal, and the Satterthwaite method confirms unequal means between the Guilded learning hours per student in the FE college and Sixth Form College for all three years. The PVALUE is <.0001 which is less than the normal range of 5% (0.005) so we accept that the groups are entirely different hence we reject the null hypothesis that says the means are the same.
![image](https://github.com/user-attachments/assets/a810b9d6-ad4e-4199-9c26-1f5611c9fc21)
![image](https://github.com/user-attachments/assets/e8b53111-6874-426f-9a14-b7442f5ec852)
![image](https://github.com/user-attachments/assets/03f3b6d2-eefb-432f-971b-32002bdb5578)
For the regression analysis, It was observed that the p-value was <.0001 which is less than 0.05 As a result, the alternative hypothesis is accepted that the groups differ significantly. This means the institution size had a significant effect on the guided learning hours per learner in the 3 years under review as the more students they have the more guided learning hours had.
![image](https://github.com/user-attachments/assets/968a4c95-7fcb-4372-ae39-0252c165474b)
![image](https://github.com/user-attachments/assets/b2e8f58d-4c57-46b8-99d6-79ba3f5dddab)
![image](https://github.com/user-attachments/assets/d556628d-4c52-4f7a-b157-22d85b2ef295)







