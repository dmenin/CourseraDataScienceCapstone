ReadMe
===================

* CapstoneProject:
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
		* 24/04/2015
			* Added final rpubs presentation - https://rpubs.com/dmenin/DataScienceCapstone
			* Application published to shiny apps - https://dmenin.shinyapps.io/TextPredicitonApp/
			* Adapted UI to the browser - It doesn't look good from RStudio, but it looks OK of from the browser
			* Removed the grid from the advanced options and added title to the graph
			
		* 20/04/2015
			* Changes on the UI to add background image
			* Fixed bug that was causing infinite loop on the recursion
			
		* 09/04/2015:
			* The Model Build Function was broken into two, a MainModelBuild, which calls the model build once per gram, so I don’t have the same piece of code repeated 4 times. The file paths are still hard coded on the function; won’t change it for the time being because it is only going to be called locally anyway.
		
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
		* add the python code to get twitter data to the repo

		