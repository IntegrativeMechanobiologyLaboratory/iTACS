# iTACS overview

Need guidance to implement iTACS on your microscope? We will be glad to help: dtambe@southalabama.edu

Here is an overview of an iTACS-based experiment to examine physiological properties of individual adherent cells:

![iTACS process overview](https://user-images.githubusercontent.com/46034811/140856380-4b7b8a27-f6df-4979-9949-197b3c4e3777.png)

# Installation procedure

Current version works only on Linux and we have tested it on Ubuntu operating system (18.04 - 20.10). One of the best ways to use the software on other operating system is through virtual Ubuntu machine which involves installing [Oracle VM VirtualBox](https://www.virtualbox.org/) and on it [install Ubuntu](https://brb.nci.nih.gov/seqtools/installUbuntu.html).

| Task                                                         | Links                                                 |
| ------------------------------------------------------------ | ----------------------------------------------------- |
| Install Fiji                                                 | https://imagej.net/software/fiji/downloads            |
| Copy `Radial_Profile.java` to the `plugins` folder of Fiji   | https://imagej.nih.gov/ij/plugins/radial-profile.html |
| Install plugins`ImageJ-MATLAB`, `BIG-EPFL`, and `BioVoxxel` using `Help` > `Update` > `Manage update sites` from Fiji window | https://imagej.net/update-sites/setup                 |
| Install plugin `iterativePIV` by adding the link https://sites.imagej.net/iterativePIV/ to `Help` > `Update` > `Manage update sites` > `Add update site` | https://imagej.net/update-sites/setup                 |
| In the root folder, create a directory `/opt/`               |                                                       |
| Place the files `inti`, `edge`, and `strip` in the folder `/opt/MSM/` |                                                       |

Software to compute cell-ECM forces

> * Process used to compute cell-ECM forces is not included in this package, but any software that takes in the hydrogel surface deformation as input and provides forces exerted by a sheet of cells as output will work. Here is a software that will work for a thick hydrogel: [FTTC](https://sites.google.com/site/qingzongtseng/tfm).
> * The cell-ECM forces are then used by the `inti`, `edge`, and `strip` software to quantify mechanical stresses within the cellular cluster. These software expect the cell-ECM forces to be in `analysis/p*/traction/*_trac.dat` (where the first `*` is position number [`0`, `1`, `2`, `3`, ...] and the second `*` is the file number [`0001`, `0002`, `0003`, ...]) files with four columns: `x`   `y`  `Tx`  `Ty`. Units of `x` and `y` is pixels and `Tx` and `Ty` is Pascals.

