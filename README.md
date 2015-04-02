ReadMe
===================

* Repository contents:
  * 0SampleModelData folder contains a small (5k rows) twitter file (not viable to store the full file on git)
  * 1BuildModel: code to build the models.
	* Input: text files
	* Output: ngrams on .RDS files  
  * aux_code: not part of the project - nothing useful at the moment	
  * images: just a few images from NPL MOOCs
  * MilestoneReport: Milestone report 1
  * TextPredictionApp: Shiny app (magic happens here)
	* Input: ngrams created with 1BuildModel
	

* Updates:	
	* 02/04/2015:
		* Added recursion when nWord>1; 
		* Added v1 of the graph
		* suggestWord returns 10 suggestions (because of the graph); buttons should be used to see top 3 predictions
		
	* 01/04/2015:
		* Added buttons to the UI to show results; 
		* Added recursion from 3 gram to 2 gram on nWords = 2; still have to add when nWords > 2;
	* 31/03/2015:		
		* Repository created
		
* TO DO:
	* 4 grams
	* add % frequency
	* maps "." to end on the model build
	* deal with NAs on the predictions
	* (doParalel on the model build)
	* add the python code to get twitter data to the repo
	* fix graph size, increase labels  - improve overall layout
	* add "advanced" checkbox to control whether graps\grid are displayed
	
	