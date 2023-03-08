# iTACS overview

For a detailed protocol, please refer to [Nguyen et. al., **JoVE** 181, e63095 (2022)](https://www.jove.com/video/63095)

Need guidance to implement iTACS on your microscope or looking for collaboration? <br>
We will be glad to hear from you: dtambe@southalabama.edu<br><br>

Here is an overview of an iTACS-based experiment to examine physiological properties of individual adherent cells:

![iTACS process overview](https://user-images.githubusercontent.com/46034811/140856380-4b7b8a27-f6df-4979-9949-197b3c4e3777.png)

# Installing Analysis and Visualization Module (AnViM)

Current version is developed and tested on Ubuntu operating system (18.04 - 20.10). One of the best ways to use the software on other operating system is through virtual Ubuntu machine which involves installing [Oracle VM VirtualBox](https://www.virtualbox.org/) and on it [install Ubuntu](https://brb.nci.nih.gov/seqtools/installUbuntu.html).

| Task                                                         | Links                                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Install gfortran using `sudo apt install gfortran`           |                                                              |
| In the root folder, create a directory `/opt/`               |                                                              |
| Install Fiji in `/opt/Fiji.app/`                             | https://imagej.net/software/fiji/downloads                   |
| Save a copy of `Radial_Profile.java` in the `plugins` folder of Fiji | https://imagej.nih.gov/ij/plugins/radial-profile.html        |
| Install plugins`ImageJ-MATLAB`, `BIG-EPFL`, and `BioVoxxel` using `Help` > `Update` > `Manage update sites` from Fiji | https://imagej.net/update-sites/setup                        |
| Install plugin `iterativePIV` by adding the link https://sites.imagej.net/iterativePIV/ to `Help` > `Update` > `Manage update sites` > `Add update site` | https://imagej.net/update-sites/setup                        |
| Place the files `edge`, `inti`, `island`, and `strip` in the folder `/opt/MSM/` | https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/blob/main/AnViM/opt/iTACS/MSM/edge<br />https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/blob/main/AnViM/opt/iTACS/MSM/inti<br />https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/blob/main/AnViM/opt/iTACS/MSM/island<br />https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/blob/main/AnViM/opt/iTACS/MSM/strip |

Software to compute cell-ECM forces

> * Process used to compute cell-ECM forces is not included in this package, but any software that takes in the hydrogel surface deformation as input and provides forces exerted by a sheet of cells as output will work. Here is a software that will work for a thick hydrogel: [FTTC](https://sites.google.com/site/qingzongtseng/tfm).
> * The cell-ECM forces are then used by the `inti`, `edge`, and `strip` software to quantify mechanical stresses within the cellular cluster. These software expect the cell-ECM forces to be in `analysis/p*/traction/*_trac.dat` (where the first `*` is position number [`0`, `1`, `2`, `3`, ...] and the second `*` is the file number [`0001`, `0002`, `0003`, ...]) files with four columns: `x`   `y`  `Tx`  `Ty`. Unit of `x` and `y`: **pixel** and `Tx` and `Ty`: **Pascal**.

# Installing Acquisition and Training Module (AcTrM)

AcTrM is developed and tested on [Micro-Manager-2.0beta](https://valelab4.ucsf.edu/~MM/nightlyBuilds/2.0.0-beta/Windows) on Windows 10.  

| Task                                                         | Links                                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Install Micro-Manager 2.0 beta                               | https://valelab4.ucsf.edu/~MM/nightlyBuilds/2.0.0-beta/Windows |
| Establish a connection between Micro-Manager software and the microscope hardware | https://micro-manager.org/Device_Support<br />https://micro-manager.org/Micro-Manager_Configuration_Guide |
| Save a copy of `Turboreg_.jar` in the `plugins` folder of Micro-Manager | http://bigwww.epfl.ch/thevenaz/turboreg/                     |
| In the `plugins` folder of Micro-Manager, create a subfolder `IMBL` and copy in this subfolder the files `AcTrM.bsh`, `AcTrM_functions.bsh`, and `ColumnComparator.java` | https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/blob/main/AcTrM/Micro-Manager-2.0beta/plugins/IMBL/AcTrM.bsh<br />https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/blob/main/AcTrM/Micro-Manager-2.0beta/plugins/IMBL/AcTrM_functions.bsh<br />https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/blob/main/AcTrM/Micro-Manager-2.0beta/plugins/IMBL/ColumnComparator.java |

# Analyzing the demo files using AnViM

* Create a folder `tnimgs` in a suitable directory. Ensure that the path of this directory does not have space in the names of any of the parent folders.
* Copy all the `c*_p*_t*.tif` files from [GitHub](https://github.com/IntegrativeMechanobiologyLaboratory/iTACS/tree/main/demo/tnimgs) into the `tnimgs` folder.
* From Fiji, use `MSM` > `MSM - pre-processing` to start data analysis and follow the procedure described in the Nguyen, Battle, Paudel *et al.*, manuscript.<br />
  ![front](https://user-images.githubusercontent.com/46034811/141379114-b5949217-93be-45fb-a5d1-767e1132cb45.png)

# How to cite iTACS
Nguyen, A., Battle, K.C., Paudel S.S., et al. *Integrative Toolkit to Analyze Cellular Signals: Forces, Motion, Morphology, and Fluorescence.* **J. Vis. Exp.** 181, e63095 (2022).<br>
[PDF](https://www.jove.com/pdf/63095/jove-protocol-63095-integrative-toolkit-to-analyze-cellular-signals-forces-motion.pdf)&nbsp;&nbsp;
[HTML](https://www.jove.com/t/63095/integrative-toolkit-to-analyze-cellular-signals-forces-motion)<br>

**Accompanying JoVE Video**<br>
[![JoVE video](https://cloudfront.jove.com/CDNSource/teasers/63095.jpg)](https://www.jove.com/embed/player?id=63095)

# Notes
To segment smooth muscle cells that are separated and have long and narrow extensions, 
  (1) do cluster segmentation by thresholding to have white cells (pixel value 255) and black background (pixel value 0). 
  (2) for individual segmentation, start with parameter values: sledgehammer = 0, proninance = 100, mallet = 40
