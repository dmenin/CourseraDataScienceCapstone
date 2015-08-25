ReadMe
===================

* Repository contents:
  * README.md: this file.
  * run_analysis.R: script to be executed to run the analysis
  * code_book.md: document with information about the data
  * tidydata.txt: output of the run_analysis function
	
* Remarks:
  * Please put the run_analysis.R and the "UCI HAR Dataset" folder on your working directory;
  * The data can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (do not rename the folder);
  * Execute the run_analysis()  function from your working directory.
    * There is extensive documentation of the run_analysis function inside it
	* Here is a brief explanation on the steps it takes:
	  * Starts by loading the train and test data
	  * loads the list of column names 
	  * Merges the training and the test sets to create one data set.
      * Renames the data based on the list of column names 
      * Extract only the measurements on the mean and standard deviation for each measurement
      * add the 3 data frames together, so it will contain, SubjectId, Activity Description and the values
      * Add the description to the Activities data frame 
	  * Uses the function melt to get a row per each combination of Subject X ActivityDescription X variable 
      * Does a dcast to calculate the mean of all variables for each Subject\ActivityDescription 
	  * Exports the data
	
  * An output file called "tidydata.txt" will be created on the working directory