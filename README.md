# Keeling-WRF-Tutorial

This tutorial walks through how to download, set up, and run the Weather Research and Forecasting Model (WRF) on Keeling from your university laptop. All information is current as of Summer 2022. Certain aspects of the set-up process may change slightly in the future as WRF is updated beyond version 4.4.

Large portions of this tutorial are adapted from the UCAR WRF online tutorial, available here: https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php

Additional information provided by Seth Goodnight (jamessg3@illinois.edu)
Batch script provided by Steve Nesbitt (snesbitt@illinois.edu)
Tutorial compiled by Eddie Wolff (ecwolff3@illinois.edu)

## Downloading WRF and WPS (and required libraries)

- Register as a new WRF user
  - Go to: https://www2.mmm.ucar.edu/wrf/users/download/wrf-regist.php 
  - Fill out and submit the form
- Connect to Keeling
  - On Mac
    - Open a terminal
    - Type ssh [your NetID]@keeling.earth.illinois.edu
    - Type your university password and press enter
  - On Windows
    - ...
  - Note: If you are not connected to campus Wi-Fi, you’ll need to log in and start the Cisco AnyConnect VPN before connecting to Keeling


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
