# Keeling-WRF-Tutorial

This tutorial walks through how to download, set up, and run the Weather Research and Forecasting Model (WRF) on Keeling from your university laptop. All information is current as of Summer 2022. Certain aspects of the set-up process may change slightly in the future as WRF is updated beyond version 4.4.

Large portions of this tutorial are adapted from the UCAR WRF online tutorial, available here: https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php

Additional information provided by Seth Goodnight (jamessg3@illinois.edu)
Batch script provided by Steve Nesbitt (snesbitt@illinois.edu)
Tutorial compiled by Eddie Wolff (ecwolff3@illinois.edu)

## Downloading WRF and WPS (and required libraries)

•	Register as a new WRF user
o	Go to: https://www2.mmm.ucar.edu/wrf/users/download/wrf-regist.php 
o	Fill out and submit the form
•	Connect to Keeling
o	On Mac
	Open a terminal
	Type ssh [your NetID]@keeling.earth.illinois.edu
	Type your university password and press enter
o	On Windows
	…
o	Note: If you are not connected to campus Wi-Fi, you’ll need to log in and start the Cisco AnyConnect VPN before connecting to Keeling
•	Navigate to where you’d like to build WRF
o	The b drive of your advisor’s server is a good location
o	for example: data/[your advisor]/b/[your NetID]
•	Create a directory called WRF4_4 (type: mkdir WRF4_4)
•	Next, we’ll download both WRF and WPS
o	WPS is the WRF Preprocessing System and is necessary for converting our input files into the format required by WRF
