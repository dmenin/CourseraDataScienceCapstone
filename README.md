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
	* 01/04/2015:
		* Added buttons to the UI to show results; 
		* Added recursion from 3 gram to 2 gram on nWords = 2; still have to add when nWords > 2;
	* 31/03/2015:		
		* Repository created