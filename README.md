# Keeling-WRF-Tutorial

This tutorial walks through how to download, set up, and run the Weather Research and Forecasting Model (WRF) on Keeling from your university laptop. All information is current as of Summer 2022. Certain aspects of the set-up process may change slightly in the future as WRF is updated beyond version 4.4.

Large portions of this tutorial are adapted from the UCAR WRF online tutorial, available here: https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php

Additional information provided by Seth Goodnight (jamessg3@illinois.edu)

Batch script provided by Steve Nesbitt (snesbitt@illinois.edu)

Tutorial compiled by Eddie Wolff (ecwolff3@illinois.edu)

## Contents
- [Installing WRF and WPS (and required libraries)](https://github.com/EWolffWX/Keeling-WRF-Tutorial/blob/main/README.md#installing-wrf-and-wps-and-required-libraries)
- [Configure and Compile WRF](https://github.com/EWolffWX/Keeling-WRF-Tutorial/blob/main/README.md#configure-and-compile-wrf)
- [Configure and Compile WPS](https://github.com/EWolffWX/Keeling-WRF-Tutorial/blob/main/README.md#configure-and-compile-wps)
- [Getting Data](https://github.com/EWolffWX/Keeling-WRF-Tutorial/blob/main/README.md#getting-data)
- [Run WPS](https://github.com/EWolffWX/Keeling-WRF-Tutorial/blob/main/README.md#run-wps)
- [Run WRF](https://github.com/EWolffWX/Keeling-WRF-Tutorial/blob/main/README.md#running-wrf)

## Installing WRF and WPS (and required libraries)

### Register as a new WRF user
  - Go to: https://www2.mmm.ucar.edu/wrf/users/download/wrf-regist.php 
  - Fill out and submit the form
### Connect to Keeling
  - On Mac
    - Open a terminal
    - Type ssh [your NetID]@keeling.earth.illinois.edu
    - Type your university password and press enter
  - On Windows
    - ...
  - Note: If you are not connected to campus Wi-Fi, you’ll need to log in and start the Cisco AnyConnect VPN before connecting to Keeling
### Downloading WRF and WPS
- Navigate to where you’d like to build WRF
  - The b drive of your advisor’s server is a good location
  - for example: `data/[your advisor]/b/[your NetID]`
- Create a directory called WRF4_4 (type: `mkdir WRF4_4`)
- Next, we’ll download both WRF and WPS
  - WPS is the WRF Preprocessing System and is necessary for converting our input files into the format required by WRF
- Within this directory, type:
  - `git clone –recurse-submodules http://github.com/wrf-model/WRF`
  - `git clone http://github.com/wrf-model/WPS`
- **It’s important to download this way and not from the WRF site which hasn’t been updated since 2018 and only goes up to version 4.0, not 4.4**
- Within the folder containing WRF and WPS, make a directory called *Build_WRF* and a directory within this called *LIBRARIES*
### Downloading Additional Libraries
- Go to: http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php#STEP2
- Copy the link for each of the following files (right click and select copy link):
  - mpich, Jasper, libpng, and zlib
  - netcdf functionality is already included on Keeling, so this library is not required
- On Keeling run the following command (in the LIBRARIES directory) for each file address you copy
  - `wget [copied link]`
- Copy over the file titled makekeelingloads.csh from `data/jtrapp/b/ecwolff3/Public_WRF`
  - Navigate to this directory and type: `cp makekeelingloads.csh data/[path to your WRF_4 directory`
- Move back to your WRF_4 directory
- Now we need to make one minor edit to *your* copy of this file. To do so, we’ll open it with vi
- Type: `vi makekeelingloads.csh`
- Change the path within the file to your directory where WRF is located 
  - for example: `data/jtrapp/b/ecwolff3/WRF4_4/Build_WRF/LIBRARIES`
  - yours may look like: 
     - `data/[your advisor]/b/[your NetID]/WRF4_4/Build_WRF/LIBRARIES`
  - Remember, to edit in vi, you first need to press i
- Now exit vi (press *escape* then type `:wq` to save and quit)
- Type: `source makekeelingloads.csh`


Next we’ll unpack and install each of the packages we downloaded into our LIBRARIES folder. Copy and run each of the lines of code below:

**MPICH**

- `tar xzvf mpich-3.0.4.tar.gz` (or just .tar if no .gz present)
- `cd mpich-3.0.4`
- `./configure --prefix=$DIR/mpich`
- `make`
- `make install`
- `export PATH=$DIR/mpich/bin:$PATH`
- `cd ..`

**zlib**

- `tar xzvf zlib-1.2.7.tar.gz (or just .tar if no .gz present)`
- `cd zlib-1.2.7`
- `./configure --prefix=$DIR/grib2`
- `make`
- `make install`
- `cd ..`

**libpng**

- `tar xzvf libpng-1.2.50.tar.gz` (or just .tar if no .gz present)
- `cd libpng-1.2.50`
- `./configure --prefix=$DIR/grib2`
- `make`
- `make install`
- `cd ..`

**Jasper**

- `tar xzvf jasper-1.900.1.tar.gz` (or just .tar if no .gz present)
- `cd jasper-1.900.1`
- `./configure --prefix=$DIR/grib2`
- `make`
- `make install`
- `cd ..`

## Configure and Compile WRF
- Go to your WRF folder (to access from LIBRARIES, type: `cd ../../WRF`)
- First, clean out any old files. There shouldn’t be any since this is our first simulation, but it’s always good practice. In the future, make sure you have copied over any files you want to save from previous runs to a different directory before cleaning WRF (for example: output files, namelist.input, etc.)
  - `./clean -a`
- Now configure WRF
  - `./configure`
    - For the first option, type 15
    - For the second option, type 1
- And begin the process of compiling WRF
  - `./compile em_real >& log.compile`
    - NOTE: this step will likely take around 40 minutes to complete, leave your computer on and connected to Keeling during this time
    - If this step fails to create executable files in your WRF folder (such as wrf.exe) there may be an issue with the libraries. You’ll need to go back to troubleshoot then re-compile WRF before continuing
    - It’s very common to run into issues at this step, don’t be discouraged!
    - If you need help troubleshooting, see Appendix I and/or reach out to other students who use WRF for their research
    - ...
***NOTE: Anything before this point only needs to be completed one time, when you set up WRF. For future simulations, simply start at the next step.***

## Configure and Compile WPS
- Move to the WPS folder (from the WRF folder, you can type: `cd ../WPS`)
- Just as with WRF, we should start by cleaning WPS (in the future, be sure to copy and move any files you want to save first)
  - `./clean -a`
- Now we can configure WPS
  - `./configure`
    - Select option 17 when prompted
- And compile WPS
  - `./compile >& log.compile`
- Now we need to give WPS information about our run and the data we’ll be using
- Let’s open our namelist and make some edits
  - Type: `vi namelist.wps`
- The following suggestions for editing your namelist are adapted from this UCAR site: https://www2.mmm.ucar.edu/wrf/users/namelist_best_prac_wps.html 
- ...

## Getting Data
- First, navigate to your WRF4_4 folder (from the WPS folder type: `cd ..`)
- Make a new directory titled DATA (type: `mkdir DATA`)

To download and use NAM or GFS data follow this section (*For information on how to run WRF with HRRR input files, see Appendix II*)
- For NAM data, follow this link: https://rda.ucar.edu/datasets/ds609.0/#!access 
- For GFS data, follow this link: https://rda.ucar.edu/datasets/ds084.6/#!access 
- In order to download data, you’ll have to make an account with RDA
  - Click sign in on the top left of the webpage and follow the instructions to register as a new user
- Once you’ve registered, return to the NAM or GFS data page
- Click on the link for “Web File Listing” below “Web Server Holdings”
- Select the right-hand column: “Complete File List”
- Navigate to the files you need by picking the year then month of your model run
- Remember, you’ll need every file that occurs during your model run
  - For example: If you’re running WRF for 4/5/22 00Z – 4/6/22 00Z, you’ll need to download 5 NAM files (4/5 00Z, 06Z, 12Z, 18Z, 4/6 00Z)
- The easiest way to retrieve these files is to download them to your local machine then transfer them to Keeling
- To do this, simply click on each file name you need
- After a few moments, they should be downloaded
- Now, open a new terminal window (Mac) or ...
- Within the terminal, navigate to your downloads folder
- Now we’ll move these files from your local machine to your new WRF DATA directory
- Type: `scp [filename] [your Net ID]@keeling.earth.illinois.edu:/data/[path to new location on Keeling]/.`
- The files should now appear in you DATA directory

## Run WPS
- Return to your WPS directory
- `./geogrid.exe`
- Link our input data
  - `./link_grib.csh [path to data files]`
    - for example: `./link_grib.csh ../DATA`
- Link to the correct Vtable (depends on which model you are using for your input data NAM, GFS, or HRRR)
  - `ln -sf ungrib/Variable_Tables/Vtable.NAM Vtable` (for use with the NAM)
  - `ln -sf ungrib/Variable_Tables/Vtable.GFS Vtable` (for use with the GFS)
  - *Note: there is no pre-downloaded Vtable for the HRRR, but one is available from the University of Utah’s website (same location as where HRRR data is archived). More information is located in Appendix II*
- Now we ungrib our files
  - `./ungrib.exe`
  - *Note: If you have any files other than your input data files in the folder you linked to above, you will receive an error when trying to run ungrib. Remove any other files and try again.
- There should now a list of files with the prefix “FILE” in your directory
- Run metgrid
  - `./metgrid.exe`
- Now there should be a list of files with the prefix “met_em” in the WPS directory

##  Run WRF
- Navigate to where we’ll be running WRF
  - `cd ../WRF/test/em_real`
- Now we need to give WRF information about our run
- `vi namelist.input`
- …
- Link our met_em files to WRF
  - `ln -sf ../../../WPS/met_em.d0*.`
- We’re now ready to run WRF! There are a number of ways to actually accomplish this…
### Using a basic qlogin
- Type: qlogin -p node -n 16 -mem 128G
  - This allots 16 processors and 128 Gb of memory to this process
- Type: `mpirun -np 16 ./real.exe`
- Type: `mpirun -np 16 ./wrf.exe`
- This is an easy way to run WRF, but requires that your computer stays on and connected to Keeling for the entire process which isn’t ideal
- Instead, let’s use a batch script…
### Using a batch script
