SUPPLEMENTARY MATERIAL FOR "Modelling the impact of natural disasters on the spread of infection", Nature, June 2020

---------------------------------------------------------------------------------------------------------------------------------------
By MAXIMILLIAN VAN WYK DE VRIES and LEKAASHREE RAMBABU
---------------------------------------------------------------------------------------------------------------------------------------

CONTENTS:

GEOSIR MODEL - Commented MATLAB code files of the geoSIR epidimiology code that may be used to reproduce the results shown in the paper, 
	  or to extend similar studies to different regions of the globe. 

RESULTS - Raw result files from the experiments presented in the main paper. There are results from 100 runs for each of the 35 scenarios
 	  for the theoretical eruption, and 45-50 runs for each 6 Campania runs. Summary figures are provided for each theoretical eruption
	  scenario, and may be generated for the Campania scenarios using the geoSIR_plot script in CODE folder.

THEORETICAL REGION INPUT FILES - Input files used to generate each of the theoretical region results. Parralelisation greatly improves
	  computational efficiency. Note that file paths must be changed in the inputs file for succesful runs.

CAMPANIA INPUT FILES - Input files used to generate each of the Campania results. Note that they are configured to seed the random number
	  generator (Mercenne Twister) with the system clock. Use caution with parralel runs, as they may come out identical if started at
	  the same system time. Note that file paths must be changed in the inputs file for succesful runs.

FURTHER DATA - Other relevant data, such as population density maps and hazard zones.


GEOSIR USER GUIDE - Text, pdf and word document of the geoSIR user guide to assist users in
	  initial model setup.


---------------------------------------------------------------------------------------------------------------------------------------
Questions about the contents, or querries for additional files may be addressed to the corresponding author at: vanwy048@umn.edu


