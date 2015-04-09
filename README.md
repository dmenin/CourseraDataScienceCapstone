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
	* 08/04/2015:
		* added 4 grams where frequency > 1 (otherwise model becomes too big)
		* add % frequency on the graph
		* fixed the graph size, increase labels  - improved overall layout
		* dealt with NAs on the predictions. If nothing is found on the n-grams, default to unigram
		* added "advanced" checkbox to control whether graps\grid are displayed.
		
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
	* maps "." to end on the model build (?)
	* (doParalel on the model build)
	* add the python code to get twitter data to the repo
	
	