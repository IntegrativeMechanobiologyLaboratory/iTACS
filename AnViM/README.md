# Analysis and Visualization Module

Module of iTACS designed to automate analysis and visualization of mechanical and chemical properties of adherent cells



## Installation instructions
* The setup is currently organized for Linux computers. Contact us if you want help with installing it on Windows
* Install `Fiji` (https://imagej.net/software/fiji/)
* Need imagej 52o onwards otherwise the nonblocking dialog will not work
* In the Fiji update sites include following: `BIG-EPFL`, `BioVoxxel`, `ParallelFFTJ`, `Radial profile`
* For PIV, click in Fiji: `Menu` > `Help` > `Update`... Then click `Manage update sites` > `Add update site` and add the URL: https://sites.imagej.net/iterativePIV
* For technical details on these plugins, see:
  * `ParallelFFTJ` - https://sites.google.com/site/piotrwendykier/software/parallelfftj
  * `Radial Profile` - https://imagej.nih.gov/ij/plugins/radial-profile.html
  * `ImageJ PIV` - https://sites.google.com/site/qingzongtseng/piv
* Keep the Matlab functions in the /opt/MATLAB/R2017a/toolboxes/matlab/traction/
  * These functions will be released soon 
* FORTRAN executables need to be kept in /opt/MSM/
