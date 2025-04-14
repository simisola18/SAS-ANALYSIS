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

