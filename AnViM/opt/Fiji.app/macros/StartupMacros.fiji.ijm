// "StartupMacros"
// The macros and macro tools in this file ("StartupMacros.txt") are
// automatically installed in the Plugins>Macros submenu and
//  in the tool bar when ImageJ starts up.

//  About the drawing tools.
//
//  This is a set of drawing tools similar to the pencil, paintbrush,
//  eraser and flood fill (paint bucket) tools in NIH Image. The
//  pencil and paintbrush draw in the current foreground color
//  and the eraser draws in the current background color. The
//  flood fill tool fills the selected area using the foreground color.
//  Hold down the alt key to have the pencil and paintbrush draw
//  using the background color or to have the flood fill tool fill
//  using the background color. Set the foreground and background
//  colors by double-clicking on the flood fill tool or on the eye
//  dropper tool.  Double-click on the pencil, paintbrush or eraser
//  tool  to set the drawing width for that tool.
//
// Icons contributed by Tony Collins.

// Global variables
var pencilWidth=1,  eraserWidth=10, leftClick=16, alt=8;
var brushWidth = 10; //call("ij.Prefs.get", "startup.brush", "10");
var floodType =  "8-connected"; //call("ij.Prefs.get", "startup.flood", "8-connected");

// The macro named "AutoRunAndHide" runs when ImageJ starts
// and the file containing it is not displayed when ImageJ opens it.

// macro "AutoRunAndHide" {}

function UseHEFT {
	requires("1.38f");
	state = call("ij.io.Opener.getOpenUsingPlugins");
	if (state=="false") {
		setOption("OpenUsingPlugins", true);
		showStatus("TRUE (images opened by HandleExtraFileTypes)");
	} else {
		setOption("OpenUsingPlugins", false);
		showStatus("FALSE (images opened by ImageJ)");
	}
}

UseHEFT();

// The macro named "AutoRun" runs when ImageJ starts.

macro "AutoRun" {
	// run all the .ijm scripts provided in macros/AutoRun/
	autoRunDirectory = getDirectory("imagej") + "/macros/AutoRun/";
	if (File.isDirectory(autoRunDirectory)) {
		list = getFileList(autoRunDirectory);
		// make sure startup order is consistent
		Array.sort(list);
		for (i = 0; i < list.length; i++) {
			if (endsWith(list[i], ".ijm")) {
				runMacro(autoRunDirectory + list[i]);
			}
		}
	}
}

var pmCmds = newMenu("Popup Menu",
	newArray("Help...", "Rename...", "Duplicate...", "Original Scale",
	"Paste Control...", "-", "Record...", "Capture Screen ", "Monitor Memory...",
	"Find Commands...", "Control Panel...", "Startup Macros...", "Search..."));

macro "Popup Menu" {
	cmd = getArgument();
	if (cmd=="Help...")
		showMessage("About Popup Menu",
			"To customize this menu, edit the line that starts with\n\"var pmCmds\" in ImageJ/macros/StartupMacros.txt.");
	else
		run(cmd);
}

macro "Abort Macro or Plugin (or press Esc key) Action Tool - CbooP51b1f5fbbf5f1b15510T5c10X" {
	setKeyDown("Esc");
}

var xx = requires138b(); // check version at install
function requires138b() {requires("1.38b"); return 0; }

var dCmds = newMenu("Developer Menu Tool",
newArray("ImageJ Website","News", "Documentation", "ImageJ Wiki", "Resources", "Macro Language", "Macros",
	"Macro Functions", "Startup Macros...", "Plugins", "Source Code", "Mailing List Archives", "-", "Record...",
	"Capture Screen ", "Monitor Memory...", "List Commands...", "Control Panel...", "Search...", "Debug Mode"));

macro "Developer Menu Tool - C037T0b11DT7b09eTcb09v" {
	cmd = getArgument();
	if (cmd=="ImageJ Website")
		run("URL...", "url=http://rsbweb.nih.gov/ij/");
	else if (cmd=="News")
		run("URL...", "url=http://rsbweb.nih.gov/ij/notes.html");
	else if (cmd=="Documentation")
		run("URL...", "url=http://rsbweb.nih.gov/ij/docs/");
	else if (cmd=="ImageJ Wiki")
		run("URL...", "url=http://imagejdocu.tudor.lu/imagej-documentation-wiki/");
	else if (cmd=="Resources")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/");
	else if (cmd=="Macro Language")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/macros.html");
	else if (cmd=="Macros")
		run("URL...", "url=http://rsbweb.nih.gov/ij/macros/");
	else if (cmd=="Macro Functions")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/functions.html");
	else if (cmd=="Plugins")
		run("URL...", "url=http://rsbweb.nih.gov/ij/plugins/");
	else if (cmd=="Source Code")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/source/");
	else if (cmd=="Mailing List Archives")
		run("URL...", "url=https://list.nih.gov/archives/imagej.html");
	else if (cmd=="Debug Mode")
		setOption("DebugMode", true);
	else if (cmd!="-")
		run(cmd);
}

var sCmds = newMenu("Stacks Menu Tool",
	newArray("Add Slice", "Delete Slice", "Next Slice [>]", "Previous Slice [<]", "Set Slice...", "-",
		"Convert Images to Stack", "Convert Stack to Images", "Make Montage...", "Reslice [/]...", "Z Project...",
		"3D Project...", "Plot Z-axis Profile", "-", "Start Animation", "Stop Animation", "Animation Options...",
		"-", "MRI Stack (528K)"));
macro "Stacks Menu Tool - C037T0b11ST8b09tTcb09k" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

var luts = getLutMenu();
var lCmds = newMenu("LUT Menu Tool", luts);
macro "LUT Menu Tool - C037T0b11LT6b09UTcb09T" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}
function getLutMenu() {
	list = getLutList();
	menu = newArray(16+list.length);
	menu[0] = "Invert LUT"; menu[1] = "Apply LUT"; menu[2] = "-";
	menu[3] = "Fire"; menu[4] = "Grays"; menu[5] = "Ice";
	menu[6] = "Spectrum"; menu[7] = "3-3-2 RGB"; menu[8] = "Red";
	menu[9] = "Green"; menu[10] = "Blue"; menu[11] = "Cyan";
	menu[12] = "Magenta"; menu[13] = "Yellow"; menu[14] = "Red/Green";
	menu[15] = "-";
	for (i=0; i<list.length; i++)
		menu[i+16] = list[i];
	return menu;
}

function getLutList() {
	lutdir = getDirectory("luts");
	list = newArray("No LUTs in /ImageJ/luts");
	if (!File.exists(lutdir))
		return list;
	rawlist = getFileList(lutdir);
	if (rawlist.length==0)
		return list;
	count = 0;
	for (i=0; i< rawlist.length; i++)
		if (endsWith(rawlist[i], ".lut")) count++;
	if (count==0)
		return list;
	list = newArray(count);
	index = 0;
	for (i=0; i< rawlist.length; i++) {
		if (endsWith(rawlist[i], ".lut"))
			list[index++] = substring(rawlist[i], 0, lengthOf(rawlist[i])-4);
	}
	return list;
}

macro "Pencil Tool - C037L494fL4990L90b0Lc1c3L82a4Lb58bL7c4fDb4L5a5dL6b6cD7b" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(pencilWidth);
}

macro "Paintbrush Tool - C037La077Ld098L6859L4a2fL2f4fL3f99L5e9bL9b98L6888L5e8dL888c" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(brushWidth);
}

macro "Flood Fill Tool -C037B21P085373b75d0L4d1aL3135L4050L6166D57D77D68La5adLb6bcD09D94" {
	requires("1.34j");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0) setColorToBackgound();
	floodFill(x, y, floodType);
}

function draw(width) {
	requires("1.32g");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	setLineWidth(width);
	moveTo(x,y);
	x2=-1; y2=-1;
	while (true) {
		getCursorLoc(x, y, z, flags);
		if (flags&leftClick==0) exit();
		if (x!=x2 || y!=y2)
			lineTo(x,y);
		x2=x; y2 =y;
		wait(10);
	}
}

function setColorToBackgound() {
	savep = getPixel(0, 0);
	makeRectangle(0, 0, 1, 1);
	run("Clear");
	background = getPixel(0, 0);
	run("Select None");
	setPixel(0, 0, savep);
	setColor(background);
}

// Runs when the user double-clicks on the pencil tool icon
macro 'Pencil Tool Options...' {
	pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);
}

// Runs when the user double-clicks on the paint brush tool icon
macro 'Paintbrush Tool Options...' {
	brushWidth = getNumber("Brush Width (pixels):", brushWidth);
	call("ij.Prefs.set", "startup.brush", brushWidth);
}

// Runs when the user double-clicks on the flood fill tool icon
macro 'Flood Fill Tool Options...' {
	Dialog.create("Flood Fill Tool");
	Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);
	Dialog.show();
	floodType = Dialog.getChoice();
	call("ij.Prefs.set", "startup.flood", floodType);
}

macro "Set Drawing Color..."{
	run("Color Picker...");
}

macro "-" {} //menu divider

macro "About Startup Macros..." {
	title = "About Startup Macros";
	text = "Macros, such as this one, contained in a file named\n"
		+ "'StartupMacros.txt', located in the 'macros' folder inside the\n"
		+ "Fiji folder, are automatically installed in the Plugins>Macros\n"
		+ "menu when Fiji starts.\n"
		+ "\n"
		+ "More information is available at:\n"
		+ "<http://imagej.nih.gov/ij/developer/macro/macros.html>";
	dummy = call("fiji.FijiTools.openEditor", title, text);
}

macro "Save As JPEG... [j]" {
	quality = call("ij.plugin.JpegWriter.getQuality");
	quality = getNumber("JPEG quality (0-100):", quality);
	run("Input/Output...", "jpeg="+quality);
	saveAs("Jpeg");
}

macro "Save Inverted FITS" {
	run("Flip Vertically");
	run("FITS...", "");
	run("Flip Vertically");
}





// Copyright, Dhananjay T. Tambe, Integrative Mechanobiology Laboratory
// University of South Alabama
// Department of Pharmacology
// March 5, 2019

/*--------------------------------------------------------------------
 * To kill the analysis File > Close All
 --------------------------------------------------------------------*/
var AnViMs = getAnViMList();
var lFunc = newMenu("AnViM Menu Tool", AnViMs);
function getAnViMList(){
	variables = newArray(21);
	variables[0] = "MSM - pre-processing";
	variables[1] = "MSM - gel deformation";
	variables[2] = "MSM - cell-ECM & cell-cell forces";
	variables[3] = "MSM - cellular motion";
	variables[4] = "-";
	variables[5] = "Segmentation - cellular cluster";
	variables[6] = "Segmentation - individual cells";
	variables[7] = "Segmentation - apply single segmentation to all frames*";
	variables[8] = "-";
	variables[9] = "Map on cells - intensities*";
	variables[10] = "Map on cells - motion/force data*";
	variables[11] = "-";
	variables[12] = "Results - track data*";
	variables[13] = "Results - plot*";
	variables[14] = "Results - picture*";
	variables[15] = "-";
	variables[16] = "Accessories";
	variables[17] = "Help";
	variables[18] = "-";
	variables[19] = "-";
	variables[20] = "*\* - requires segmentation of images in 'phs' folder";

	return variables;
}



macro "AnViM Menu Tool - C037T0b11MT7b09STcb09M" {
	varLst = getAnViMList();
	cmd = getArgument();
	if (cmd!="-"){
		if(cmd==varLst[0]){
			preprocess_MSM();  // does bunch of things
		} else if(cmd==varLst[1]){ // variables[11] = "MSM -  Gel deformation";
		    setBatchMode(true);
		    calculateDeformation(); 
		} else if(cmd==varLst[2]){//	variables[12] = "MSM - Cell-ECM forces";
		    setBatchMode(true);
		    parentDir = calculateTraction();
		    calculateStress(parentDir);
		} else if(cmd==varLst[3]){//	variables[14] = "MSM - Cellular motion";
		    setBatchMode(true);
		    calculateVelocity(); // showMessage("Work in progress!"); 
		} else if(cmd==varLst[5]){
			clusterSegmentation("");  // "Cell vs no-cell separation"
		} else if(cmd==varLst[6]){
			individualCellSegmentation();  // "Detect individual cells"
		} else if(cmd==varLst[7]){//	variables[10] = "MSM - Pre-processing";
			singleSegFileForAllImages();  // use single segmentation file
		} else if(cmd==varLst[9]){//	variables[10] = "MSM - Pre-processing";
			setBatchMode(true);
			outArray = recordPhaseValue(false,0,0,0,0,0);  // "Record phase value"
			if(parseInt(outArray[4])==1){
				outArray = recordPhaseValue(true,parseInt(outArray[0]), parseInt(outArray[1]), outArray[2], parseInt(outArray[3]), parseInt(outArray[4]));
			}
		} else if(cmd==varLst[10]){
			setBatchMode(true);
			outArray = addColsFromGridData_all(false, 0, 0, 0, 0, 0, 0, 0, 0);  // "Add to Results from grid data"
			if(parseInt(outArray[5])==1){
				setBatchMode(true);
				outArray = addColsFromGridData_all(true, parseInt(outArray[0]), parseInt(outArray[1]), parseInt(outArray[2]), outArray[3], parseInt(outArray[4]), parseInt(outArray[5]), parseInt(outArray[6]), parseInt(outArray[7]));
			}
		} else if(cmd==varLst[12]){
			trackingCellularProperties();
		} else if(cmd==varLst[13]){
			setBatchMode(true);
			plotTrackedData();
		} else if(cmd==varLst[14]){
			displayCellPropMaps();  // "Create cell property maps"
		} else if(cmd==varLst[16]){
			setBatchMode(false);
			Dialog.create("Choose an accessory function");
			funcStr = newArray("- Morph data into AcTrM-like format");
			Dialog.addRadioButtonGroup("", funcStr, funcStr.length, 1, funcStr[0])
			Dialog.show()
			js = Dialog.getRadioButton();
			setBatchMode(true);
			if(js==funcStr[0]){
			    setBatchMode(true);
			    mimicAcTrMFormat();
			}
		} else if(cmd==varLst[17]){
		    welcomeMessage_msm();
		}
	}
	if(isOpen("Results")){
		selectWindow("Results");
		run("Close");
	}
	if(isOpen("Console")){
		selectWindow("Console");
		run("Close");
	}
}






function mimicAcTrMFormat(){
	
	// choose the directory where images are stored
	dir = getDirectory("Choose the directory of dedrifted images in '0001.tif' format ");
	File.makeDirectory(dir+"tnimgs/");
	File.makeDirectory(dir+"analysis/");
	File.makeDirectory(dir+"analysis/"+"p0/");
	setBatchMode(false);
	run("Image Sequence...", "dir="+dir+" sort");
	rename("invCheck");
	run("Animation Options...", "speed=7 first=1 last="+d2s(nSlices,0));
	doCommand("Start Animation [\\]");
	Dialog.create("Boundary conditions: ");
	cellBeadChoice = newArray("Cells","Beads");
	Dialog.addRadioButtonGroup("Are these the images of cells or tiny beads?", cellBeadChoice, 1, 2, cellBeadChoice[0]);
	js = newArray("none", "allFour", "topBottom", "leftRight", "leftTopBottom", "rightTopBottom", "topLeftRight", "bottomLeftRight");
	Dialog.addChoice("Which image boundaries do cells cross? ", js, js[1]);
	// choose file type (phs or tny) all dedrifted
	Dialog.addNumber("Pixel size (20X-0.32531): ", 0.65062, 5, 12, " microns");
	Dialog.addMessage("'none' = all cells are entirely within the image boundary");
	Dialog.addMessage("'allfour' = cells are crossing all four image boundaries");
	Dialog.addMessage("'leftTopBottom' = cells do not cross right image boundary");
	Dialog.addMessage("Note: The images must be free from any stage drif");
	Dialog.show();
	imType = Dialog.getRadioButton();
	bcond = Dialog.getChoice();
	pixSz = Dialog.getNumber();
	close("invCheck");
	setBatchMode(true);
	
	bcondOut = fixImages(bcond,dir);
	
	f = File.open(dir+"analysis/analysisChoices.txt");
	print(f, "3\t1\t"+d2s(nimgs,0));
	print(f,"0\t0\t0");
	print(f,"0\t0\t0");
	print(f, "50\t5");
	print(f, bcondOut);
	print(f, d2s(pixSz,5));
	File.close(f);
	
	channels = 3;
	if(imType==1){// cells
		File.makeDirectory(dir+"analysis/"+"p0/"+"phs/");
	} else {// tny beads
		File.makeDirectory(dir+"analysis/"+"p0/"+"tny/");
	}
	js = getFileList(dir);
	files = newArray();
	for(i=0;i<js.length;i++){
		if(endsWith(js[i],".tif")){
			print(js[i]);
			files = Array.concat(files,js[i]);
		}
	}
	
	nimgs = files.length;
	
	f = File.open(dir+"analysis/"+"p0/"+"skipAnalysis.txt");
	for(i=0;i<nimgs;i++){
		print(f, "0");
	}
	File.close(f);
	
	for(i=0;i<nimgs;i++){
		// put files in tnimgs
		f = File.open(dir+"tnimgs/"+"c0_p0_t"+d2s(i,0)+".tif");
		print(f, "");
		File.close(f);
	
		// put files in phs
		if(imType==1){// cells
			File.rename(dir+files[i], dir+"analysis/"+"p0/"+"phs/"+files[i]);
		} else {// tny beads
			File.rename(dir+files[i], dir+"analysis/"+"p0/"+"tny/"+files[i]);
		}
	}
	
	print("---> Created fileset that mimics AcTrM format! Now analyze these images.");
	showMessage("Created fileset that mimics AcTrM format! Now analyze these images.");
}




function fixImages(bcondIn,tnimgsDir){
	bcondOut = bcondIn;
	nRot = 0;
	if(bcondIn=="topBottom"){
		bcondOut = "allTwo";
	} else if(bcondIn=="leftRight"){
		bcondOut = "allTwo";
		nRot = 1;
	} else if(bcondIn == "rightTopBottom"){
		// rotate images from phs and tny by 180 degrees cw
		nRot = 2;
		bcondOut = "leftTopBottom";		
	} else if(bcondIn == "topLeftRight"){
		//  ... rotate images from phs and tny by 90 degrees ccw
		nRot = 3;
		bcondOut = "leftTopBottom";
	} else if(bcondIn == "bottomLeftRight"){
		//  ... rotate images from phs and tny by 90 degrees cw
		nRot = 1;
		bcondOut = "leftTopBottom";
	}

	if(nRot>0){
		fnames = endsWith_file_dir_list(tnimgsDir, ".tif");
		setBatchMode(true);
		//for(j=0;j<2;j++){// j = 0 ... phs; j=1...tny
		for(i=0;i<fnames.length;i++){
			open(tnimgsDir+fnames[i]);
			for(k=0;k<nRot;k++){
				run("Rotate 90 Degrees Right");
			}
			saveAs("Tiff", tnimgsDir+fnames[i]);
			close();
		}
		//}	
	}
		
	return bcondOut;
}





function singleSegFileForAllImages(){

	// get the main folder that has data subfolders
	workDir = getDirectory("Choose the position directory");
	segDir = "segmentedImages/";
	bwDir = "bwImages/";
	resultsDir = "textResults/";
	individualInput = "individualInput.txt";
	clusterInput = "clusterInput.txt";
	cellPropMapsDir = "cellPropMaps/"; // within segDir
	overlapDir = "cellNoCellOverlap/"; // within bwDir
	refFileName = "refFrameName.txt";
	
	run("Close All");

	runThisFunction = getBoolean("Use single segmentation for all frames?", "Yes", "No");
			
	if(runThisFunction==1){
		nestedFolders =  endsWith_file_dir_list(workDir, "/");
	
		folderIndices = getIncrementIndex("Folders", nestedFolders);
		startFolder = folderIndices[0];
		folderIncrement = folderIndices[1];
		endFolder = folderIndices[2];
				
		for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){
			nestedFolder = nestedFolders[jFolder];

			if(File.exists(workDir+nestedFolder+"segmentedImagesBKUP")){
				exit("Make sure that there are no *BKUP folders in "+workDir+nestedFolder+"\n\n Delete existing segmentedImages, textResults, bwImages and remove BKUP from similar folders");
			}
			if(File.exists(workDir+nestedFolder+"textResultsBKUP")){
				exit("Make sure that there are no *BKUP folders in "+workDir+nestedFolder+"\n\n Delete existing segmentedImages, textResults, bwImages and remove BKUP from similar folders");
			}
			if(File.exists(workDir+nestedFolder+"bwImagesBKUP")){
				exit("Make sure that there are no *BKUP folders in "+workDir+nestedFolder+"\n\n Delete existing segmentedImages, textResults, bwImages and remove BKUP from similar folders");
			}
			
			files =  endsWith_file_dir_list(workDir+nestedFolder,".tif");
			
			print("Going for "+workDir+nestedFolder);

			// provide option of file to choose for reference
			setBatchMode(false);
			run("Image Sequence...", "dir="+workDir+nestedFolder+segDir+cellPropMapsDir+" filter=_merged.tif sort");
			rename("merSeq");
			Dialog.createNonBlocking("Choose reference segmentation");
			labls = newArray(nSlices);
			for(i=0;i<nSlices;i++){
				setSlice(i+1);
				labls[i] = getInfo("slice.label");
			}
			Dialog.addChoice("Frame number:", labls);
			Dialog.addMessage("Go through the images and indicate the desired segmentation file in the dropdown menu");
			Dialog.addMessage("Current segmentation data will be stored in *BKUP folders, new folders will have just the chosen segmentation for each frame");
			Dialog.setLocation(0,0);
			js = Dialog.show();
			js = Dialog.getChoice();
			setBatchMode(true);
			ji = nSlices;
			for(i=0;i<ji;i++){
				setSlice(i+1);
				if(js==getInfo("slice.label")){
					ji = 0;
					refIFILE=i;
				}
			}
			close("merSeq");
			
			// save the choice
			if(File.exists(workDir+nestedFolder+refFileName)){
				File.delete(workDir+nestedFolder+refFileName);
			}
			f = File.open(workDir+nestedFolder+refFileName);
			print(f, d2s(refIFILE,0));
			close(f);
			
			
			setBatchMode(true);
			
			// rename segmentedImages to segmentedImagesBKUP
			File.rename(workDir+nestedFolder+"segmentedImages", workDir+nestedFolder+"segmentedImagesBKUP");
			
			// rename textResults to textResultsBKUP
			File.rename(workDir+nestedFolder+"textResults", workDir+nestedFolder+"textResultsBKUP");
			
			// rename bwImages to bwImagesBKUP
			File.rename(workDir+nestedFolder+"bwImages", workDir+nestedFolder+"bwImagesBKUP");

			// create new segmentedImages, textResults, and bwImages, bwImages/cellNoCellOverlap, segmentedImages/cellPropMaps
			js = File.makeDirectory(workDir+nestedFolder+segDir);
			js = File.makeDirectory(workDir+nestedFolder+resultsDir);		
			js = File.makeDirectory(workDir+nestedFolder+bwDir);
			js = File.makeDirectory(workDir+nestedFolder+bwDir+overlapDir);
			js = File.makeDirectory(workDir+nestedFolder+segDir+cellPropMapsDir);

			// copy the file frameNum_percentHealed.txt into textResults
			copyFile(workDir+nestedFolder+"textResultsBKUP/", "frameNum_percentHealed.txt", workDir+nestedFolder+"textResults/", "frameNum_percentHealed.txt");
			
			for(ifile=0;ifile<files.length;ifile++){
				// copy that .tif for all frames in bwImages
				copyFile(workDir+nestedFolder+"bwImagesBKUP/", files[refIFILE], workDir+nestedFolder+"bwImages/", files[ifile]);
				
				// copy that .csv for all frames in the textResults
				copyFile(workDir+nestedFolder+"textResultsBKUP/", replace(files[refIFILE],".tif",".csv"), workDir+nestedFolder+"textResults/", replace(files[ifile],".tif",".csv"));
				
				// copy that _areaStat.txt for all frames in textResults
				copyFile(workDir+nestedFolder+"textResultsBKUP/", replace(files[refIFILE],".tif","_areaStat.txt"), workDir+nestedFolder+"textResults/", replace(files[ifile],".tif","_areaStat.txt"));
				
				// copy that roi.zip for all frames in textResults
				copyFile(workDir+nestedFolder+"textResultsBKUP/", replace(files[refIFILE],".tif","_roi.zip"), workDir+nestedFolder+"textResults/", replace(files[ifile],".tif","_roi.zip"));
				
				// copy that *.tif for all frames in segmentedImages/cellPropMaps
				copyFile(workDir+nestedFolder+"segmentedImagesBKUP/"+cellPropMapsDir, files[refIFILE], workDir+nestedFolder+"segmentedImages/"+cellPropMapsDir, files[ifile]);
				
				// copy that *_merged.tif for all frames in segmentedImages/cellPropMaps
				copyFile(workDir+nestedFolder+"segmentedImagesBKUP/"+cellPropMapsDir, replace(files[refIFILE],".tif","_merged.tif"), workDir+nestedFolder+"segmentedImages/"+cellPropMapsDir, replace(files[ifile],".tif","_merged.tif"));
				
				// copy that *_cellID.tif for all frames in segmentedImages/cellPropMaps
				copyFile(workDir+nestedFolder+"segmentedImagesBKUP/"+cellPropMapsDir, replace(files[refIFILE],".tif","_cellID.tif"), workDir+nestedFolder+"segmentedImages/"+cellPropMapsDir, replace(files[ifile],".tif","_cellID.tif"));
			}
		}
	}
	print("---> File reorganization completed! \nIf you have already executed the functions from 'Map on cells' or 'Results', then you will need to run them again. \nUse same variable names as in 'textResults/*.csv'");
	showMessage("File reorganization completed! \nOutput: 'analysis/p*/phs/*/' \nIf you have already executed the functions from 'Map on cells' or 'Results', then you will need to run them again. \nUse same variable names as in 'textResults/*.csv'");
}





function copyFile(dirold, fold, dirnew, fnew){
	if(File.exists(dirold+fnew)){ // if such file existed previously, then save the ref in that name
		File.copy(dirold+fold,dirnew+fnew);
	}
}







function getnumString(i){
	numString = "";
	if(i<10){
		numString = "000"+d2s(i,0);
	} else if(i<100){
		numString = "00"+d2s(i,0);
	} else if(i<1000){
		numString = "0"+d2s(i,0);
	} else{
		numString = d2s(i,0);
	}
	return numString;
}





function clusterSegmentation(workDir){
	run("Close All");

	// get the main folder that has data subfolders
	showNotPrint=0;
	if(workDir==""){
		workDir = getDirectory("Choose the position directory");
		showNotPrint=1;
	}
	segDir = "segmentedImages/";
	bwDir = "bwImages/";
	resultsDir = "textResults/";
	individualInput = "individualInput.txt";
	clusterInput = "clusterInput.txt";
	cellPropMapsDir = "cellPropMaps/"; // within segDir
	overlapDir = "cellNoCellOverlap/"; // within bwDir
	
	// get the list of subfodlers (names and number)
	nestedFolders =  endsWith_file_dir_list(workDir, "/");

	
	askFlag = File.exists(workDir+clusterInput);
	if(askFlag==1){
		ff = File.openAsString(workDir+clusterInput);
		jjrows = split(ff, "\n");
		Array.print(jjrows);
		removeExistingFile(workDir+clusterInput);
	}

	print("Identifying cell versus no cell area");

	folderIndices = getIncrementIndex("Folders", nestedFolders);
	startFolder = folderIndices[0];
	folderIncrement = folderIndices[1];
	endFolder = folderIndices[2];

	batchModeFlag = 0;
	if(is("Batch Mode")==1){
		batchModeFlag = 1;
	}
	if(batchModeFlag!=1){
		setBatchMode(true);
	}
	for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){
		nestedFolder = nestedFolders[jFolder];
		
		print("Checking file labels for images in "+workDir+nestedFolder);
		nestedFolder = nestedFolders[jFolder];
	
		
		// make sure that the filename matches the label name
		lstNFls = endsWith_file_dir_list(workDir+nestedFolder, ".tif");
		for(i=0; i<lstNFls.length; i++){
			open(workDir+nestedFolder+lstNFls[i]);
			run("Set Label...", "label="+lstNFls[i]);
			run("Save");
			close();
		}
	}	
	if(batchModeFlag!=1){
		setBatchMode(false);
	}


	wholeDomainCheck = 0; wholeDomainFlag = 0;
	negativeFlags = 0; m1InvertFlag = 0; m2InvertFlag = 0; m3InvertFlag = 0; m4InvertFlag = 0;
	firstFrame = 0; //startFolder = 0; folderIncrement = 1;
	fileIndexFlag = 0;
	jFolder=startFolder;
	nestedFolder = nestedFolders[jFolder];
		
	files =  endsWith_file_dir_list(workDir+nestedFolder,".tif");
	
	fileIndices = getIncrementIndex("Files", files);
	startFile = 0;
	fileIncrement = fileIndices[0];

	endFile = files.length;
	ifile=startFile;
	
	run("Close All");

	wholeDomainFlag = getBoolean("Is the monolayer confluent?", "Yes", "No");
	removeExistingFile(workDir+clusterInput);
			
	if(wholeDomainFlag!=1){
		micronsPerPix = getMicronsPerPixel(workDir+nestedFolder+files[ifile]);
			
		input = inputParameters_clusterSeg(workDir, workDir+nestedFolder+files[ifile], clusterInput);
					
		dirtSize = input[0];
		nOpenClose = input[1];
		smearSize = input[6];
		method1Flag = input[2];
		method2Flag = input[3];
		method3Flag = input[4];
		method4Flag = input[5];
	}


	jFolder=startFolder;
	nestedFolder = nestedFolders[jFolder];
		
		
	files =  endsWith_file_dir_list(workDir+nestedFolder,".tif");
	
	ifile=startFile;
	
	print("File number "+d2s(ifile,0));
			
	run("Close All");

	if(wholeDomainFlag!=1){
		
		if(is("Batch Mode")){
			setBatchMode(false);
		}
		open(workDir+nestedFolder+files[ifile]);
		run("8-bit");
		setVoxelSize(1, 1, 1, "pixel");
		run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
		rename("imCurrent");

		open(workDir+nestedFolder+files[ifile+1]);
		run("8-bit");
		setVoxelSize(1, 1, 1, "pixel");
		run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
		rename("imNext");

		if(method1Flag==1) m1InvertFlag = method1("tmp", "tmp1", smearSize, m1InvertFlag, negativeFlags);

		if(method2Flag==1) m2InvertFlag = method2("tmp", "tmp1", smearSize, m2InvertFlag, negativeFlags);
		
		if(method3Flag==1) m3InvertFlag = method3("tmp", "tmp1", smearSize, m3InvertFlag, negativeFlags);
				
		if(method4Flag==1) m4InvertFlag = method4("tmp", "tmp1", smearSize, m4InvertFlag, negativeFlags);
	}
	
	//setBatchMode(true);
	
	negativeFlags=1; // no more updating of InvertFlags

	for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){
		nestedFolder = nestedFolders[jFolder];
		
		print("Going for "+workDir+nestedFolder);
		
		js = File.makeDirectory(workDir+nestedFolder+segDir);
		js = File.makeDirectory(workDir+nestedFolder+segDir+cellPropMapsDir);
		js = File.makeDirectory(workDir+nestedFolder+workDir);
		js = File.makeDirectory(workDir+nestedFolder+bwDir);
		js = File.makeDirectory(workDir+nestedFolder+bwDir+overlapDir);
		js = File.makeDirectory(workDir+nestedFolder+resultsDir);		
		
		files =  endsWith_file_dir_list(workDir+nestedFolder,".tif");

		for(ifile=startFile; ifile<endFile; ifile=ifile+fileIncrement){
	
			print("File number "+d2s(ifile,0)+" of "+d2s(endFile,0));
			
			run("Close All");

			if(wholeDomainFlag==1){
				open(workDir+nestedFolder+files[ifile]);
				run("8-bit");
				imW = getWidth();
				imH = getHeight();
				run("Select All");
		        setForegroundColor(255, 255, 255);
				run("Fill", "slice");
				run("Select None");
				
				saveAs("Tiff", workDir+nestedFolder+bwDir+files[ifile]);
				run("Close All");

				// this file is subsequently used to trace file numbers that are processed
				f = File.open(workDir+nestedFolder+resultsDir+replace(files[ifile],".tif","_areaStat.txt")); // display file open dialog
				print(f, d2s(imW*imH,0) + "\t" + d2s(imW*imH,0) + "\t" + d2s(imW*imH,0) + "\t" + d2s(0,0));
				File.close(f);
				
			} else if (File.exists(workDir+nestedFolder+bwDir+files[ifile])==0){
				
				open(workDir+nestedFolder+files[ifile]);
				run("8-bit");
				setVoxelSize(1, 1, 1, "pixel");
				run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
				rename("imCurrent");

				if(ifile==endFile-1){
					open(workDir+nestedFolder+files[ifile-1]);
				} else {
				    open(workDir+nestedFolder+files[ifile+1]);
				}
				run("8-bit");
				setVoxelSize(1, 1, 1, "pixel");
				run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
				rename("imNext");

				if(method1Flag==1) m1InvertFlag = method1("tmp", "tmp1", smearSize, m1InvertFlag, negativeFlags);

				if(method2Flag==1) m2InvertFlag = method2("tmp", "tmp1", smearSize, m2InvertFlag, negativeFlags);

				if(method3Flag==1) m3InvertFlag = method3("tmp", "tmp1", smearSize, m3InvertFlag, negativeFlags);
				
				if(method4Flag==1) m4InvertFlag = method4("tmp", "tmp1", smearSize, m4InvertFlag, negativeFlags);

				selectWindow("result");
		
				run("EDM Binary Operations", "iterations="+nOpenClose+" operation=close");
				run("Invert");
				
				run("EDM Binary Operations", "iterations="+nOpenClose+" operation=close");
				run("Invert");
				
				run("EDM Binary Operations", "iterations="+nOpenClose+" operation=close");
				run("EDM Binary Operations", "iterations="+nOpenClose+" operation=open");
				
				close("\\Others");
				
				saveAs("Tiff", workDir+nestedFolder+bwDir+files[ifile]);
				
				run("Close All");
			} else {
				print("To redo segmentation, remove file  "+workDir+nestedFolder+bwDir+files[ifile]);
			}
		}

		// store healing data
		percentCellArea = newArray(files.length);
		run("Image Sequence...", "dir="+workDir+nestedFolder+bwDir+" sort");
		rename("cellNoCell");
		run("Set Measurements...", "area area_fraction redirect=cellNoCell decimal=6");
		removeExistingFile(workDir+nestedFolder+resultsDir+"healingData.txt");
		f = File.open(workDir+nestedFolder+resultsDir+"frameNum_percentHealed.txt"); // display file open dialog

		counter = 0;
		for(ifile=0; ifile<files.length; ifile++){
			run("Measure");
			run("Next Slice [>]");
			percentCellArea[counter] = getResult("%Area", counter);
			print(f, d2s(ifile,0) +"  \t"+ d2s(percentCellArea[counter],5));
			counter = counter + 1;
		}
		File.close(f);
		run("Clear Results");
		run("Close All");
		close("*");
	}




	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setTool("rectangle");
	for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){
		nestedFolder = nestedFolders[jFolder];
		
		print("Going for "+workDir+nestedFolder);
		
		files =  endsWith_file_dir_list(workDir+nestedFolder,".tif");

		correctionIterations = 10;
		if(wholeDomainFlag==1){
			correctionIterations = 0;
		}
		for(icorr = 0; icorr<correctionIterations; icorr++){
			wasBatchMode = is("Batch Mode");
			if(wasBatchMode){
				setBatchMode(false);
			}
			
			run("Image Sequence...", "dir="+workDir+nestedFolder+bwDir+" sort");
			rename("fixSpots");
			Dialog.createNonBlocking("Directions to clean the binary image:");
			Dialog.addMessage("Region occupied by the cells must be WHITE, everything else must be BLACK");
			Dialog.addMessage("- Select checkbox + 'OK' button - AUTOMATICALLY BLACK and WHITE holes in entire stack");
			Dialog.addCheckbox("- Fill spots automatically (monolayer is confluent)", false);
			Dialog.addMessage("- OR -");
			Dialog.addCheckbox("- Reverse the operation of automatic filling", false);
			Dialog.addMessage("- OR -");
			Dialog.addMessage("Draw rectangle around the region that needs fixing (incorrect WHITE or BLACK spot)");
			Dialog.addMessage("'Delete' button - BLACKEN the selected region in the slice");
			Dialog.addMessage("'Edit' > 'Clear' - BLACKEN the selected region in entire stack");
			Dialog.addMessage("'Ctrl+f' button - WHITEN the selected region in the slice");
			Dialog.addMessage("'Edit' > 'Fill' - WHITEN the selected region in entire stack");
			Dialog.addMessage("- 'OK' button - Satisfied with the accuracy of cluster segmentation");
			Dialog.setLocation(0,0);
			js = Dialog.show();
			autoFillFlag = Dialog.getCheckbox();
			reverseAutoFill = Dialog.getCheckbox();
			if(autoFillFlag==1){
				close("fixSpots");
				if(wasBatchMode){
					setBatchMode(true);
				}

				// make a backup of the bwimages
				File.makeDirectory(workDir+nestedFolder+bwDir+"BKUP"+bwDir);
				exec("cp", "-f", workDir+nestedFolder+bwDir+"*.tif "+workDir+nestedFolder+bwDir+"BKUP"+bwDir);
				
				for(ifile=startFile; ifile<endFile; ifile=ifile+fileIncrement){
					print("Filling spots in image "+d2s(ifile,0)+" of "+d2s(endFile,0));
					createMaskImage(workDir+nestedFolder+bwDir, workDir+nestedFolder+bwDir, files[ifile]);
				}
			} else if (autoFillFlag==0 && reverseAutoFill==1){
				exec("cp", "-f", workDir+nestedFolder+bwDir+"BKUP"+bwDir+"*.tif "+workDir+nestedFolder+bwDir);
				exec("rm", "-rf", workDir+nestedFolder+bwDir+"BKUP"+bwDir);				
			} else if (autoFillFlag==0 && reverseAutoFill==0){	
				// if BKUP filder exists delete it
				exec("rm", "-rf", workDir+nestedFolder+bwDir+"BKUP"+bwDir);
				run("Image Sequence... ", "format=TIFF name=[] use save="+workDir+nestedFolder+bwDir);
				close("fixSpots");
				correctionIterations = 0;
			}
			if(wasBatchMode){
				setBatchMode(true);
			}
			
			// store healing data
			percentCellArea = newArray(files.length);
			run("Image Sequence...", "dir="+workDir+nestedFolder+bwDir+" sort");
			rename("cellNoCell");
			run("Set Measurements...", "area area_fraction redirect=cellNoCell decimal=6");
			removeExistingFile(workDir+nestedFolder+resultsDir+"healingData.txt");
			f = File.open(workDir+nestedFolder+resultsDir+"frameNum_percentHealed.txt"); // display file open dialog
	
			counter = 0;
			for(ifile=0; ifile<files.length; ifile++){
				run("Measure");
				run("Next Slice [>]");
				percentCellArea[counter] = getResult("%Area", counter);
				print(f, d2s(ifile,0) +"  \t"+ d2s(percentCellArea[counter],5));
				counter = counter + 1;
			}
			File.close(f);
			run("Clear Results");
			close("cellNoCell");
		}
	}
	
	if(showNotPrint){
		print("---> Cell vs no-cell separation completed! \nOutput: 'analysis/p*/phs/bwImages/' \nCheck the images in the bwImages subfolder. \nMake sure that all locations that have cells and need to be anayzed are white! \nIf not, paint them white. \nAlso make sure that there are no white regions that are unconnected");
		showMessage("Cell vs no-cell separation completed! \nOutput: 'analysis/p*/phs/bwImages/' \nCheck the images in the bwImages subfolder. \nMake sure that all locations that have cells and need to be anayzed are white! \nIf not, paint them white. \nAlso make sure that there are no white regions that are unconnected");
	} else {
		print("---> Cell vs no-cell separation completed! \nOutput: 'analysis/p*/phs/bwImages/' \nCheck the images in the bwImages subfolder. \nMake sure that all locations that have cells and need to be anayzed are white! \nIf not, paint them white. \nAlso make sure that there are no white regions that are unconnected");
	}
}




function individualCellSegmentation(){

	run("Close All");

	// get the main folder that has data subfolders
	workDir = getDirectory("Choose the position directory");
	segDir = "segmentedImages/";
	bwDir = "bwImages/";
	resultsDir = "textResults/";
	individualInput = "individualInput.txt";
	clusterInput = "clusterInput.txt";
	cellPropMapsDir = "cellPropMaps/"; // within segDir
	overlapDir = "cellNoCellOverlap/"; // within bwDir
	userChoiceFile = "analysisChoices.txt";
	
	// get the list of subfodlers (names and number)
	nestedFolders =  endsWith_file_dir_list(workDir, "/");
	
	askFlag = File.exists(workDir+individualInput);
	if(askFlag==1){
		f = File.openAsString(workDir+individualInput);
		jjrows = split(f, "\n");
		Array.print(jjrows);
		delFileFlag = getBoolean("Reuse saved "+individualInput+" for the individual cell segmentation?");
		if(delFileFlag==false){
			removeExistingFile(workDir+individualInput);
		}
	}
	
	print("\\Clear");
	print("Indentifying the boundary of individual cells");

	inversionFlag = 0;
	folderIndices = getIncrementIndex("Folders", nestedFolders);
	startFolder = folderIndices[0];
	folderIncrement = folderIndices[1];
	endFolder = folderIndices[2];
	
	jFolder=startFolder;
	
	nestedFolder = nestedFolders[jFolder];
	print("Going for "+nestedFolder);
		
	files =  endsWith_file_dir_list(workDir+nestedFolder+resultsDir,"_areaStat.txt");
		
	ifile=0;
	
	//print(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
	micronsPerPix = getMicronsPerPixel(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
				
	//input = inputParameters_indiCelSeg(workDir, workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"), individualInput);
	input = inputParameters_indiCelSeg(workDir, workDir+nestedFolder, individualInput); // for updated open sequence 
	
	dirtSize = d2s(parseFloat(input[0]),0);
	acceptableCellSize = d2s(parseFloat(input[1]),0);
	circSize = input[2];
	segmentationRadius = input[3];
	blurSize = input[4];
	excludeEdgeCells = input[5];
	applyForceCutOff = input[6];
	prominence = 10;
	if(input.length>7){
		prominence = input[7];
	} else {
		print("Include in the 'individualInput.txt' eighth line as '4'");
	}
	
	if(is("Batch Mode")){
		setBatchMode(false);
	}
	
	run("Image Sequence...", "dir="+workDir+nestedFolder+" sort");
	rename("invCheck");
	run("Animation Options...", "speed=7 first=1 last="+d2s(nSlices,0));
	doCommand("Start Animation [\\]");
	inversionFlag = getBoolean("Which one is brighter?", "Cell center", "Cell-cell interface");
	close("invCheck");
	
	run("Close All");
	setBatchMode(true);				

	bcond = "allFour";
	for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){
	
		nestedFolder = nestedFolders[jFolder];
		print("Going for "+nestedFolder);

		a = File.exists(workDir+nestedFolder+segDir); // in case this folder was deleted by mistake
		if(a!=1){
			File.makeDirectory(workDir+nestedFolder+segDir);
			File.makeDirectory(workDir+nestedFolder+segDir+cellPropMapsDir);
		}
		
		files =  endsWith_file_dir_list(workDir+nestedFolder+resultsDir,"_areaStat.txt");

		if(applyForceCutOff==1){
			open(workDir+nestedFolder+replace(files[0],"_areaStat.txt",".tif"));
			rename("tmpIm");
			imXSz = getWidth();
			imYSz = getHeight();
			close("tmpIm");
	
			if(File.exists(workDir+"../"+userChoiceFile)==1){
				js = File.openAsString(workDir+"../"+userChoiceFile);
				jsl = split(js, "\n");
				bcond = jsl[4];
			} else if(File.exists(workDir+"../onlyBC_"+userChoiceFile)==1){
				ji = readInputFile(workDir+"../onlyBC_"+userChoiceFile, "string");
				bcond = ji[0];
			} else {
				
				setBatchMode(false);
				run("Image Sequence...", "dir="+workDir+nestedFolder+" sort");
				run("Animation Options...", "speed=7 first=1 last="+d2s(nSlices,0));
				doCommand("Start Animation [\\]");
				rename("jimg");
				
				Dialog.create("In the data, cells exist across these sides of the image:");
				js = newArray("- LEFT", "- RIGHT", "- TOP", "- BOTTOM");
				js1 = newArray(true, true, true, true);
				Dialog.addCheckboxGroup(1,4, js, js1);
				Dialog.show();
				leftFlag = Dialog.getCheckbox();
				rightFlag = Dialog.getCheckbox();
				topFlag = Dialog.getCheckbox();
				bottomFlag = Dialog.getCheckbox();
				if(leftFlag==1 && rightFlag==1 && topFlag==1 && bottomFlag==1){
					bcond = "allFour";
				} else if(leftFlag==0 && rightFlag==0 && topFlag==0 && bottomFlag==0){
					bcond = "none"; 
				} else if(leftFlag==0 && rightFlag==0 && topFlag==1 && bottomFlag==1){
					bcond = "allTwo";
				} else if(leftFlag==1 && rightFlag==1 && topFlag==0 && bottomFlag==0){
					exit("Rotate the images so that the strip is vertical");
				} else if(leftFlag==1 && rightFlag==0 && topFlag==1 && bottomFlag==1){
					bcond = "leftTopBottom";
				} else if(leftFlag==0 && rightFlag==1 && topFlag==1 && bottomFlag==1){
					exit("Rotate the images so that the free edge is to the right");
				} else if(leftFlag==1 && rightFlag==1 && topFlag==1 && bottomFlag==0){
					exit("Rotate the images so that the free edge is to the right");
				} else if(leftFlag==1 && rightFlag==1 && topFlag==0 && bottomFlag==1){
					exit("Rotate the images so that the free edge is to the right");
				} else if(leftFlag==1 && rightFlag==0 && topFlag==0 && bottomFlag==1){
					bcond = "leftTopBottom";
				} else if(leftFlag==1 && rightFlag==0 && topFlag==1 && bottomFlag==0){
					bcond = "leftTopBottom";
				} else if(leftFlag==0 && rightFlag==1 && topFlag==1 && bottomFlag==0){
					exit("Rotate the images so that the free edge is to the right");
				} else if(leftFlag==0 && rightFlag==1 && topFlag==0 && bottomFlag==1){
					exit("Rotate the images so that the free edge is to the right");
				}
				close("jimg");
				
				// write it
				f = File.open(workDir+"../onlyBC_"+userChoiceFile);
				print(f, bcond);
				File.close(f);
				setBatchMode(true);	
			}
	
			xminYminXmaxYmax = getCutOffRegion(imXSz, imYSz, bcond);
		}

		for(ifile=1; ifile<files.length; ifile++){
	
			print("File number "+d2s(ifile,0)+" of "+d2s(files.length,0));
			
			run("Close All");			

			if(!File.exists(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"))){
				open(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
				run("8-bit");
				if(blurSize!=0) run("Pseudo flat field correction", "blurring=50"); // March 07 2023
				selectWindow(replace(files[ifile],"_areaStat.txt",".tif"));
				if(inversionFlag==1) run("Invert");
				setVoxelSize(1, 1, 1, "pixel");
				run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
				if(blurSize!=0) run("Gaussian Blur...", "sigma="+d2s(blurSize,0)); // March 07 2023
				run("Invert");
				if(blurSize!=0) run("Bandpass Filter...", "filter_large=100 filter_small=0 suppress=None tolerance=5 autoscale saturate");  // March 07 2023
				run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
				rename("phase");
		
				// create maxima image
				
				open(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
				run("8-bit");
				if(blurSize!=0) run("Pseudo flat field correction", "blurring=50"); // March 07 2023
				selectWindow(replace(files[ifile],"_areaStat.txt",".tif"));
				if(inversionFlag==1) run("Invert");
				setVoxelSize(1, 1, 1, "pixel");
				run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
				if(blurSize!=0) run("Gaussian Blur...", "sigma="+d2s(blurSize,0)); // March 07 2023
				run("Invert");
				run("Maximum...", "radius="+d2s(segmentationRadius,0));
				rename("max");
				imageCalculator("Multiply create 32-bit", "phase","max");
				run("8-bit"); // segmentation does not produce smooth image for a 32-bit image
				close("max");
				close("phase");
				rename("phase");
				
				// get the mask and multiply the mask with 
				open(workDir+nestedFolder+bwDir+replace(files[ifile],"_areaStat.txt",".tif"));
				run("8-bit");
				setVoxelSize(1, 1, 1, "pixel");
				run("Invert"); // make cells black (255)
				if(blurSize!=0){
					run("EDM Binary Operations", "iterations=10 operation=dilate"); // March 07 2023
				} else {
					run("EDM Binary Operations", "iterations=2 operation=dilate"); // March 07 2023
				}
				if(blurSize!=0) {
					run("EDM Binary Operations", "iterations=10 operation=erode"); // March 07 2023
				} else {
					run("EDM Binary Operations", "iterations=2 operation=erode"); // March 07 2023
				}
				
				rename("mask");
				riimba(dirtSize, "mask");
				roomba(dirtSize, "mask", false, "");
				run("Invert");
				selectWindow("mask");
				run("Select All");
				run("Copy");
				selectWindow("phase");
				run("Add Slice");
				run("Paste");
				setAutoThreshold("Default"); //MaxEntropy");
				setThreshold(0, 0);
				run("Create Selection");
				sType = selectionType();
				if (sType==-1) {
				      print("No selection, likely due to no cell-free area in bwImages");
				} else {
					run("Previous Slice [<]");
					setForegroundColor(255, 255, 255);
					run("Fill", "slice");
				}
				run("Next Slice [>]");
				run("Delete Slice");
				
				if(applyForceCutOff==1){
					setForegroundColor(255, 255, 255);
					if(xminYminXmaxYmax[1]>0){
						makeRectangle(0, 0, imXSz, xminYminXmaxYmax[1]); // x. y. width. height
						run("Fill", "slice");
					}
					if(imXSz-xminYminXmaxYmax[2]>0){
						makeRectangle(xminYminXmaxYmax[2], 0, imXSz-xminYminXmaxYmax[2], imYSz); // x. y. width. height
						run("Fill", "slice");
					}
					if(imYSz-xminYminXmaxYmax[3]>0){
						makeRectangle(0, xminYminXmaxYmax[3], imXSz, imYSz-xminYminXmaxYmax[3]); // x. y. width. height
						run("Fill", "slice");
					}
					if(xminYminXmaxYmax[0]>0){
						makeRectangle(0, 0, xminYminXmaxYmax[0], imYSz); // x. y. width. height
						run("Fill", "slice");
					}
				}
				
				run("Find Maxima...", "prominence="+d2s(prominence,0)+" output=[Segmented Particles]");
								
				run("Invert");
				rename("segmented");
		
				imageCalculator("Multiply create", "mask","segmented");
				rename("segmentedIm");
				run("Multiply...", "value=255");
				run("Make Binary");
				run("Invert");
				roomba(dirtSize, "segmentedIm", false, "");
		
				run("Divide...", "value=255");
				
				open(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
				run("8-bit");
				if(blurSize!=0) run("Pseudo flat field correction", "blurring=50");  // March 07 2023
				selectWindow(replace(files[ifile],"_areaStat.txt",".tif"));
				setVoxelSize(1, 1, 1, "pixel");
				rename("origFile");
				imageCalculator("Multiply create", "origFile","segmentedIm");
				run("8-bit");
				saveAs("Tiff", workDir+nestedFolder+segDir+cellPropMapsDir+replace(files[ifile],"_areaStat.txt","_merged.tif"));
				close();		
				close("origFile");
				selectWindow("segmentedIm");
				run("Multiply...", "value=255");
				saveAs("Tiff", workDir+nestedFolder+segDir+cellPropMapsDir+replace(files[ifile],"_areaStat.txt",".tif"));
				rename("segmentedIm");
	
				run("Set Measurements...", "centroid area perimeter shape fit redirect=[segmentedIm] decimal=6");
				if(excludeEdgeCells==1){
					run("Analyze Particles...", "size=0-"+acceptableCellSize+" pixel circularity=0.00-Infinity show=[Overlay Masks] exclude"); // display exclude clear record add");
				} else {
					run("Analyze Particles...", "size=0-"+acceptableCellSize+" pixel circularity=0.00-Infinity show=[Overlay Masks]"); // display clear record add");
				}
				selectWindow("segmentedIm");
				// cell id are stored in metadata of this tiff image
				saveAs("Tiff", workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"));
				// collect properties in Results
				run("Clear Results");
				Overlay.measure;
				
				
				//close();
				

				// NOTE: cellID is not same for each frame, to know how things change for each cell do tracking
				
				// add exact Eucledian distance to the results (distance from the migration front)
				// open binary file
				open(workDir+nestedFolder+bwDir+replace(files[ifile],"_areaStat.txt",".tif"));
				run("8-bit");
				rename("bwdist");
				// make distance transform
				run("Exact Euclidean Distance Transform (3D)");
				for(i=0;i<getValue("results.count");i++){
					// read intensity of pixel at specific x and y
					dvalue = getPixel(getResult("X", i), getResult("Y", i));
					setResult("Distance",i,dvalue);
				}
				updateResults();
				close("bwdist");
				saveAs("Results", workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
				
				run("Close All");
			} else {
				print("--->  To recalculate, delete the file: "+workDir+nestedFolder+resultsDir+files[ifile]+"_*.csv, _*.tif, _statistics.*");
			}
		} //STOP
	}
	print("---> Individual cell detection completed! \nOutput: 'analysis/p*/phs/segmentedImages/' 'analysis/p*/phs/textResults/*.csv'");
	showMessage("Individual cell detection completed! \nOutput: 'analysis/p*/phs/segmentedImages/' 'analysis/p*/phs/textResults/*.csv'");
}






function recordPhaseValue(nbrFlag, inVar1, inVar2, inVar3, inVar4, inVar5){
	run("Close All");

	// get the main folder that has data subfolders
	if(!nbrFlag){
		workDir = getDirectory("Choose the position directory");
	} else {
		phsORfluo = inVar1;
		bandSize = inVar2;
		workDir = inVar3;
		outArray = newArray(d2s(inVar1,0), d2s(inVar2,0), inVar3, d2s(inVar4,0), d2s(inVar5,0));
	}

	segDir = "segmentedImages/";
	bwDir = "bwImages/";
	resultsDir = "textResults/";
	individualInput = "individualInput.txt";
	clusterInput = "clusterInput.txt";
	cellPropMapsDir = "cellPropMaps/"; // within segDir
	overlapDir = "cellNoCellOverlap/"; // within bwDir
	fluoDir = "fluo/";
	
	// get the list of subfodlers (names and number)
	nestedFolders =  endsWith_file_dir_list(workDir, "/");
	
	print("\\Clear");
	print("Recording phase values");
	
	folderIndices = getIncrementIndex("Folders", nestedFolders);
	startFolder = folderIndices[0];
	folderIncrement = folderIndices[1];
	endFolder = folderIndices[2];

	if(!nbrFlag){
		setBatchMode(false);
		Dialog.create("Purpose of recording cellular intensity");
		optns = newArray("detect cell division","quantify cellular fluorescence");
		Dialog.addRadioButtonGroup("", optns, 1, 2, optns[0]);
		Dialog.addNumber("Neighboring region size (pixel)", 60);
		Dialog.addCheckbox("- Collect properties of the cells", true);
		Dialog.addToSameRow();
		Dialog.addCheckbox("- Collect properties of the neighbors", true);
		Dialog.addMessage("- Detect cell division uses files from 'phs/' \n- Quantify cellular fluorescence uses files from 'fluo/'");
		Dialog.addMessage("- Choose three times the diameter (pixel) of the cell");
		Dialog.show();
		js = Dialog.getRadioButton();
		ji = Dialog.getNumber(); // bandwidth
		jc1 = Dialog.getCheckbox(); // cell props
		jc2 = Dialog.getCheckbox(); // nbr props
		setBatchMode(true);
		
		phsORfluo = 0;
		if(js==optns[1]){
			phsORfluo = 1;
		}
	
		outArray = newArray(d2s(phsORfluo,0), d2s(ji,0), workDir, d2s(jc1,0), d2s(jc2,0));
		
		if(File.exists(workDir+"../intensityChoice.txt")){
			File.delete(workDir+"../intensityChoice.txt");
		}
		f = File.open(workDir+"../intensityChoice.txt");
		//print(f, d2s(phsORfluo,0));
		print(f, outArray[0]);
		print(f, outArray[1]);
		print(f, outArray[2]);
		print(f, outArray[3]);
		print(f, outArray[4]);
		File.close(f);
	}
	
	if(parseInt(outArray[3])==1){
		for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){
	
			nestedFolder = nestedFolders[jFolder];
			print("Going for "+nestedFolder);

			files =  endsWith_file_dir_list(workDir+nestedFolder+resultsDir,"_areaStat.txt");

			if(files.length==0){
				exit("First complete cluster and individual segmentation");
				}
			
			if(nbrFlag){
				createBandROI(bandSize,workDir+nestedFolder+resultsDir,files,workDir+nestedFolder);
			}
			
			ifile = 0;
	
			// open phase images
			if(phsORfluo==0){//phs
				run("Image Sequence...", "dir="+workDir+nestedFolder+" filter=.tif sort");
			} else {
				run("Image Sequence...", "dir="+workDir+nestedFolder+fluoDir+" filter=.tif sort");
			}
			rename("phaseSeq");
			
			// open segmented image sequence
			for(ifile=1; ifile<files.length; ifile++){
				print("Going for file "+d2s(ifile,0));
	
				//if(!File.exists(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_roi.zip"))){
				if(!File.exists(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"))){
					exit("First complete the individual segmentation");
				} else {
					open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"));
					rename("tmpCellID");
					ncells = Overlay.size;
					Overlay.copy;
					selectWindow("phaseSeq");
					setSlice(ifile+1);
					Overlay.paste;
					close("tmpCellID");
				}

				ncells = Overlay.size;
				
				run("Set Measurements...", "mean standard modal min median redirect=phaseSeq decimal=6");
				inputS = newArray("Mean", "Mode", "Median", "StdDev", "Min", "Max");
				nNewCols = inputS.length;
	
				run("Clear Results");
				selectWindow("phaseSeq");
				setSlice(ifile+1);
				Overlay.measure;
	
				// reusing xyCoords variable
				xyCoords = newArray(ncells*nNewCols);
				// read the results into a variable
				for(icell=0;icell<ncells;icell++){
					for(icol=0;icol<nNewCols;icol++){
						xyCoords[icell+icol*ncells] = getResult(inputS[icol],icell);
					}
				}
		
				// open stored result
				run("Clear Results");
				open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
				nonImWins = getList("window.titles"); // list = getList("image.titles");
				jniwLoops = nonImWins.length;
				for(jniw = 0; jniw<jniwLoops; jniw++){
					if(nonImWins[jniw]==replace(files[ifile],"_areaStat.txt",".csv")){
						Table.rename(replace(files[ifile],"_areaStat.txt",".csv"),"Results");
						jniwLoops = 0;
					}
				}
				
				// insert column
				if(!nbrFlag){
					for(icell=0;icell<ncells;icell++){
						for(icol=0;icol<nNewCols;icol++){
							setResult(inputS[icol], icell, xyCoords[icell+icol*ncells]);
						}
					}
				} else {
					for(icell=0;icell<ncells;icell++){
						for(icol=0;icol<nNewCols;icol++){
							setResult("NBR"+inputS[icol], icell, xyCoords[icell+icol*ncells]);
						}
					}
				}
				updateResults();
				
				removeExistingFile(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
				// resave
				saveAs("Results", workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
				// clear results
				run("Clear Results");
				
			}
			// close("segmentedSeq");
			close("phaseSeq");
		}
	}
	
	if(nbrFlag==true){
		print("---> Recording phase value for CELLS/NBRs completed!");	
		showMessage("Recording phase value for CELLS/NBRs completed!");
	} else if(parseInt(outArray[4])==0){
		print("---> Recording phase value for CELLS completed!");	
		showMessage("Recording phase value for CELLS completed!");
	}
	return outArray;
}



displayCellPropMaps();


function displayCellPropMaps(){
	run("Close All");

	// get the main folder that has data subfolders
	workDir = getDirectory("Choose the position directory");
	segDir = "segmentedImages/";
	bwDir = "bwImages/";
	resultsDir = "textResults/";
	individualInput = "individualInput.txt";
	clusterInput = "clusterInput.txt";
	cellPropMapsDir = "cellPropMaps/"; // within segDir
	overlapDir = "cellNoCellOverlap/"; // within bwDir
	
	// get the list of subfodlers (names and number)
	nestedFolders =  endsWith_file_dir_list(workDir, "/");
	// get the list of files in each subfolder

	print("\\Clear");
	print("Creating segmentation maps");

	folderIndices = getIncrementIndex("Folders", nestedFolders);
	startFolder = folderIndices[0];
	folderIncrement = folderIndices[1];
	endFolder = folderIndices[2];
	inputS = "";


	// create RGB array
	ncolorPts = 256;
	rgbmat = make_RGB_matrix(ncolorPts);
	r=newArray(ncolorPts);g=newArray(ncolorPts);b=newArray(ncolorPts);
	for (j=0; j<ncolorPts ;j++) 
	{
		r[j]=rgbmat[j];
		g[j]=rgbmat[j+ncolorPts];
		b[j]=rgbmat[j+ncolorPts*2];
	}


	firstTime = 0;
	// go through each folder to plot each variable for each file
	for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){
	
		nestedFolder = nestedFolders[jFolder];
		print("Going for "+nestedFolder);
		
		files =  endsWith_file_dir_list(workDir+nestedFolder+resultsDir,"_areaStat.txt");

		setBatchMode(false);
		run("Image Sequence...", "dir="+workDir+nestedFolder+segDir+cellPropMapsDir+" filter=_merged.tif sort");
		rename("merSeq");
		Dialog.createNonBlocking("Choose starting point for making pictures");
		labls = newArray(nSlices);
		for(i=0;i<nSlices;i++){
			setSlice(i+1);
			labls[i] = getInfo("slice.label");
		}
		Dialog.addChoice("Frame number:", labls, labls[1]);
		Dialog.addMessage("Go through the images and choose the 'earliest' frame that can be treated as reference to be tracked across all frames");
		Dialog.addMessage("Tracking will be done from this point onwards");
		Dialog.addMessage("For AcTrM data, with velocity information: choose 0002.tif or later frame");
		Dialog.addMessage("For AcTrM data, without velocity information: choose 0001.tif or later frame");
		Dialog.setLocation(0,0);
		js = Dialog.show();
		js = Dialog.getChoice();
		setBatchMode(true);
		ji = nSlices;
		for(i=0;i<ji;i++){
			setSlice(i+1);
			if(js==getInfo("slice.label")){
				ji = 0;
				refIFILE=i;
			}
		}
		close("merSeq");

		if(firstTime==0){
			firstTime = 1;
			ifile = refIFILE;
			open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
			
			nonImWins = getList("window.titles"); // list = getList("image.titles");
			jniwLoops = nonImWins.length;
			for(jniw = 0; jniw<jniwLoops; jniw++){
				if(nonImWins[jniw]==replace(files[ifile],"_areaStat.txt",".csv")){
					Table.rename(replace(files[ifile],"_areaStat.txt",".csv"),"Results");
					jniwLoops = 0;
				}
			}
			
			colLabel = split(String.getResultsHeadings);
			ncolumns = colLabel.length;

		 	micronsPerPix = getMicronsPerPixel(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));

			//input = inputParameters_indiCelSeg(workDir, workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"), individualInput);
			input = inputParameters_indiCelSeg(workDir, workDir+nestedFolder, individualInput);
			maxCellSize = d2s(parseFloat(input[1]),0);

			inputS = inputParameters_trackCellProps(colLabel, "maps");
			//yesNo = getBoolean("Do you want images to visualize the no-cell area?", "yes", "No");
			yesNo = 1;
			if(yesNo==1){
				// showOverlap
				for(jjFolder=startFolder; jjFolder<endFolder; jjFolder=jjFolder+folderIncrement){
					jnestedFolder = nestedFolders[jjFolder];
					run("Image Sequence...", "dir="+workDir+jnestedFolder+bwDir+" sort");
					rename("bwSeq");
					run("Image Sequence...", "dir="+workDir+jnestedFolder+" sort");
					rename("phsSeq");
					removeUniqueSlices("bwSeq", "phsSeq");
		
					selectWindow("bwSeq");
					run("Duplicate...", " ");
					rename("bwSeq1");
		
					run("Find Edges", "stack");
					run("Invert", "stack");
					run("Divide...", "value=255.0 stack");
					
					selectWindow("bwSeq");
					run("Invert", "stack");
					run("Distance Map", "stack");
					run("Invert", "stack");
					run("32-bit");
					run("8-bit");
					
					imageCalculator("Multiply stack", "bwSeq","bwSeq1");
					close("bwSeq1");
					run("32-bit");
					run("Divide...", "value=255.0 stack");
					
					run("32-bit");
					selectWindow("phsSeq");
					imageCalculator("Multiply create 32-bit", "bwSeq","phsSeq");
					rename("saveSeq");
					run("8-bit");
					close("bwSeq");
					close("phsSeq");
					
					run("Image Sequence... ", "format=TIFF name=[] save="+workDir+jnestedFolder+bwDir+overlapDir);
					run("Close All");
				}
			}
		}

		// make a scalebar for the colors
		scalebarWidth = 20;
		scalebarHeight = 256;
		dh = (scalebarHeight-1)/255;
		newImage("scalebar", "RGB", scalebarWidth, scalebarHeight, 1);
		for (j=0; j<256 ;j++)
		{
			makeRectangle(0, j, scalebarWidth, dh);
			setForegroundColor(r[255-j], g[255-j], b[255-j]);
			run("Fill", "slice");
		}
		saveAs("Tiff", workDir+nestedFolder+segDir+cellPropMapsDir+replace(files[ifile],"_areaStat.txt","_genericScaleBar.tif"));
		run("Close All");

		print("Making plots of following variables");
		Array.print(inputS);

		for(ifile=refIFILE;ifile<files.length;ifile++){
			print("Going for file "+workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));

			// read all variables for that file
			run("Clear Results");				
			open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
			nonImWins = getList("window.titles"); // list = getList("image.titles");
			jniwLoops = nonImWins.length;
			for(jniw = 0; jniw<jniwLoops; jniw++){
				if(nonImWins[jniw]==replace(files[ifile],"_areaStat.txt",".csv")){
					Table.rename(replace(files[ifile],"_areaStat.txt",".csv"),"Results");
					jniwLoops = 0;
				}
			}
			ncells = getValue("results.count");
			plotVars = newArray(ncells*inputS.length);
			for(icell=0;icell<ncells;icell++){
				for(ivar=0;ivar<inputS.length;ivar++){
					plotVars[icell+ivar*ncells] = getResult(inputS[ivar], icell);
				}
			}

			// saveStats
			if(ifile==refIFILE){
				saveStats(plotVars, inputS, ncells, 1);
				varStats = getVarStats(plotVars, inputS, ncells); // for plotting
			} else {
				saveStats(plotVars, inputS, ncells, 0);
			}

			run("Close All");
			
			// open phase image make sequence equal to the number of variables
			open(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
			run("Pseudo flat field correction", "blurring=50");
			selectWindow(replace(files[ifile],"_areaStat.txt",".tif"));
			rename(inputS[0]);
			run("RGB Color");
			for(ivar=1;ivar<inputS.length;ivar++){
				selectWindow(inputS[0]);
				run("Duplicate...", " ");
				rename(inputS[ivar]);
			}
			
			// convert seq to image
			selectWindow(inputS[0]);
			run("Duplicate...", " ");
			rename("phsOrig");

			// get the range for plotting 

			// get the rois
			open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"));
			rename("cellIDIm");

			// loop through variables to make map of each variable on each phase image
			for(ivar=0;ivar<inputS.length;ivar++){
				selectWindow("cellIDIm");
				Overlay.copy;
				selectWindow(inputS[ivar]);
				Overlay.paste;
				
				minVal = varStats[ivar*4];
				maxVal = varStats[ivar*4+1];


				for(icell=0;icell<ncells;icell++){

					prop = plotVars[icell+ivar*ncells]; // Array.slice(plotVars, ivar*ncells, ivar*ncells+ncells);
					
					aval = round(((prop - minVal)/(maxVal - minVal))*255);
					if(aval>255){
						aval = 255; // max limit is 255
					} else if(aval<0){
						aval = 0; // min limit is 0
					}
					
					// approach 1
					setForegroundColor(r[aval], g[aval], b[aval]);
					Overlay.activateSelection(icell);
					run("Fill", "slice");
				}

				Overlay.remove;
				imageCalculator("Add", inputS[ivar],"phsOrig");
				saveAs("Tiff", workDir+nestedFolder+segDir+cellPropMapsDir+replace(files[ifile],"_areaStat.txt","_"+inputS[ivar]+".tif"));
				close(inputS[ivar]);
			}
			close("cellIDIm");

			run("Close All");
		}
	}
	print("---> Result files are saved! \nOutput: 'analysis/p*/phs/segmentedImages/cellPropMaps/*.tif'");
	showMessage("Result files are saved! \nOutput: 'analysis/p*/phs/segmentedImages/cellPropMaps/*.tif'");
}








function addColsFromGridData_all(nbrFlag, inVar1, inVar2, inVar3, inVar4, inVar5, inVar6, inVar7, inVar8){
	run("Close All");
	
	// get the main folder that has data subfolders
	if(!nbrFlag){
		workDir = getDirectory("Choose the position directory");
	} else {
		workDir = inVar4;
	}
	segDir = "segmentedImages/";
	bwDir = "bwImages/";
	resultsDir = "textResults/";
	individualInput = "individualInput.txt";
	gridVarInput = "gridVarInput.txt";
	clusterInput = "clusterInput.txt";
	cellPropMapsDir = "cellPropMaps/"; // within segDir
	overlapDir = "cellNoCellOverlap/"; // within bwDir
	dataImages = "dataImages/"; // folder where imaages obtained from he data are saved
	stressDir = "prestress/";
	velDir = "velocity/";
	tractionDir = "traction/";
	
	// get the list of subfodlers (names and number)
	nestedFolders =  endsWith_file_dir_list(workDir, "/");
	// get the list of files in each subfolder

	print("\\Clear");
	print("Adding columns to the result file from grid data");

	folderIndices = getIncrementIndex("Folders", nestedFolders);
	startFolder = folderIndices[0];
	folderIncrement = folderIndices[1];
	endFolder = folderIndices[2];


	if(!nbrFlag){
		setBatchMode(false);
		// give options to choose standard 
		Dialog.create("Choose from following standard mapping options");
		Dialog.addCheckbox("- Map force data, ", true);
		Dialog.addToSameRow();
		Dialog.addCheckbox("- Create images of force data", true);
		Dialog.addCheckbox("- Map velocity data, ", false);
		Dialog.addToSameRow();
		Dialog.addCheckbox("- Create images of velocity data", false);
		Dialog.addNumber("Neighboring region size (pixel)", 60);
		Dialog.addCheckbox("- Collect properties of the cells", true);
		Dialog.addToSameRow();
		Dialog.addCheckbox("- Collect properties of the neighbors", true);
		Dialog.addMessage("- Detect cell division uses files from 'phs/' \n- Quantify cellular fluorescence uses files from 'fluo/'");
		Dialog.addMessage("- Choose three times the diameter (pixel) of the cell");
		Dialog.show();
		forceFlag = Dialog.getCheckbox();
		fText2IM = Dialog.getCheckbox();
		velFlag = Dialog.getCheckbox();
		vText2IM = Dialog.getCheckbox();
		
		ji = Dialog.getNumber(); // neighboring region size
		jc1 = Dialog.getCheckbox(); // collect cell data
		jc2 = Dialog.getCheckbox(); // collect neighbor data
		
		outArray = newArray(d2s(forceFlag,0), d2s(velFlag,0), d2s(ji,0), workDir, d2s(jc1,0), d2s(jc2,0), d2s(fText2IM,0), d2s(vText2IM,0));
	
		// FUTURE:  Convert this into reuse forceVelocityChoices.txt
		if(File.exists(workDir+"../forceVelocityChoice.txt")){
			File.delete(workDir+"../forceVelocityChoice.txt");
		}
		f = File.open(workDir+"../forceVelocityChoice.txt");
		print(f, outArray[0]);
		print(f, outArray[1]);
		print(f, outArray[2]);
		print(f, outArray[3]);
		print(f, outArray[4]);
		print(f, outArray[5]);
		print(f, outArray[6]);
		print(f, outArray[7]);
		File.close(f);
		setBatchMode(true);
	} else {
		forceFlag = inVar1;
		velFlag = inVar2;
		bandSize = inVar3;
		fText2IM = inVar7;
		vText2IM = inVar8;
		
		outArray = newArray(d2s(inVar1,0), d2s(inVar2,0), d2s(inVar3,0), inVar4, d2s(inVar5,0), d2s(inVar6,0), d2s(inVar7,0), d2s(inVar8,0));
	}

	ngops = 0;
	if(forceFlag==1){
		ngops = ngops + 1;
	}
	if(velFlag==1){
		ngops = ngops + 1;
	}

	if((parseInt(outArray[4])==1)||(parseInt(outArray[6])==1)||(parseInt(outArray[7])==1)){ // if collect cell data is true
		for(jg=0; jg<ngops; jg++){
			firstFrame = 0;
			for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){

				nestedFolder = nestedFolders[jFolder];
				print("Going for "+nestedFolder);
				
				files =  endsWith_file_dir_list(workDir+nestedFolder+resultsDir,"_areaStat.txt");
				
				files = Array.trim(files,files.length); // will cut the files to all but last file to accommodate for velocity files


				if(nbrFlag){
					createBandROI(bandSize,workDir+nestedFolder+resultsDir,files,workDir+nestedFolder);
				}
				
				nVars = 0;
				saveImgs = 0;
				for(ifile=1; ifile<files.length; ifile++){
		
					if(ifile==1){
						// get the size of phase image
						open(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
						selectWindow(replace(files[ifile],"_areaStat.txt",".tif"));
						imW = getWidth();
						imH = getHeight();
						nslices = 1;
						close();
					}

					if(firstFrame==0){
						firstFrame = 1;
						micronsPerPix = getMicronsPerPixel(workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"));
						
						//input = inputParameters_indiCelSeg(workDir, workDir+nestedFolder+replace(files[ifile],"_areaStat.txt",".tif"), individualInput);
						input = inputParameters_indiCelSeg(workDir, workDir+nestedFolder, individualInput);
						
						smallestCellSize = d2s(parseFloat(input[0]),0);
						largestCellSize = d2s(parseFloat(input[1]),0);
						print("dirtsize = "+smallestCellSize);
						print("acceptableCellSize = "+largestCellSize);
								
		
						writeForceFile = 0;
						if(velFlag==1 && forceFlag==1){
							if(jg==1){ // map forces
								writeForceFile = 1;
							}
						} else if(forceFlag==1){ // map forces
							writeForceFile = 1;
						}
						if(writeForceFile==1){ // do stress mapping
							// if the gridinput file exists delete it
							gridFlLoc = workDir+gridVarInput;
							if(File.exists(gridFlLoc)){
								File.delete(gridFlLoc);
							}

							ji = get_nxnyPts(workDir+tractionDir, "_trac.dat");
							gridSz = ji[2];
							
							// create new gridinput file and save it
							f = File.open(gridFlLoc);
							print(f, workDir+stressDir);
							print(f, "0001_allForces.dat");
							print(f, d2s(gridSz,0));
							print(f, "0 1 11 12 13 14 15 ");
							print(f, "Xg Yg se tmag avgten maxShr theta ");
							print(f, "0");
							print(f, d2s(fText2IM,0));
							print(f, "FEA");
							print(f, "sqrt(a^2+b^2) (a+b)/2 |(a-b)/2| arctan(b/a)");
							print(f, "2 7 7 9");
							print(f, "3 8 8 10");
							File.close(f);							
							
						} else { // do velocity mapping												
							// if the gridinput file exists delete it
							gridFlLoc = workDir+gridVarInput;
							if(File.exists(gridFlLoc)){
								File.delete(gridFlLoc);
							}

							// create new gridinput file and save it
							f = File.open(gridFlLoc);
							print(f, workDir+velDir);
							print(f, "0002_vel.dat");
							print(f, "NaN");  // NaN as it is not used here after
							print(f, "0 1 4 16 ");
							print(f, "Xg Yg speed velAngle ");
							print(f, "0");
							print(f, d2s(vText2IM,0));
							print(f, "PIV");
							print(f, "arctan(b/a)");
							print(f, "2");
							print(f, "3");
							File.close(f);							
							
						}
						
						jb=true;
						if(jb==true){
							jinputS = readGridVar(workDir,gridVarInput);
		
							// jinputS[0] = directory
							// jinputS[1] = filename
							// jinputS[2] = gridSize 
							// jinputS[3] = linked list of which headers are to be used
							// jinputS[4] = labels for those headers
							// jinputS[5] = save the images immediately ... this will make the process slow, it can be done with saving of all the celled images there it will be done with colors, so no need to do it here
							// jinputS[6] = flag to do the conversion of text to image
							// inputS[7] = gridType "FEA" "PIV"
							// jinputS[8] = formulae, 
							// jinputS[9] = varA, 
							// jinputS[10] = varB

							// gridSz = jinputS[2]; // NaN as it is not used here after
		
							gridType = jinputS[7];
							js = jinputS[0];
							jinputS[0] = replace(js," ","");
							saveImgs = parseInt(jinputS[5]);
							text2ImgFlag = parseInt(jinputS[6]);
							js = split(jinputS[1],"_");
							// js[0] = same name as the phase tif image
							// js[end] = unique identifier to the data file reuse that part
							ji = js.length;
							fileNameRepString = "_"+js[ji-1];
							fileNameRepString = replace(fileNameRepString," ","");
		
		
							js = split(jinputS[3], " ");
							nVars = js.length;
							colNums = newArray(nVars);
							for(i=0;i<nVars;i++){
								colNums[i] = parseInt(js[i]);
							}
			
							varNames = split(jinputS[4], " ");
		
							inputS = jinputS;
							Array.trim(inputS,9); // to match perfectly with else part
		
							if(jinputS.length>8){
								formulae = split(jinputS[8], " ");
								varA = split(jinputS[9], " ");
								varB = split(jinputS[10], " ");
							} else {
								formulae = newArray(0);
								varA = newArray(0);
								varB = newArray(0);
							}
						}
					}

					print("File number "+d2s(ifile,0));
					
					run("Close All");
					if(text2ImgFlag==1){
						j1s = inputS[0]+replace(files[ifile],"_areaStat.txt",fileNameRepString);
						if(File.exists(j1s)){
							if(gridType=="FEA"){
								nonGridData2ImgFile(j1s, fileNameRepString, varNames, colNums, formulae, varA, varB, imW, imH);
							} else if(gridType=="PIV") {
								gridData2ImgFile(j1s, fileNameRepString, varNames, colNums, formulae, varA, varB, imW, imH);
							}
						} else {
							print("File "+j1s+" exists!");
						}
					}
				}
		
		
				// move all tiff images to dataImages folder
				js = File.makeDirectory(inputS[0]+dataImages);
				for(ifile=1;ifile<files.length;ifile++){
					for(ivar=0;ivar<varNames.length;ivar++){
						js = inputS[0];
						js1 = replace(files[ifile],"_areaStat.txt","_"+varNames[ivar]+".tif");
						js2 = File.rename(js+js1,js+dataImages+js1);
					}
				}
		
				for(ifile=1; ifile<files.length; ifile++){
					if(File.exists(inputS[0]+dataImages+replace(files[ifile],"_areaStat.txt","_"+varNames[0]+".tif"))){
						if(File.exists(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"))){
							print("Going for sequence "+inputS[0]+dataImages+replace(files[ifile],"_areaStat.txt","*"));
							
							// open all images for ifile
							run("Image Sequence...", "dir="+inputS[0]+dataImages+" filter="+replace(files[ifile],"_areaStat.txt","")+" sort");
							rename("newVarSeq");

							numOfSlices = nSlices();

							if(nbrFlag){
								open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_BANDcellID.tif"));
								print(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_BANDcellID.tif"));
							} else {
								open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"));
								print(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"));
							}
							rename("cellIDIm");
							ncells = Overlay.size;
							print("ncells="+d2s(ncells,0));
							for(islice=1;islice<numOfSlices+1;islice++){
								selectWindow("cellIDIm");
								Overlay.copy;
								selectWindow("newVarSeq");
								setSlice(islice);
								Overlay.paste;
							}
							close("cellIDIm");

							run("Set Measurements...", "mean standard median redirect=newVarSeq decimal=6");
							varProps = newArray("Mean", "Median", "StdDev");
							nvarProps = varProps.length;

							run("Clear Results");
							selectWindow("newVarSeq");
							
							// to save results for each requested property along column
							// first N rows belong to N cells in first frame
							// next N rows belong to same N cells in the second frame
							// next N rows belong to same N cells in the third frame
							//print("nResults="+d2s(nResults,0)+", nSlices"+d2s(numOfSlices,0)+", ncells="+d2s(ncells,0));
							
							meanArr = newArray(ncells*numOfSlices);
							medianArr = newArray(ncells*numOfSlices);
							stddevArr = newArray(ncells*numOfSlices);
							for(islice=0;islice<numOfSlices;islice++){
								setSlice(islice+1);
								run("Clear Results");
								Overlay.measure;
	
								for(icell=0; icell<nResults; icell++) { // nResults = ncells
									meanArr[icell+ncells*islice] = getResult("Mean", icell);
									medianArr[icell+ncells*islice] = getResult("Median", icell);
									stddevArr[icell+ncells*islice] = getResult("StdDev", icell);
								}
								selectWindow("Results"); 
								run("Close");
							}

							// open stored result
							open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
							winTtleLst = getList("window.titles");
                        	lstLen = winTtleLst.length;
                        	for(wi=0;wi<lstLen;wi++){
								if(winTtleLst[wi]==replace(files[ifile],"_areaStat.txt",".csv")){
									Table.rename(replace(files[ifile],"_areaStat.txt",".csv"), "Results");
                                	lstLen=0;
	                        	} else if (winTtleLst[wi]=="Results"){
	                        		lstLen=0;
                        		}
							}

							if(lstLen!=0){
								exit("There is no 'Results' Window");
							}

							for(islice=0; islice<numOfSlices; islice++){
								selectWindow("newVarSeq");
								setSlice(islice+1);
								varLabel = replace(replace(getMetadata("Label"),replace(files[ifile],"_areaStat.txt","")+"_",""),".tif","");
								//print("varLabel="+varLabel);
								
								// insert column
								for(icell=0;icell<ncells;icell++){
									if(nbrFlag){
										setResult("NBR"+varLabel+"Mean", icell, meanArr[icell+ncells*islice]);
										setResult("NBR"+varLabel+"Median", icell, medianArr[icell+ncells*islice]);
										setResult("NBR"+varLabel+"StdDev", icell, stddevArr[icell+ncells*islice]);										
									} else {
										setResult(varLabel+"Mean", icell, meanArr[icell+ncells*islice]);
										setResult(varLabel+"Median", icell, medianArr[icell+ncells*islice]);
										setResult(varLabel+"StdDev", icell, stddevArr[icell+ncells*islice]);
									}
									
								}
								updateResults();
							}
							removeExistingFile(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
							// resave
							saveAs("Results", workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
														
							selectWindow("newVarSeq");
							close("newVarSeq");
						} else {
							print("File "+workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif")+" is absent");
							print("Perform cluster and individual segmentation");
						}
					} else {
						print("File "+inputS[0]+dataImages+replace(files[ifile],"_areaStat.txt","_"+varNames[0]+".tif")+" is absent");
					}
				}
			}
		}
	}
	run("Close All");

	//Array.print(outArray);
	if(nbrFlag){
		print("---> Columns added CELL/NBR data to the result file! \nOutput: 'analysis/p*/phs/*.csv' 'analysis/p*/prestress/dataImages/' 'analysis/p*/velocity/dataImages/'");
		showMessage("Columns added CELL/NBR data to the result file! \nOutput: 'analysis/p*/phs/*.csv' 'analysis/p*/prestress/dataImages/' 'analysis/p*/velocity/dataImages/'");
	} else if (parseInt(outArray[5])==0) {
		print("---> Columns added CELL data to the result file! \nOutput: 'analysis/p*/phs/*.csv' 'analysis/p*/prestress/dataImages/' 'analysis/p*/velocity/dataImages/'");
		showMessage("Columns added CELL data to the result file! \nOutput: 'analysis/p*/phs/*.csv' 'analysis/p*/prestress/dataImages/' 'analysis/p*/velocity/dataImages/'");
	}
	//}
	return outArray;
}







// REFroi = files used to track the cells
// properties of the cell and their neighboring region are already obtained before the tracks are made
// once tracked properties of the cells or their neighboring region can be plotted as desired
function trackingCellularProperties(){
	run("Close All");
	
	// get the main folder that has data subfolders
	workDir = getDirectory("Choose the position directory");
	segDir = "segmentedImages/";
	bwDir = "bwImages/";
	resultsDir = "textResults/";
	individualInput = "individualInput.txt";
	clusterInput = "clusterInput.txt";
	cellPropMapsDir = "cellPropMaps/"; // within segDir
	overlapDir = "cellNoCellOverlap/"; // within bwDir
	userChoiceFile = "analysisChoices.txt";

	// get the list of subfodlers (names and number)
	nestedFolders =  endsWith_file_dir_list(workDir, "/");
		
	print("\\Clear");

	folderIndices = getIncrementIndex("Folders", nestedFolders);
	startFolder = folderIndices[0];
	folderIncrement = folderIndices[1];
	endFolder = folderIndices[2];


	firstFrame = 0; 
	for(jFolder=startFolder; jFolder<endFolder; jFolder=jFolder+folderIncrement){

		nestedFolder = nestedFolders[jFolder];
		print("Going for "+nestedFolder);
		
		files =  endsWith_file_dir_list(workDir+nestedFolder+resultsDir,"_areaStat.txt");
		if(files.length==0){exit("First complete cluster and individual segmentation");}

		files = Array.trim(files,files.length); // will cut the files to all but last file to accommodate for velocity files

		setBatchMode(false);
		// start-----------------------------------------------------
		run("Image Sequence...", "dir="+workDir+nestedFolder+segDir+cellPropMapsDir+" filter=_merged.tif sort");
		rename("merSeq");
		Dialog.createNonBlocking("Choose starting point for tracking");
		labls = newArray(nSlices);
		for(i=0;i<nSlices;i++){
			setSlice(i+1);
			labls[i] = getInfo("slice.label");
		}
		Dialog.addChoice("Frame number:", labls, labls[1]);
		Dialog.addNumber("Maximum number of plots to fill simultaneously (use lower number to avoid memory error):", 200);
		//Dialog.addCheckbox("- Create image of the xy-track of the cell (no need if using single segmentation file)", false);
		Dialog.addMessage("Go through the images and choose the 'earliest' frame that can be treated as reference to be tracked across all frames");
		Dialog.addMessage("Tracking will be done from this point onwards");
		Dialog.addMessage("For AcTrM data, with velocity information: choose 0002.tif or later frame");
		Dialog.addMessage("For AcTrM data, without velocity information: choose 0001.tif or later frame");
		Dialog.setLocation(0,0);
		js = Dialog.show();
		js = Dialog.getChoice();
		nMaxFrames = Dialog.getNumber();
		//makeTracksFlag = Dialog.getCheckbox();
		close("merSeq");
		js1 = split(js,"_");
		refIFILE = parseInt(js1[0]);
		
		setBatchMode(true);

		if(firstFrame==0){
			firstFrame = 1;
			run("Clear Results");
			if(!File.exists(workDir+nestedFolder+resultsDir+replace(files[refIFILE],"_areaStat.txt",".csv"))){
				exit("First complete individual segmentation");
			}
			open(workDir+nestedFolder+resultsDir+replace(files[refIFILE],"_areaStat.txt",".csv"));
			winTtleLst = getList("window.titles");
			lstLen = winTtleLst.length;
			for(wi=0;wi<lstLen;wi++){
				if(winTtleLst[wi]==replace(files[refIFILE],"_areaStat.txt",".csv")){
					Table.rename(replace(files[refIFILE],"_areaStat.txt",".csv"), "Results");
					lstLen=0;
				}
			}
			
			colLabel = split(String.getResultsHeadings);
			ncolumns = colLabel.length;
			micronsPerPix = getMicronsPerPixel(workDir+nestedFolder+replace(files[refIFILE],"_areaStat.txt",".tif"));
			print("Microns per pix="+d2s(micronsPerPix,12));
			Array.print(colLabel);
			inputS = newArray("Area"); //,"X","Y");
		}

		open(workDir+nestedFolder+replace(files[refIFILE],"_areaStat.txt",".tif"));

		selectWindow(replace(files[refIFILE],"_areaStat.txt",".tif"));
		imW = getWidth();
		imH = getHeight();
		close(replace(files[refIFILE],"_areaStat.txt",".tif"));

		refROIfile = workDir+nestedFolder+resultsDir+replace(files[refIFILE],"_areaStat.txt","_cellID.tif");
		refROIfile_matching = workDir+nestedFolder+resultsDir+replace(files[refIFILE],"_areaStat.txt","_REFcellID.tif");

		open(refROIfile);
		rename("jthisFile");
		ncells0 = Overlay.size;
		if(ncells0==0) exit("Number of cells is zero!");
		
		// prepare REFcellID.tif image for the first frame
		jids = newArray(ncells0);
		unbrokenTracks = newArray(ncells0); // array that indicates whether that cell has an unbroken track
		for(icell=0;icell<ncells0;icell++){
			jids[icell] = icell+1; // cell IDs start with 1, a 0 ID means the cell is not tracked
			unbrokenTracks[icell] = 1; // is tracked initialized
		}
		jthatFile = createCellIDImage("jthisFile",jids);
		close("jthisFile");
		selectWindow(jthatFile);
		saveAs("Tiff", refROIfile_matching);
		close(jthatFile);

		trackVars = start_cellTracking(workDir, nestedFolder, resultsDir, inputS, refIFILE, files.length, ncells0, replace(files[refIFILE],"_areaStat.txt",".csv"));		

		// -----------------------------------------------------end


		for(ifile=refIFILE+1; ifile<files.length; ifile++){

			run("Close All");
			if(File.exists(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"))){
				print("Going for file "+replace(files[ifile],"_areaStat.txt",".csv"));
				
				print("Getting updated ROI list");

				//run("Clear Results");
	
				Table.open(workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt",".csv"));
				tableName = Table.title;
				cnResults = Table.size; // resultCount
				//tHeadings = split(Table.headings,"\t");
				tImageTitle = "tImage1";
				makeTImage(tableName,tImageTitle);
				
				refROIfile = workDir+nestedFolder+resultsDir+replace(files[ifile-1],"_areaStat.txt","_REFcellID.tif"); // last traced cell location
				currROIfile = workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_cellID.tif"); // current cell location
				outFileName1 = workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_REFcellID.tif"); // filename for traced id for current cell location
				tracedID_1st = traceOriginalIDs(refROIfile, currROIfile, ncells0, outFileName1);
				
				
				// update trackVars
				untrackedCount = 0;
				for(icell=0;icell<ncells0;icell++){
					if(tracedID_1st[icell]!=0){ // has been tracked
						for(ivar=0;ivar<inputS.length;ivar++){
							sourceID = tracedID_1st[icell]-1; // array ID start at 0 but Overlays start at 1
							if(sourceID>=cnResults){
								print("sourceID="+d2s(sourceID,0)+", cellID="+d2s(icell,0)+", nResults="+d2s(cnResults,0)+", ncells0="+d2s(ncells0,0));
								exit("sourceID was larger than ncResults!");
							} else {
								//print(ivar,sourceID);
								//print(inputS[ivar]);
								selectWindow(tImageTitle);
								trackVars[icell+ivar*ncells0+ifile*ncells0*inputS.length] = sourceID+1;  // location of the data on csv file
							}
						}
					} else { // could not be tracked
						unbrokenTracks[icell] = 0;
						untrackedCount = untrackedCount+1;
						for(ivar=0;ivar<inputS.length;ivar++){
							trackVars[icell+ivar*ncells0+ifile*ncells0*inputS.length] = NaN; // proeprties of untracked cells is kept zero
						}
					}
				}
				print("number of cells that could not track="+d2s(untrackedCount,0));
			}
		}

		// save tracked cell properties
		for(ivar=0;ivar<inputS.length;ivar++){
			Table.create("Results");
			for(icell=0;icell<ncells0;icell++){
				for(ifile=0; ifile<files.length; ifile++){
					Table.set("cell"+d2s(icell,0), ifile, trackVars[icell+ivar*ncells0+ifile*ncells0*inputS.length]);
				}
			}	
			updateResults();
			Table.deleteRows(0, 0); // - Deletes the first row where a lot of variables are absent 
			Table.save(workDir+nestedFolder+resultsDir+"cellTracks_row_fileNum_cellVal_rowNum.csv");
		}

		Table.create("Results");
		for(icell=0;icell<ncells0;icell++){
			if(unbrokenTracks[icell]!=0){
				Table.set("cell"+d2s(icell,0), 0, unbrokenTracks[icell]);
			}
		}
		updateResults();
		Table.save(workDir+nestedFolder+resultsDir+"cellIDsWithUnbrokenTrack.csv");

	}
	run("Close All");
	selectWindow("Results");

	print("---> Tracked individual cells completed! \nOutput: 'analysis/p*/phs/textResults/cellTracks_row_fileNum_cellVal_rowNum.csv'");

	run("Close All");
	print("\\Clear");
	close("\\other");
	
	setBatchMode(true);
	jcount = 0;
	for(ifile=2;ifile<files.length;ifile++){
		fname=replace(files[ifile],"_areaStat.txt",".csv");
		open(workDir+nestedFolder+resultsDir+fname);
		Table.rename(fname, "Results");
		if(jcount==0){
			variableList=split(Table.headings,'\t');
			jcount=1;
		}
		run("Results to Image");
		rename(replace(fname,".csv",""));
	}
	
	run("Images to Stack", "method=[Copy (top-left)] name=Stack title=[] use");
	rename("propStack");
	nVars=getWidth();
	open(workDir+nestedFolder+resultsDir+"cellTracks_row_fileNum_cellVal_rowNum.csv");
	Table.rename("cellTracks_row_fileNum_cellVal_rowNum.csv", "Results");
	
	selectWindow("Results");
	headings = split(String.getResultsHeadings);
	run("Results to Image");
	rename("linkedList");
	totSlices = getHeight()-1;
	ncells = getWidth();
	
	newImage("cellProps", "32-bit black", nVars, totSlices, ncells);
	
	for(icell=1;icell<ncells+1;icell++){
		selectWindow("cellProps");
		setSlice(icell);
		Property.setSliceLabel(headings[icell-1], icell);
		
		for(slic=1;slic<=totSlices;slic++){
			selectWindow("linkedList");
			varVal = getPixel(icell-1, slic);
			//print(d2s(totSlices,0)+"   "+headings[icell-1]+"  "+d2s(icell-1,0)+"  "+d2s(slic,0)+"  "+d2s(varVal,0));
			selectWindow("propStack");
			setSlice(slic);
			
			if(!isNaN(varVal)){
				makeRectangle(0, varVal-1, nVars, 1);
				run("Copy");
				selectWindow("cellProps");
				makeRectangle(0, slic-1, nVars, 1);
				run("Paste");
			}
		}
	}
	close("linkedList");
	close("propStack");
	selectWindow("cellProps");
	run("Select None");
	/*
	numOfNotifications = 10*2*PI/ncells;
	for(icell=1;icell<=ncells;icell++){
		selectWindow("cellProps");
		setSlice(icell);
		cellID = Property.getSliceLabel;
		run("Image to Results");
		selectWindow("Results");
		junkNames=split(Table.headings,'\t');
		Table.rename("Results",cellID);
		
		for(icol=0;icol<variableList.length-1;icol++){
			Table.renameColumn(junkNames[icol+2], variableList[icol+1]);
		}
		Table.save(workDir+nestedFolder+resultsDir+"cellTimeTrace_"+cellID+".csv");
		selectWindow(cellID);
		run("Close");
		jr1 = Math.sin(numOfNotifications*(icell-1));
		jr2 = Math.sin(numOfNotifications*icell);
		if (jr1>=0 && jr2<0) {
			print("Tracked "+d2s(icell,0)+" out of "+d2s(ncells,0)+" cells");
		}
	}
	*/

	nprops = variableList.length-1;
	
	for(iprop=0;iprop<nprops;iprop++){
		selectWindow("cellProps");
		// duplicate stack
		run("Duplicate...", "title=dupc duplicate");
		selectWindow("dupc");
		// make a rectange on specific axis
		makeRectangle(iprop, 0, 1, totSlices);
		// crop 
		run("Crop");
		// make montage
		run("Make Montage...", "columns="+ncells+" rows=1 scale=1");
		// rename mont
		rename("mont");
		// image 2 results
		run("Image to Results");
		// assign appropriate headings
		selectWindow("Results");
		junkNames=split(Table.headings,'\t');
		//Table.rename("Results",variableList[iprop+1]);
		IJ.renameResults(variableList[iprop+1]);
		selectWindow(variableList[iprop+1]);
		for(icol=0;icol<ncells;icol++){
			//print(junkNames[icol+2]+"  "+variableList[icol+1]);
			Table.renameColumn(junkNames[icol+2], "cell"+d2s(icol,0));
		}
		//Table.deleteColumn(junkNames[1]);
		// save results as property matrix
		Table.save(workDir+nestedFolder+resultsDir+"cellTimeTrace_"+variableList[iprop+1]+".csv");
		
		// close montage
		close("mont");
		// close duplicate stack
		close("dupc");
	}
	
	for(iprop=0;iprop<nprops;iprop++){
		close(variableList[iprop+1]);
	}

	close("cell*");
	close("\\Others");
	setBatchMode(false);

	// now create property focused files
	
	
	print("---> Tracked individual cells completed! \nOutput: 'analysis/p*/phs/textResults/cellTracks_*.csv'");
	showMessage("Tracked individual cells completed! \nOutput: 'analysis/p*/phs/textResults/cellTracks_*.csv'");
}








function makeTImage(tableName,tImageName){
	Table.rename(tableName, "Results");
	run("Results to Image");
	rename(tImageName);
	close(tableName);
}








function getCutOffRegion(imXSz, imYSz, bcond){
	// forceCutOffLimits = xmin;
	// forceCutOffLimits = ymin;
	// forceCutOffLimits = xmax;
	// forceCutOffLimits = ymax;

	x20Cutoff = imXSz*0.2;
	y20Cutoff = imYSz*0.2;
	forceCutOffLimits = newArray(4);
	if(bcond=="allFour"){ // 20% from all sides
		forceCutOffLimits[0] = x20Cutoff;
		forceCutOffLimits[1] = y20Cutoff;
		forceCutOffLimits[2] = imXSz - x20Cutoff;
		forceCutOffLimits[3] = imYSz - y20Cutoff;
	} else if(bcond=="leftTopBottom"){ // 20% from top left and bottom
		forceCutOffLimits[0] = x20Cutoff;
		forceCutOffLimits[1] = y20Cutoff;
		forceCutOffLimits[2] = imXSz;
		forceCutOffLimits[3] = imYSz - y20Cutoff;
	} else if(bcond=="allTwo"){ // 20% from top and bottom
		forceCutOffLimits[0] = 0;
		forceCutOffLimits[1] = y20Cutoff;
		forceCutOffLimits[2] = imXSz;
		forceCutOffLimits[3] = imYSz - y20Cutoff;
	} else if(bcond=="none"){ // allow everything
		forceCutOffLimits[0] = 0;
		forceCutOffLimits[1] = 0;
		forceCutOffLimits[2] = imXSz;
		forceCutOffLimits[3] = imYSz;
	}

	return forceCutOffLimits;
}






function start_cellTracking(workDir, nestedFolder, resultsDir, inputS, ifile, nfiles, ncells, csvflname){

	run("Clear Results");

	// create a celled Var array to be subsequently added to Results columns
	// open results file
	open(workDir+nestedFolder+resultsDir+csvflname);
    winTtleLst = getList("window.titles");
    lstLen = winTtleLst.length;
    for(wi=0;wi<lstLen;wi++){
		if(winTtleLst[wi]==csvflname){
			Table.rename(csvflname,"Results");
			lstLen=0;
        }
	}

	colLabel = split(String.getResultsHeadings);
	ncolumns = colLabel.length;

	trackVars = newArray(ncells*inputS.length*nfiles);

	for(icell=0;icell<ncells;icell++){
		for(ivar=0;ivar<inputS.length;ivar++){
			trackVars[icell+ivar*ncells+ifile*ncells*inputS.length] = icell+1;
		}
	}

	return trackVars;
}







function removeUniqueSlices(processed, refstack){ // processed = bwImages, refstack = phs
	 selectWindow(processed);
	 getDimensions(width1, height1, channels, slices1, frames1);
	 selectWindow(refstack);
	 getDimensions(width2, height2, channels, slices2, frames2);
	 if(slices1!=slices2){
		for(i=0;i<slices1;i++){
			selectWindow(processed);
			setSlice(i+1);
			lbl1 = getInfo("slice.label");
			foundIt = 0;
			nrepeats = slices2;
			for(j=0;j<nrepeats;j++){
				selectWindow(refstack);
				setSlice(j+1);
				if(lbl1==getInfo("slice.label")){
					foundIt = 1;
					nrepeats = 0;
				}
			}
			if(foundIt == 0){
				selectWindow(processed);
				run("Delete Slice");
			}
		}
	 }
}





function saveStats(plotVars, inputS, ncells, refFlag){

	statFile = workDir+nestedFolder+resultsDir+replace(files[ifile],"_areaStat.txt","_statistics.txt");
	if(File.exists(statFile)){ // keep previous information
		lines = File.openAsString(statFile);
		js = split(lines,"\r");
		removeExistingFile(statFile);
		f = File.open(statFile);
		for(i=0;i<js.length;i++){
			print(f, js[i]);
		}
		for(ivar=0;ivar<inputS.length;ivar++){
			prop = Array.slice(plotVars, ivar*ncells, ivar*ncells+ncells);
			Array.getStatistics(prop, pmin, pmax, pmean, pstdDev);
			print(f, inputS[ivar] + "," + d2s(pmin,5) + "," + d2s(pmax,5) + "," + d2s(pmean,5) + "," + d2s(pstdDev,5));
		}
		File.close(f);
	} else {
		f = File.open(statFile);
		print(f, "Property" + "," + "Min" + "," + "Max" + "," + "Mean" + "," + "StdDev");
		for(ivar=0;ivar<inputS.length;ivar++){
			prop = Array.slice(plotVars, ivar*ncells, ivar*ncells+ncells);
			Array.getStatistics(prop, pmin, pmax, pmean, pstdDev);
			print(f, inputS[ivar] + "," + d2s(pmin,5) + "," + d2s(pmax,5) + "," + d2s(pmean,5) + "," + d2s(pstdDev,5));
		}
		File.close(f);
	}

	if(refFlag==1){
		File.copy(statFile, replace(statFile,"_statistics.txt","_statistics.txtReference"));
	}
}



function getVarStats(plotVars, inputS, ncells){
	varStats = newArray(inputS.length*4);
	for(ivar=0;ivar<inputS.length;ivar++){
		prop = Array.slice(plotVars, ivar*ncells, ivar*ncells+ncells);
		Array.getStatistics(prop, pmin, pmax, pmean, pstdDev);
		varStats[0+ivar*4] = pmin;
		varStats[1+ivar*4] = pmax;
		varStats[2+ivar*4] = pmean;
		varStats[3+ivar*4] = pstdDev;
	}
	
	return varStats;
}





// colNums = newArray(0, 1, 3, 4) ... X Y Vy Speed (always have 0 and 1)
function readGridDataFile(inputFile, colNums){

	f = File.openAsString(inputFile);
	rows = split(f, "\n");
	numCols = colNums.length;
	x_y_vars = newArray(rows.length*colNums.length);
	for(j=0;j<rows.length;j++){
		cols = split(rows[j]," ");
		for(i=0;i<numCols;i++){
			x_y_vars[j*numCols+i] = parseFloat(cols[colNums[i]]);
		}
	}
	
	return x_y_vars;
}






// funciton to create mask image that has 1 in cell region and 0 in no-cell region
function createMaskImage(dir, saveDir, imfl)
{
	open(dir+imfl); // open the file	// 
	rowSz = getHeight();
	colSz = getWidth();
	
	run("EDM Binary Operations", "iterations=3 operation=dilate");
	
	// fill open holes in no-cell area
	expandIm = true; flipDir=2; imRows=rowSz; imCols=colSz;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);
	expandIm = true; flipDir=3; imRows=rowSz; imCols=colSz*2-1;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);
	expandIm = true; flipDir=4; imRows=rowSz*2-1; imCols=colSz*2-1;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);

	run("Select All");
	run("Fill Holes"); 	run("Invert");	run("Fill Holes");	run("Invert");
	expandIm = false; flipDir=4; imRows=rowSz; imCols=colSz;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);

	// fill open holes in no-cell area
	expandIm = true; flipDir=1; imRows=rowSz; imCols=rowSz;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);
	expandIm = true; flipDir=3; imRows=rowSz; imCols=colSz*2-1;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);
	expandIm = true; flipDir=4; imRows=rowSz*2-1; imCols=colSz*2-1;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);
	run("Select All");


	run("EDM Binary Operations", "iterations=3 operation=dilate");
	run("Fill Holes"); 	
	
	run("Invert");	run("Fill Holes");	run("Invert");
	
	expandIm = false; flipDir=3; imRows=rowSz; imCols=colSz*2-1;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);
	expandIm = false; flipDir=1; imRows=rowSz; imCols=colSz;
	mirror_unmirror(expandIm, flipDir, imRows, imCols);

	// invert intensities 
	run("Invert"); 
	run("EDM Binary Operations", "iterations=6 operation=dilate");
	run("Invert"); 

	saveAs("Tiff", saveDir+imfl);

	run("Close All");
}




// function to do mirroring of image to fill open holes in the data
function mirror_unmirror(expandIm, flipDir, imRows, imCols)
{
	// flipDir = 1 ... flipright
	// flipDir = 2 ... flipleft
	// flipDir = 3 ... flipup
	// flipDir = 4 ... flipdown

	if(expandIm)
	{
		if(flipDir == 1)
		{
			run("Canvas Size...", "width="+imCols*2-1+" height="+imRows+" position=Top-Left zero");
			makeRectangle(0, 0, imCols, imRows);
			run("Copy");
			makeRectangle(imCols, 0, imCols, imRows);
			run("Paste");
			run("Flip Horizontally");
		}
		else if(flipDir == 2)
		{
			run("Canvas Size...", "width="+imCols*2-1+" height="+imRows+" position=Top-Right zero");
			makeRectangle(imCols, 0, imCols, imRows);
			run("Copy");
			makeRectangle(0, 0, imCols, imRows);
			run("Paste");
			run("Flip Horizontally");
		}
		else if(flipDir == 3)
		{
			run("Canvas Size...", "width="+imCols+" height="+imRows*2-1+" position=Bottom-Right zero");
			makeRectangle(0, imRows, imCols, imRows);
			run("Copy");
			makeRectangle(0, 0, imCols, imRows);
			run("Paste");
			run("Flip Vertically");
		}
		else if(flipDir == 4)
		{
			run("Canvas Size...", "width="+imCols+" height="+imRows*2-1+" position=Top-Right zero");
			makeRectangle(0, 0, imCols, imRows);
			run("Copy");
			makeRectangle(0, imRows, imCols, imRows);
			run("Paste");
			run("Flip Vertically");
		}
	}
	else // do not expand 
	{
		if(flipDir == 1)
		{
			makeRectangle(0, 0, imCols, imRows);
			run("Crop");
		}
		else if(flipDir == 2)
		{
			makeRectangle(imCols, 0, imCols, imRows);
			run("Crop");
		}
		else if(flipDir == 3)
		{
			makeRectangle(0, imRows, imCols, imRows);
			run("Crop");
		}
		else if(flipDir == 4)
		{
			makeRectangle(imCols, imRows, imCols, imRows);
			run("Crop");
		}	
	}
	
}





function gridData2ImgFile(inputFile, suffixOld, varNames, colNums, formulae, varA, varB, imW, imH){

	windowSize = 0;
	f = File.openAsString(inputFile);
	rows = split(f, "\n");
	nRows = rows.length;
	cols = split(rows[0]," ");
	nCols = cols.length;
	nVars = colNums.length;

	neqs = formulae.length;
	
	// first two columns are assumed to be x and y
	x = newArray(nRows);
	y = newArray(nRows);
	vars = newArray(nRows*nVars);

	// determine if the data runs right or down first
	js = split(rows[0]," ");
	x0 = parseFloat(js[0]); y0 = parseFloat(js[1]);
	js = split(rows[1]," ");
	x1 = parseFloat(js[0]); y1 = parseFloat(js[1]);
	if(abs(y1-y0) > abs(x1-x0)){// data runs down
		dataType = "xconst";
		windowSize = abs(y1-y0);
	} else {
	    dataType = "yconst";
		windowSize = abs(x1-x0);
	}
	
	if(windowSize==0){
		exit("Window Size = 0!");
	}

	nrepeats = 0; // assuming the data runs to right and then down
	jnRows = nRows;
	for(j=0;j<jnRows;j++){
		cols = split(rows[j]," ");
		x[j] = parseFloat(cols[0]);
		y[j] = parseFloat(cols[1]);
		if(nrepeats==0){
			if(dataType=="xconst"){
				if(j>0){
					if(x[j]!=x[j-1]){
						nrepeats = j;
						jnRows = 0;
					}
				}
			} else if(dataType=="yconst"){
				if(j>0){
					if(y[j]!=y[j-1]){
						nrepeats = j;
						jnRows = 0;
					}
				}
			}
		}
	}

	for(j=0;j<nRows;j++){
		cols = split(rows[j]," ");
		x[j] = parseFloat(cols[0]);
		y[j] = parseFloat(cols[1]);
		
		for(i=0;i<nVars-neqs;i++){
			vars[i*nRows+j] = parseFloat(cols[colNums[i]]);
		}
		for(i=nVars-neqs;i<nVars;i++){
			jformula = formulae[i-nVars+neqs];			
			if(jformula=="sqrt(a^2+b^2)"){
				vars[i*nRows+j] = sqrt(pow(parseFloat(cols[varA[i-nVars+neqs]]),2) + pow(parseFloat(cols[varB[i-nVars+neqs]]),2));
			} else if(jformula=="arctan(b/a)"){
				vars[i*nRows+j] = atan2(parseFloat(cols[varB[i-nVars+neqs]]), parseFloat(cols[varA[i-nVars+neqs]]))*180.0/PI;
			} else if(jformula=="(a+b)/2"){
				vars[i*nRows+j] = 0.5*(parseFloat(cols[varA[i-nVars+neqs]]) + parseFloat(cols[varB[i-nVars+neqs]]));
			} else if(jformula=="|(a-b)/2|"){
				vars[i*nRows+j] = 0.5*abs(parseFloat(cols[varA[i-nVars+neqs]]) - parseFloat(cols[varB[i-nVars+neqs]]));
			}
		}
	}

	heightPhs = imH;
	widthPhs = imW;
	
	for(ivar=0;ivar<nVars;ivar++){
		// assuming that data runs horizonally to right
		// determine number of entries in a row
		if(dataType=="xconst"){
			for(i=0;i<nRows/nrepeats;i++){
				for(j=0;j<nrepeats;j++){
					setResult(d2s(i,0), j, vars[j+i*nrepeats+ivar*nRows]);
				}
			}
			updateResults()
		} else if(dataType=="yconst"){
			for(i=0;i<nRows/nrepeats;i++){
				for(j=0;j<nrepeats;j++){
					setResult(d2s(j,0), i, vars[j+i*nrepeats+ivar*nRows]);
				}
			}
			updateResults();
		}

		// transform result to image
		run("Results to Image");
		rename(varNames[ivar]);

		/* // increase grid size by 2
		// mean filter by 2x2 martix */

		selectWindow(varNames[ivar]);
		height = getHeight();
		width = getWidth();
		run("Size...", "width="+d2s(width*windowSize,0)+" height="+d2s(height*windowSize,0)+" constrain average interpolation=None");

		height = height*windowSize;
		width = width*windowSize;
		
		// top left corner is going to be at (x0-windowSize/2,y0-windowSize/2)
		if(windowSize%2==0){
			x0locn = x[0]-windowSize/2; y0locn = y[0]-windowSize/2;
		} else {
			x0locn = x[0]-(floor(windowSize/2)+1); y0locn = y[0]-(floor(windowSize/2)+1);
		}
		
		ivarW = minOf(width,widthPhs-x0locn); ivarH = minOf(height,heightPhs-y0locn);

		selectWindow(varNames[ivar]);
		makeRectangle(0,0,ivarW,ivarH);
		run("Crop");
		run("Select All");
		run("Copy");
		
		newImage(varNames[ivar]+"Save", "32-bit black", widthPhs, heightPhs, 1);
		selectWindow(varNames[ivar]+"Save");
		makeRectangle(x0locn,y0locn,ivarW,ivarH);
		run("Paste");
		run("Select None");
		
		// save image
		saveAs("Tiff", replace(inputFile,suffixOld,"")+"_"+varNames[ivar]+".tif"); // this will require only one dot in the file name
		run("Close All");
		run("Clear Results");
	}
}






function nonGridData2ImgFile(inputFile, suffixOld, varNames, colNums, formulae, varA, varB, imW, imH){

	heightPhs = imH;
	widthPhs = imW;
	print("opening file: "+inputFile);
	f = File.openAsString(inputFile);
	rows = split(f, "\n");
	nRows = rows.length;
	
	cols = split(rows[0]," ");
	nCols = cols.length;
	print("ncols="+d2s(nCols,0));
	
	nVars = colNums.length;
	print("nVars="+d2s(nVars,0));

	neqs = formulae.length;
	print("neqs="+d2s(neqs,0));
	
	// first two columns are assumed to be x and y
	x = newArray(nRows);
	y = newArray(nRows);
	vars = newArray(nRows*nVars);

	for(j=0;j<nRows;j++){
		cols = split(rows[j]," ");
		x[j] = parseFloat(cols[0]);
		y[j] = parseFloat(cols[1]);
		
		for(i=0;i<nVars-neqs;i++){
			vars[i*nRows+j] = parseFloat(cols[colNums[i]]);
		}
		for(i=nVars-neqs;i<nVars;i++){
			jformula = formulae[i-nVars+neqs];			
			if(jformula=="sqrt(a^2+b^2)"){
				vars[i*nRows+j] = sqrt(pow(parseFloat(cols[varA[i-nVars+neqs]]),2) + pow(parseFloat(cols[varB[i-nVars+neqs]]),2));
			} else if(jformula=="(a+b)/2"){
				vars[i*nRows+j] = 0.5*(parseFloat(cols[varA[i-nVars+neqs]]) + parseFloat(cols[varB[i-nVars+neqs]]));
			} else if(jformula=="|(a-b)/2|"){
				vars[i*nRows+j] = 0.5*abs(parseFloat(cols[varA[i-nVars+neqs]]) - parseFloat(cols[varB[i-nVars+neqs]]));
			} else if(jformula=="arctan(b/a)"){
				vars[i*nRows+j] = atan2(parseFloat(cols[varB[i-nVars+neqs]]), parseFloat(cols[varA[i-nVars+neqs]]))*180.0/PI;
			}
		}
	}

	
	Array.getStatistics(x, xmin, xmax, jr, jr);
	Array.getStatistics(y, ymin, ymax, jr, jr);

	elemSz = 1e12;
	// assiming square element
	for(i=1;i<nRows;i++){
		if(x[i]!=x[0]){
			ielemSz = abs(x[i]-x[0]);
			if(ielemSz<elemSz){
				elemSz = ielemSz;
			}
		}
	}

	resX = x;
	resY = y;
	// get coordinates on results window
	for(i=0;i<nRows;i++){
		resX[i] = round((x[i]-xmin)/elemSz);
		resY[i] = round((y[i]-ymin)/elemSz);
	}
	resMinX = 0;
	resMinY = 0;
	resMaxX = round((xmax-xmin)/elemSz);
	resMaxY = round((ymax-ymin)/elemSz);
	for(ivar=0;ivar<nVars;ivar++){
		for(j=0;j<nRows;j++){
			setResult(d2s(resX[j],0), resY[j], vars[j+ivar*nRows]);
		}
		updateResults();
		
		// transform result to image
		run("Results to Image");
		rename(varNames[ivar]);

		/* // increase grid size by 2
		// mean filter by 2x2 martix */

		selectWindow(varNames[ivar]);
		height = getHeight();
		width = getWidth();

		height = height*elemSz;
		width = width*elemSz;

		run("Size...", "width="+d2s(width,0)+" height="+d2s(height,0)+" constrain average interpolation=None");		

		// top left corner is going to be at (x0-windowSize/2,y0-windowSize/2)
		x0locn = xmin; y0locn = ymin;
		ivarW = minOf(width,widthPhs-x0locn); ivarH = minOf(height,heightPhs-y0locn);

		selectWindow(varNames[ivar]);
		makeRectangle(0,0,ivarW,ivarH);
		run("Crop");
		run("Select All");
		getSelectionBounds(ji, ji, ivarW, ivarH);
		run("Copy");
		
		newImage(varNames[ivar]+"Save", "32-bit black", widthPhs, heightPhs, 1);
		selectWindow(varNames[ivar]+"Save");
		// ----------------------------------------------------------------------------
		// following does not necessarily paste the region in the rectangle with lowerleft corner at x0locn, y0locn
		// this problem arises when the ivarW is not equal to the ivarW of the cropped image, hence ivarW is now updated using getBounds command above
		// ----------------------------------------------------------------------------
		makeRectangle(x0locn,y0locn,ivarW,ivarH);
		getSelectionBounds(ji, ji, iwid, ihei);
		if(iwid!=ivarW || ihei!=ivarH){
			exit("Data is not located appropriately on the image");
		}
		run("Paste");
		// ----------------------------------------------------------------------------
		run("Select None");


		
		// save image
		saveAs("Tiff", replace(inputFile,suffixOld,"")+"_"+varNames[ivar]+".tif"); // this will require only one dot in the file name
		run("Close All");
		run("Clear Results");
	}
}





function endsWith_file_dir_list(dir, fType){ // fType =  "/" or ".tif"

	files = getFileList(dir);
	fileNames = newArray(); // dynamically allocated array
	for (i=0; i<files.length; i++) {
		if(endsWith(files[i],fType)){
			fileNames = Array.concat(fileNames,files[i]);
		}
	}
	
	return fileNames;
}







function inputParameters_trackCellProps(colLabel, purpose){
	input = newArray("");
	nrows = round(colLabel.length/4);
	if(nrows==0) exit("Could not find column labels for the data file");
	ncols = colLabel.length/nrows;
	if(colLabel.length > nrows*ncols){
	   nrows = nrows + 1;
	}
	defaults = newArray(colLabel.length);
	for (i=0; i<colLabel.length; i++) {
	   if(i<2){
	   	defaults[i] = true;
	   } else {
	   	defaults[i] = false;
	   }
	}
	if(purpose=="trac"){
		title = "Check the variables for tracking";
	} else if(purpose=="maps"){
	    title = "Check the variables to make maps";
	}
	
	setBatchMode(false);
	Dialog.create(title);
	Dialog.addString("Common choices:", "Area,X,Y,Angle,Circ.,Distance,Mean,speedMedian,speedStdDev,velAngleMedian,velAngleStdDev,avgtenMedian,avgtenStdDev,maxShrMedian,maxShrStdDev,thetaMedian,thetaStdDev,tmagMedian,tmagStdDev,NBRspeedMedian,NBRspeedStdDev,NBRvelAngleMedian,NBRvelAngleStdDev,NBRavgtenMedian,NBRavgtenStdDev,NBRmaxShrMedian,NBRmaxShrStdDev,NBRthetaMedian,NBRthetaStdDev,NBRtmagMedian,NBRtmagStdDev,NBRMedian,NBRStdDev", 100);
	Dialog.addCheckboxGroup(nrows,ncols,colLabel,defaults);
	Dialog.addMessage("Make choices in the checkbox or provide comma separated variable names");
	Dialog.addMessage("If comma separated string is provided, the choices in the checkbox will be ignored");
	js = Dialog.show();
	varOptions = Dialog.getString();
	if(purpose=="trac"){
		print("Following properties of the cell will be tracked");
	} else if(purpose=="maps"){
		print("Following properties of the cell will be mapped");
	}

	if(varOptions==""){
		inputCount = 0;
		for (i=0; i<colLabel.length; i++){
			print(i);
			ji = Dialog.getCheckbox();
			if(ji==1){
				if(inputCount==0){
					input[0] = colLabel[i];
					inputCount = 1;
				} else {
					input = Array.concat(input,colLabel[i]);
				}
			}
		}
	} else {
		input = split(varOptions, ",");
	}
	Array.print(input);
	setBatchMode(true);
	
	return input;
}



function inputParameters_grid2Col(openDialogTitle){
	input = newArray(9);
	title = "From the series of files to be converted, choose one";
	setBatchMode(false);
	path = File.openDialog(title); //+openDialogTitle);
	input[0] = File.getParent(path)+"/"; // directory
	input[1] = File.getName(path); // filename
	f = File.openAsString(path);
	rows = split(f, "\n");
	cols = split(rows[0]," ");
	ncols = cols.length;
	input[7] = d2s(ncols,0);
	x0 = parseFloat(cols[0]);
	y0 = parseFloat(cols[1]);

	cols = split(rows[1]," ");
	x1 = parseFloat(cols[0]);
	y1 = parseFloat(cols[1]);

	if(abs(x1-x0)>abs(y1-y0)){ // assumption is that one of them will be zero and other will not
		input[2] = d2s(round(abs(x1-x0)),0); // gridSize
	} else {
		input[2] = d2s(round(abs(y1-y0)),0);
	}
	title = "Which of the following column numbers do you want to convert?";
	Dialog.create(title);
	labels = newArray(ncols);
	defaults = newArray(ncols);
	for (i=0; i<ncols; i++) {
		labels[i] = "Column "+d2s(i,0);
		defaults[i] = true;
	}
	cbcols = minOf(ncols,5);
	cbrows = 1;
	for(i=0;i<cbcols;i++){
		if(cbrows*cbcols<ncols){
			cbrows = cbrows + 1;
		}
	}
	Dialog.addCheckboxGroup(cbrows,cbcols, labels, defaults);
	Dialog.addCheckbox("Save images immediately?", false);
	Dialog.addCheckbox("Convert text data to images?", true);
	Dialog.addMessage("- Saving images immediately will slow the process down, you can always save it later using 'Results - picture'");
	Dialog.addMessage("- Convert text data into images only once. If it has been converted, then save time by unchecking convert");
	Dialog.addMessage("- File columns: 'allForces.dat' - x(pix), y(pix), tx(Pa), ty(Pa), sxx(Pa), syy(Pa), sxy(Pa), maxP(Pa), minP(Pa), maxPex(unitless), maxPey(unitless), strainEnergy(Joules)");
	Dialog.addMessage("- File columns: 'disp.dat' or 'vel.dat' - x(pixel), y(pixel), u(pix/successive frame), v(pix/successive frame), speed(pix/successive frame), matching, similar for second peak");
	Dialog.addMessage("- File columns: 'traction.dat' - x(pix), y(pix), tx(Pa), ty(Pa)");
	js = Dialog.show();
	title = Dialog.getString();
	input[3] = "0 1";
	nVars = 2;
	for(i=0;i<ncols;i++){
		js = Dialog.getCheckbox();
		if(i>1 && js==1){ // first two columns are always considered as true
			input[3] = input[3] + " " + d2s(i,0);
			nVars = nVars + 1;
		}
	}
	input[5] = d2s(Dialog.getCheckbox(),0);
	input[6] = d2s(Dialog.getCheckbox(),0);

	title = "Give variable names";
	Dialog.create(title);
	iitems = newArray("FEA","PIV");
	Dialog.addRadioButtonGroup("Data file is output of ", iitems, 1, 2, iitems[0]);
	labels = split(input[3]," ");
	for(i=2;i<nVars;i++){
		Dialog.addString("Column "+labels[i]+":", "");
	}
	Dialog.addMessage("Give names without any blank spaces anywhere");
	Dialog.addMessage("First two columns are expected to be X and Y, they will be taken as Xg and Yg");
	Dialog.addMessage("- File columns: 'allForces.dat' - x(pix), y(pix), tx(Pa), ty(Pa), sxx(Pa), syy(Pa), sxy(Pa), maxP(Pa), minP(Pa), maxPex(unitless), maxPey(unitless), strainEnergy(Joules)");
	Dialog.addMessage("- File columns: 'disp.dat' or 'vel.dat' - x(pixel), y(pixel), u(pix/successive frame), v(pix/successive frame), speed(pix/successive frame), matching, similar for second peak");
	Dialog.addMessage("- File columns: 'traction.dat' - x(pix), y(pix), tx(Pa), ty(Pa)");
	Dialog.addMessage("NOTE: File format is automatically assumed to be 'FEA' if the filename ends with allForces.dat'. Otherwise, file format is considered to be 'PIV'.");
	js = Dialog.show();
	input[8] = Dialog.getRadioButton();
	
	input[4] = "Xg Yg";
	for(i=2;i<nVars;i++){
		input[4] = input[4] + " " + Dialog.getString();
	}
	setBatchMode(true);
	print("-> colHeaders="+input[4]);

	return input;
}




function inputParameters_indiCelSeg(saveDir, flname, individualInput){

    fileFlag = File.exists(saveDir+individualInput);
	setBatchMode(false);
    if(fileFlag == 1){
    	input = readInputFile(saveDir+individualInput, "num");
    } else {
    	input = newArray(8);
		title = "Choose input parameters";
		Dialog.create(title);
	 	Dialog.addNumber("Circularity min limit:", 0.1); // large number is useful
	 	Dialog.addNumber("Prominence of cell center other parts: ", 10);
	 	Dialog.addNumber("Sledgehammer (10X mag and 2048x2048 res):", 5);// Size of Gaussian blur (5 for 10X):", 5);
		Dialog.addNumber("Mallet - (10X mag and 2048x2048 res):", 30); //Radius for segmentation (30 for 10X):", 30); // large number will create lesser breaks in the cell
		Dialog.addCheckbox("Exclude cells that are touching the boundary?", true);
		Dialog.addCheckbox("On the results, apply 20% cut-off for boundary affected forces?", true);
	 	Dialog.addMessage("For SLEDGEHAMMER and MALLET: \n- Use smaller value to break clumps, \n- Use larger values for higher mag or higher res");
	 	Dialog.addMessage("For Prominence: \n- Use smaller for low contrast images, \n- Use larger to minimize tny black spots, \n- Use smaller value to remove large black regions");
		js = Dialog.show();
	    title = Dialog.getString();
	    input[2] = Dialog.getNumber();
	    input[7] = Dialog.getNumber();
	 	if(input[2]%2==0){
	 		input[2] = input[2]+1; // needs odd number
	 	}
	    input[4] = Dialog.getNumber();
	    input[3] = Dialog.getNumber();
	    input[5] = Dialog.getCheckbox();
	    input[6] = Dialog.getCheckbox();

		print("Assuming that the user is drawing the boundary with 95% accuracy");
		input[0] = getSizeOfARegion(flname, "In any frame of this image sequence, \n- Draw a polygon around the SMALLEST NORMAL cell, \n- Click OK");
		input[0] = 0.95*input[0]; // 5% smaller thing is dirt
		input[0] = input[0]; // 5% smaller thing is dirt
		print("Smallest cell area = "+d2s(input[0],5));
	
		input[1] = getSizeOfARegion(flname, "In any frame of this image sequence, \n- Draw a polygon around the BIGGEST NORMAL cell, \n- Click OK");
		input[1] = 1.05*input[1]; // 5% smaller thing is dirt
		input[1] = input[1]; // 5% smaller thing is dirt
		print("Largest cell area = "+d2s(input[1],5));

		// save inputs
		f = File.open(saveDir+individualInput); // display file open dialog
		print(f, d2s(input[0],5) + "  \t" + d2s(input[1],5) + "  \t" + d2s(input[2],5) + "  \t" + d2s(input[3],5) + "  \t" + d2s(input[4],5) + "  \t" + d2s(input[5],0)+ "  \t" + d2s(input[6],0) + "  \t" + d2s(input[7],0));
		File.close(f);
    }
	setBatchMode(true);
    
    return input;
}



function inputParameters_clusterSeg(saveDir, flname, clusterInput){
    
    jflag = File.exists(saveDir+clusterInput);
    fileFlag = 0;
    if(jflag==1){
    	fileFlag = getBoolean("Use saved cluster segmentation choices?","Yes","No");
    }
    if(fileFlag == 1){
	    input = readInputFile(saveDir+clusterInput, "num");
    } else {
    	input = newArray(7);

		//print("Assuming that user is drawing the region with 95% accuracy");
		setBatchMode(false);
		//input[0] = getSizeOfARegion(flname, "In any frame of this image sequence, \n- Draw a polygon around the distinctive LARGEST NON-CELL object, \n- Click OK");
		//input[0] = 0.95*input[0];
		//print("Area of dirt = "+d2s(input[0],0));
		input[0] = 0.0; // input is supressed
		
		title = "Choose input parameters";
		Dialog.create(title);
		Dialog.addMessage("Following two values are for 10X mag and 2048x2048 res \nUse larger values higher mag or higher res images");
		Dialog.addNumber("Domain connecting factor:", 10); // large number is useful open close operations
		Dialog.addNumber("Smear factor:", 10); // large number is useful Gaussian blur radius
		Dialog.addCheckbox(" - Method 1", true);
		Dialog.addCheckbox(" - Method 2", true);
		Dialog.addCheckbox(" - Method 3 (bottom beads cause problem)", true);
		Dialog.addCheckbox(" - Method 4 (bottom beads cause problem)", true);
	
		js = Dialog.show();
		title = Dialog.getString();
		js = Dialog.getString();
		input = newArray(7);
		input[1] = Dialog.getNumber();
		input[6] = Dialog.getNumber();
		method1Flag = Dialog.getCheckbox();
		method2Flag = Dialog.getCheckbox();
		method3Flag = Dialog.getCheckbox();
		method4Flag = Dialog.getCheckbox();
		input[2] = 1;
		if(method1Flag==false) input[2] = 0;
		input[3] = 1;
		if(method2Flag==false) input[3] = 0;
		input[4] = 1;
		if(method3Flag==false) input[4] = 0;
		input[5] = 1;
		if(method4Flag==false) input[5] = 0;
		
	
		// save inputs
		f = File.open(saveDir+clusterInput); // display file open dialog
		print(f, d2s(input[0],0) + "\t" + d2s(input[1],0) + "\t" + d2s(input[6],0) + "\t" + d2s(input[2],0) + "\t" + d2s(input[3],0) + "\t" + d2s(input[4],0) + "\t" + d2s(input[5],0));
		File.close(f);
		setBatchMode(true);
    }
    
	return input;
}










function method1(im0Title, imNextTitle, smearVal, m1InvertFlag, negativeFlags){
	setBatchMode(true);
	getImagesForAnalysis(im0Title, imNextTitle);
	selectWindow(im0Title);
	run("Bandpass Filter...", "filter_large=40 filter_small=3 suppress=None tolerance=5 autoscale saturate");
	run("Duplicate...", " ");
	rename("ji");
	run("Maximum...", "radius="+d2s(smearVal*2,0));
	run("Invert");
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	selectWindow(im0Title);
	run("Minimum...", "radius="+d2s(smearVal*2,0));
	imageCalculator("Max create 32-bit", "ji",im0Title);
	close(im0Title);
	close(im0Title+"a");
	rename(im0Title);
	run("16-bit");
	run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
	

	selectWindow(imNextTitle);
	run("Bandpass Filter...", "filter_large=40 filter_small=3 suppress=None tolerance=5 autoscale saturate");
	run("Duplicate...", " ");
	rename("ji");
	run("Maximum...", "radius="+d2s(smearVal*2,0));
	run("Invert");
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	selectWindow(imNextTitle);
	run("Minimum...", "radius="+d2s(smearVal*2,0));
	imageCalculator("Max create 32-bit", "ji",imNextTitle);
	close(imNextTitle);
	close(imNextTitle+"a");
	rename(imNextTitle);
	run("16-bit");
	run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
	
	imageCalculator("Multiply create 32-bit", im0Title,imNextTitle);
	run("8-bit");
	setAutoThreshold("Default");
	setThreshold(0, 40);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setOption("BlackBackground", true);
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	ensureBinary(10, 0, 40);
	
	rename("result");
	if(negativeFlags==0){
		setBatchMode(false);
	}
	
	postIt(1);
	
	if(negativeFlags==0) {
		m1InvertFlag = getBoolean("Indicate color of the cells in method 1: ", "Black", "White");
	}
	if(m1InvertFlag==1){
		selectWindow("result");
		run("Invert");
		selectWindow("Method 1");
		run("Invert");
	}

	close(im0Title);
	close(imNextTitle);

	return m1InvertFlag;
}





function method2(im0Title, imNextTitle, smearVal, m2InvertFlag, negativeFlags){
	setBatchMode(true);
	checkOtherResults();
	
	getImagesForAnalysis(im0Title, imNextTitle);

	selectWindow(im0Title);
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	run("Bandpass Filter...", "filter_large=100 filter_small=0 suppress=None tolerance=5 autoscale saturate");
	run("Duplicate...", " ");
	rename("ji");
	run("Duplicate...", " ");
	rename("ji1");
	run("Minimum...", "radius="+d2s(smearVal*2,0));
	setAutoThreshold("Default");
	setThreshold(0, 50);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setOption("BlackBackground", true);
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	selectWindow("ji");
	run("Maximum...", "radius="+d2s(smearVal*2,0));
	setAutoThreshold("Default");
	setThreshold(200, 255);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setOption("BlackBackground", true);
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	imageCalculator("Max create", "ji","ji1");
	close("ji");
	close("ji1");
	rename("ji");
	selectWindow(im0Title);
	run("Duplicate...", " ");
	rename("ji1");
	setAutoThreshold("Default");
	setThreshold(0, 50);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setOption("BlackBackground", true);
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	selectWindow(im0Title);
	setAutoThreshold("Default");
	setThreshold(200, 255);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setOption("BlackBackground", true);
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	ensureBinary(10, 200, 255);
	imageCalculator("Max create", "ji1",im0Title);
	close(im0Title);
	close("ji1");
	rename(im0Title);
	imageCalculator("Max create", "ji",im0Title);
	close(im0Title);
	close("ji");
	rename("result");
	if(negativeFlags==0){
		setBatchMode(false);
	}
	
	postIt(2);

	if(negativeFlags==0) {
		m2InvertFlag = getBoolean("Indicate color of the cells in method 2: ", "Black", "White");
	}
	if(m2InvertFlag==1){
		selectWindow("result");
		run("Invert");
		selectWindow("Method 2");
		run("Invert");
	}


	close(im0Title);
	close(imNextTitle);
	

	
	checkMergeResults();

	return m2InvertFlag;
}




function method3(im0Title, imNextTitle, smearVal, m3InvertFlag, negativeFlags){
	setBatchMode(true);
	
	checkOtherResults();
	
	getImagesForAnalysis(im0Title, imNextTitle);
	selectWindow(im0Title);
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	run("Variance...", "radius="+d2s(round(smearVal/2),0));

	selectWindow(imNextTitle);
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	run("Variance...", "radius="+d2s(round(smearVal/2),0));

	imageCalculator("Subtract create 32-bit", im0Title,imNextTitle);
	rename("ensureBinary0");
	run("Multiply...", "value=255.000000");

	run("Abs");
	run("8-bit");
	run("Duplicate...", " ");
	rename("ensureBinary1");

	setAutoThreshold("Default");
	setThreshold(3, 255);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setOption("BlackBackground", true);
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	ensureBinary(10, 3, 255);
	run("EDM Binary Operations", "iterations=2 operation=dilate");
	run("EDM Binary Operations", "iterations=2 operation=erode");

	close(im0Title);
	close(imNextTitle);
	run("Invert");
	rename("result");

	if(negativeFlags==0){
		setBatchMode(false);
	}

	postIt(3);
	
	if(negativeFlags==0) {
		m3InvertFlag = getBoolean("Indicate color of the cells in method 3: ", "Black", "White");
	}
	if(m3InvertFlag==1){
		selectWindow("result");
		run("Invert");
		selectWindow("Method 3");
		run("Invert");
	}


	close(im0Title);
	close(imNextTitle);
	
	checkMergeResults();

	return m3InvertFlag;
}


function method4(im0Title, imNextTitle, smearVal, m4InvertFlag, negativeFlags){

	setBatchMode(true);
	
	checkOtherResults();
	
	getImagesForAnalysis(im0Title, imNextTitle);
	selectWindow(im0Title);
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	run("Subtract Background...", "rolling="+d2s(smearVal*5,0)); //run("Bandpass Filter...", "filter_large=100 filter_small=0 suppress=None tolerance=5 autoscale saturate");
	run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
	run("Variance...", "radius=1");

	selectWindow(imNextTitle);
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	run("Subtract Background...", "rolling="+d2s(smearVal*5,0)); //run("Bandpass Filter...", "filter_large=100 filter_small=0 suppress=None tolerance=5 autoscale saturate");
	run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
	run("Variance...", "radius=1");
	
	imageCalculator("Subtract create 32-bit", im0Title,imNextTitle);
	close(im0Title);
	close(imNextTitle);

	run("16-bit");
	run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
	run("Gaussian Blur...", "sigma="+d2s(smearVal,0));
	run("Variance...", "radius=1");
	run("8-bit");
	setAutoThreshold("Default");
	setThreshold(128, 255);
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	setOption("BlackBackground", true);
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	
	run("Invert");
	rename("result");

	if(negativeFlags==0){
		setBatchMode(false);
	}
	
	postIt(4);

	if(negativeFlags==0) {
		m4InvertFlag = getBoolean("Indicate color of the cells in method 4: ", "Black", "White");
	}
	if(m4InvertFlag==1){
		selectWindow("result");
		run("Invert");
		selectWindow("Method 4");
		run("Invert");
	}

	close(im0Title);
	close(imNextTitle);
	
	checkMergeResults();
	
	return m4InvertFlag;
}



function getImagesForAnalysis(im0Title, imNextTitle){
	selectWindow("imCurrent");
	run("Duplicate...", " ");
	rename(im0Title);
	selectWindow("imNext");
	run("Duplicate...", " ");		
	rename(imNextTitle);
}



function checkOtherResults(){
	list = getList("image.titles");
	loopEnd = list.length;
	for(i=0;i<loopEnd;i++){
		if(list[i]=="result"){
			selectWindow("result");
			rename("result0");
			loopEnd = 0;
		}
	}
}


function checkMergeResults(){
	list = getList("image.titles");
	loopEnd = list.length;
	for(i=0;i<loopEnd;i++){
		if(list[i]=="result0"){
		imageCalculator("Max create", "result0","result");
		close("result");
		close("result0");
		rename("result");
		loopEnd = 0;
		}
	}
}



function postIt(methodNumber){
	imSz = round(screenHeight/4);
	if(screenHeight>screenWidth){
		imSz = round(screenWidth/4);
	}
	locx = screenWidth-imSz;
	locy1 = 0;
	locy2 = locy1+imSz;
	locy3 = locy2+imSz;
	locy4 = locy3+imSz;
	
	run("Duplicate...", " ");
	if(methodNumber==1){
		rename("Method 1");
		setLocation(locx, locy1, imSz, imSz);
	} else if(methodNumber==2){
		rename("Method 2");
		setLocation(locx, locy2, imSz, imSz);
	} else if(methodNumber==3){
		rename("Method 3");
		setLocation(locx, locy3, imSz, imSz);
	} else if(methodNumber==4){
		rename("Method 4");
		setLocation(locx, locy4, imSz, imSz);
	}
}



function ensureBinary(countsAllowed, thresh0, thresh1){
	for(waitCount = 0;waitCount<countsAllowed; waitCount++){
		if(is("binary")==true){
			waitCount = countsAllowed;
		} else {
			print("Waiting for the image to become binary");
			if(waitCount%2==0){
				close("ensureBonary1");
				selectWindow("ensureBinary0")
				run("Duplicate...")
				rename("ensureBinary1");
				setAutoThreshold("Default");
				setThreshold(thresh0, thresh1);
				setForegroundColor(255, 255, 255);
				setBackgroundColor(0, 0, 0);
				setOption("BlackBackground", true);
				call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
				run("Convert to Mask");
			}
		}
	}
}



function removeExistingFile(filname){
	fileFlag = File.exists(filname);
	if(fileFlag==1){
		js2 = File.delete(filname);
	}
}



function getMicronsPerPixel(fileName){
        open(fileName);
        setVoxelSize(1, 1, 1, "pixel"); // this line was added all over the program to ensure that all unis of space are pixel, and this line ensures consisency
        print("space units are forced to be pixel");
        rename("pxFile");
        getPixelSize(unit, pw, ph, pd);
        micronsPerPix = pw;
        close("pxFile");

        return micronsPerPix;
}






function readInputFile(inputFile, numOrString){
	
	f = File.openAsString(inputFile);
	rows = split(f, "\n");
	if(rows.length==0){
		exit("File "+inputFile+" is empty");
	}
	cols = split(rows[0],"\t");
	outArray = newArray(cols.length);
	longString = "";
	for(i=0;i<cols.length;i++){
		if(numOrString=="num"){
			outArray[i] = parseFloat(cols[i]);
			longString = longString+"  "+d2s(outArray[i],0);
		} else if (numOrString=="string"){
			outArray[i] = cols[i];
			longString = longString+"  "+ outArray[i];
		}
	}
	
	print("Stored Input: "+longString);
	return outArray;
}














function getIncrementIndex(fileFolders, listVar){

    outIndices = newArray(3);

	// create a list of the array
	for(i=0;i<listVar.length;i++){
		List.set(listVar[i], d2s(i,0));
	}

	if(fileFolders=="Folders"){
		chosenFolder1 = 0;
		chosenFoldern = listVar.length -1; j = listVar.length;
		for(i=0;i<j;i++){
			if(listVar[i]=="phs/"){
				chosenFolder1 = i;
				chosenFoldern = i;
				j = 0;
			}
		}
		if(j==0){ // no need to ask user for anything assume phs folder for segmentation
	        outIndices[0] = chosenFolder1;
	        outIndices[1] = 1;
	    	outIndices[2] = chosenFoldern+1;
		} else {
			title = "There are "+d2s(listVar.length,0)+" folders (for AcTrM data, choose just the 'phs' folder)";
			setBatchMode(false);
			Dialog.create(title);
			Dialog.addChoice("Staring folder number = ", listVar, listVar[chosenFolder1]);
			Dialog.addNumber("Folder number increment = ", 1);
			Dialog.addChoice("Ending folder number = ", listVar, listVar[chosenFoldern]);
			js = Dialog.show();
			title = Dialog.getString();
	        js = Dialog.getChoice();
	        outIndices[0] = parseInt(List.get(js));
	        outIndices[1] = Dialog.getNumber();
	    	js = Dialog.getChoice();
	    	outIndices[2] = parseInt(List.get(js))+1;		
			setBatchMode(true);	
		}
	} else if(fileFolders=="Files"){
    	outIndices[0] = 1;
	}

	return outIndices;
}





function getSizeOfARegion(flname, drawMessage){
	run("Image Sequence...", "dir="+flname+" sort");
	setVoxelSize(1, 1, 1, "pixel");
	rename("inputIm");
	setTool("polygon");
	
	waitForUser(drawMessage);
	
	run("Set Measurements...", "area redirect=inputIm decimal=6");
	run("Clear Results");
	run("Measure");
	input = getResult("Area", 0);
	close("inputIm");
	
	return input;
}



	



function welcomeMessage_msm(){
	m1 = "<br><br><br><br><h1>AnViM - 1.0</h1>";
	m0 = "This program was developed by the members of Integrative Mechanobiology Laboratory <br>Department of Pharmacology, Center for Lung Biology <br>University of South Alabama <br>For questions/comments/requests, contact Dhananjay T. Tambe (dtambe@southalabama.edu)";
	m2 = "<h3>Important notes:</h3>";
	m3 = "* Do not have space in any of the folder names in the path<br>";
	m4 = "* File name for the grid data should start with same name as the phase contrast files and should have unique string seperated by single underscore, e.g., phase file is phs0001.tif and data file is phs0001_velocity.dat<br>";
	m5 = "* Parameters for prestress calculation: Youngs Modulus = 1GPa, Poisson's ratio = 0.5, cell height = 5 microns (for justification, see Tambe et al, PLoS One 2013)<br>";
	m6 = "* There should be only one continuous sheet (with holes identified in images from 'bwImages/' folder, multiple disconnected domains must be analyzed separately<br>";
	m7 = "* There will be 20% cutoff from the boundary for each boundary that has cells crossing it<br>";
	m8 = "* In the CSV file, the variables that begin with NBR are the properties of the neighboring region of the cell (default size of 60 pixels around the cell boundary is considered for this analysis. Analysis is also limited by the white region of the bwImage for that time point<br>";
	m9 = "<br>";
	m10 = "<h3>Locations and contents of important files:</h3>";
	m11 = "<b>Wound healing rate:</b><tt>p*/phs/textResults/frameNum_percentHealed.txt</tt> <br>Two columns: frame number, percent area occupied by cells";
	m12 = "<br><br><b>Properties of each cell identified by segmentation:</b><br><tt>p*/phs/textResults/*.csv</tt> <br>Columns:	Centroid X(pixel),	centroid Y(pixel),	Area (pixel squre), Perimeter (pixels),		Circularity,	Aspect Ratio,	Roundity, 	Solidity <br>Rows: Cell 1, Cell 2, .....";
	m13 = "<br><br><b>Output of the MSM software:</b><br><tt>p*/prestress/*_prestress.dat</tt><br>Columns: 	sxx(Pa), syy(Pa), sxy(Pa), maxP(Pa), minP(Pa), maxPex(unitless), maxPey(unitless), strainEnergy(Joules)";
	m14 = "<br><br><b>Input to the MSM software:</b><br><tt>p*/prestress/*_bforce.dat</tt><br>Columns: 	tx(Pa), ty(Pa)";
	m15 = "<br><br><b>Coordinates of nodes for MSM calculations:</b><br><tt>p*/prestress/*node_coords.dat</tt><br>Columns: 	x(meters), y(meters)";
	m16 = "<br><br><b>All forces on a regularly spaced grid points</b><br><tt>p*/prestress/*_allForces.dat</tt><br>Columns: 	x(pix), y(pix), tx(Pa), ty(Pa), sxx(Pa), syy(Pa), sxy(Pa), maxP(Pa), minP(Pa), maxPex(unitless), maxPey(unitless), strainEnergy(Joules)";
	m17 = "<br><br><b>Hydrogel displacements and monolayer motion, respectively</b><br>Location: <tt>p*/displacement/*_disp.dat</tt> or <tt>p*/velocity/*_vel.dat</tt><br>Columns: x(pixel), y(pixel), u(pix/successive frame), v(pix/successive frame), speed(pix/successive frame), matching, similar for second peak";
	m18 = "<br><br><b>Output of the FTTM calculations:</b><br>Location: <tt>p*/traction/*_trac.dat</tt><br>Columns: 	x(pix), y(pix), tx(Pa), ty(Pa)";
	m19 = "<br><br><b>File indicating MSM program where there are cells:</b><br>Location: <tt>p*/traction/*_domain.dat</tt><br>A linear array of each pixel of the image arranged column-wise containing 1 if the pixel is occupied by a cell and 0 of otherwise. It is built from <tt>p*/phs/bwImages/*.tif</tt>";
	m20 = "<br><br><b>Files to check the quality of segmentation:</b><br>Location: <tt>p*/phs/segmentedImages/cellPropMaps/*_merged.tif</tt>";
	m21 = "<br><br><b>Output of 'Results - track data':</b><br>Location: <tt>p*/phs/textResults/cellTimeTrace_*.tif</tt>";
	m22 = "<br><br><b>Output of 'Results - plot':</b><br>Location: <tt>p*/phs/trackedDataPlots/*.tif</tt>";
	m23 = "<br><br><b>Output of 'Results - pictures':</b><br>Location: <tt>phs/segmentedImages/cellPropMaps/*_Circ..tif</tt>";
	m24 = "<br><br><b>Scalebar for the pictures from 'Results - pictures':</b><br>Location: <tt>p*/phs/segmentedImages/cellPropMaps/*_genericScaleBar.tif</tt>";
	m25 = "<br><br><b>Min/Max of above scalebar and other statistics of the pictures from 'Results - pictures':</b> <br>Location: <tt>p*/phs/textResults/*_statistics.txtReference</tt>";
	showMessage("AnViM", "<html>"+m0+m1+m2+m3+m4+m5+m6+m7+m8+m9+m10+m11+m12+m13+m14+m15+m16+m17+m18+m19+m20+m21+m22+m23+m24+m25+"</html>");
}










function readGridVar(workDir,gridVarInput){

	// inputS[0] = directory
	// inputS[1] = filename
	// inputS[2] = gridSize 
	// inputS[3] = linked list of which headers are to be used
	// inputS[4] = labels for those headers
	// inputS[5] = save the images immediately ... this will make the process slow, it can be done with saving of all the celled images there it will be done with colors, so no need to do it here
	// inputS[6] = flag to do the conversion of text to image
	// inputS[7] = formulae, 
	// inputS[8] = varA, 
	// inputS[9] = varB

	f = File.openAsString(workDir+gridVarInput);
	inputS = split(f, "\n");
	return inputS;

}





function saveGridVar(workDir, gridVarInput, inputS, gridType, formulae, varA, varB){ // do not save last element of inputS

	removeExistingFile(workDir+gridVarInput);
	f = File.open(workDir+gridVarInput);
	for(i=0;i<inputS.length;i++){// do not write last element of inputS
		print(f, inputS[i]);
	}

	print(f, gridType);

	if(formulae.length>0){
		js = formulae[0];
		for(i=1;i<formulae.length;i++){
			js = js + " "+formulae[i];
		}
		print(f, js);
	
		js = d2s(varA[0],0);
		for(i=1;i<varA.length;i++){
			js = js + " " + d2s(varA[i],0);
		}
		print(f, js);
	
		js = d2s(varB[0],0);
		for(i=1;i<varB.length;i++){
			js = js +" "+ d2s(varB[i],0);
		}
		print(f, js);
	}
	File.close(f);	

}








function make_RGB_matrix(npoints){
	
	r=newArray(npoints);g=newArray(npoints);b=newArray(npoints);
	for (j=0; j<npoints; j++){
		i4=4*j/npoints;
		r[j]=255*minOf(maxOf(minOf(i4-1.5,-i4+4.5),0),1);
		g[j]=255*minOf(maxOf(minOf(i4-0.5,-i4+3.5),0),1);
		b[j]=255*minOf(maxOf(minOf(i4+0.5,-i4+2.5),0),1);
	}
	rgbmat = Array.concat(r,g);
	rgbmat = Array.concat(rgbmat,b);

	return rgbmat;
}



function make_hex_matrix(npoints,alphaVal){

	al = toHex(255*alphaVal/100);
	sal = toString(al); if(lengthOf(sal)==1) sal = "0"+sal;

	hexMat = newArray(npoints);
	rgbMat = make_RGB_matrix(npoints);
	for(i=0;i<npoints;i++){
		r = rgbMat[i]; g = rgbMat[i+npoints]; b = rgbMat[i+npoints*2];
		
		sr = toString(r); if(lengthOf(sr)==1) sr = "0"+sr;
		sg = toString(g); if(lengthOf(sg)==1) sg = "0"+sg;
		sb = toString(b); if(lengthOf(sb)==1) sb = "0"+sb;
		
		hexMat[i] = "#" + sal + sr + sg + sb;
	}
	
	return hexMat;
}








function plotTrackedData(){
	trackedPlotFolder = "trackedDataPlots/";
	workDir = getDirectory("Choose the 'phs/textResults' folder (containing tracked cell data)");
	js = File.makeDirectory(workDir+"../"+trackedPlotFolder);
	
	foldrNames = split(workDir,"/");
	foldr = foldrNames[foldrNames.length-2];
	unbrokenOnly = getBoolean("Limit the plotting to cells with unbroken tracks?");
	if(unbrokenOnly==1){
		open(workDir+"cellIDsWithUnbrokenTrack.csv");
		heads = Table.headings;
		close("cellIDsWithUnbrokenTrack.csv");
	} else {
		print("Opening cellTimeTrace_Area.csv");
		open(workDir+"cellTimeTrace_Area.csv");
		heads = Table.headings;
		close("cellTimeTrace_Area.csv");
	}
	headings = split(heads,"\t");
	headings = Array.slice(headings,1,headings.length);
	if(headings.length==0){
		print("!!! No unbroken cell track for this dataset !!!");
		showMessage("!!! No unbroken cell track for this dataset !!!");
	} else {
		Array.print(headings);
		allFnames = startsWith_file_dir_list(workDir, "cellTimeTrace_");
		setBatchMode(false);
		Dialog.create("Choices for plotting tracked cell data");
		Dialog.addNumber("Number of variables on one plot (1-3)", 3);
		js = Dialog.show();
		nvarplot = Dialog.getNumber();
		fnames = newArray(nvarplot);
		
		Dialog.create("Choices for plotting tracked cell data");
		for(i=0;i<nvarplot;i++){
			Dialog.addChoice("Var"+d2s(i+1,0)+":", allFnames);
		}
		js = Dialog.show();
		for(i=0;i<nvarplot;i++){
			fnames[i] = Dialog.getChoice();
			print(fnames[i]);
		}
		setBatchMode(true);
		
		
		if(nvarplot==3){
			open(workDir+fnames[0]);
			open(workDir+fnames[1]);
			open(workDir+fnames[2]);
		} else if(nvarplot==2){
			open(workDir+fnames[0]);
			open(workDir+fnames[1]);
		} else {
			open(workDir+fnames[0]);
		}
		
		for(cellnum = 0; cellnum<headings.length; cellnum++){
			print("Going for "+d2s(cellnum+1,0)+" of "+d2s(headings.length,0)+" cells");
			cellID = headings[cellnum];
			
			//print(cellID);
			if(nvarplot==3){
				Plot.create("cellTrackedData", "t (frame number)", "arbitrary units");
				var1 = Table.getColumn(cellID, fnames[0]);
				var2 = Table.getColumn(cellID, fnames[1]);
				var3 = Table.getColumn(cellID, fnames[2]);
				var01 = Array.copy(var1);
				var02 = Array.copy(var2);
				var03 = Array.copy(var3);
				Array.getStatistics(var1, v1min, v1max, v1mean, v1stdDev);
				Array.getStatistics(var2, v2min, v2max, v2mean, v2stdDev);
				Array.getStatistics(var3, v3min, v3max, v3mean, v3stdDev);
				range = newArray(abs(v1max-v1min), abs(v2max-v2min), abs(v3max-v3min));
				Array.getStatistics(range, rmin, rmax, rmean, rstdDev);
				for(j=0;j<var1.length;j++){
					if(!isNaN(var1[j])){
						var1[j] = var1[j]*rmax/range[0];
					}
					if(!isNaN(var2[j])){
						var2[j] = var2[j]*rmax/range[1];
					}
					if(!isNaN(var3[j])){
						var3[j] = var3[j]*rmax/range[2];
					}
				}
								
				Plot.add("Circle", var1);
				Plot.setStyle(0, "red,red,1.0,Circle");
				Plot.add("Circle", var2);
				Plot.setStyle(1, "blue,blue,1.0,Circle");
				Plot.add("Circle", var3);
				Plot.setStyle(2, "green,green,1.0,Circle");
				Plot.setLimits(NaN,NaN,NaN,NaN);
				Plot.addLegend(replace(replace(fnames[0],"cellTimeTrace_",""),".csv","")+"\n"+replace(replace(fnames[1],"cellTimeTrace_",""),".csv","")+"\n"+replace(replace(fnames[2],"cellTimeTrace_",""),".csv","")+"\n", "Auto");
				outputFileName = replace(replace(fnames[0],"cellTimeTrace_",""),".csv","")+"_"+replace(replace(fnames[1],"cellTimeTrace_",""),".csv","")+"_"+replace(replace(fnames[2],"cellTimeTrace_",""),".csv","")+"_"+foldr+"-"+replace(cellID,"cell","");

				Table.create("saveArray");
				Table.setColumn(replace(replace(fnames[0],"cellTimeTrace_",""),".csv",""),var01);
				Table.setColumn(replace(replace(fnames[1],"cellTimeTrace_",""),".csv",""),var02);
				Table.setColumn(replace(replace(fnames[2],"cellTimeTrace_",""),".csv",""),var03);
				Table.save(workDir+"../"+trackedPlotFolder+outputFileName+".csv");
				close("saveArray");
			} else if(nvarplot==2){
				Plot.create("cellTrackedData", "t (frame number)", "arbitrary units");
				var1 = Table.getColumn(cellID, fnames[0]);
				var2 = Table.getColumn(cellID, fnames[1]);
				var01 = Array.copy(var1);
				var02 = Array.copy(var2);
				Array.getStatistics(var1, v1min, v1max, v1mean, v1stdDev);
				Array.getStatistics(var2, v2min, v2max, v2mean, v2stdDev);
				range = newArray(abs(v1max-v1min), abs(v2max-v2min));
				Array.getStatistics(range, rmin, rmax, rmean, rstdDev);
				for(j=0;j<var1.length;j++){
					if(!isNaN(var1[j])){
						var1[j] = var1[j]*rmax/range[0];
					}
					if(!isNaN(var2[j])){
						var2[j] = var2[j]*rmax/range[1];
					}
				}
				
				Plot.add("Circle", var1);
				Plot.setStyle(0, "red,red,1.0,Circle");
				Plot.add("Circle", var2);
				Plot.setStyle(1, "blue,blue,1.0,Circle");
				Plot.setLimits(NaN,NaN,NaN,NaN);
				Plot.addLegend(replace(replace(fnames[0],"cellTimeTrace_",""),".csv","")+"\n"+replace(replace(fnames[1],"cellTimeTrace_",""),".csv","")+"\n", "Auto");
				outputFileName = replace(replace(fnames[0],"cellTimeTrace_",""),".csv","")+"_"+replace(replace(fnames[1],"cellTimeTrace_",""),".csv","")+"_"+foldr+"-"+replace(cellID,"cell","");

				Table.create("saveArray");
				Table.setColumn(replace(replace(fnames[0],"cellTimeTrace_",""),".csv",""),var01);
				Table.setColumn(replace(replace(fnames[1],"cellTimeTrace_",""),".csv",""),var02);
				Table.save(workDir+"../"+trackedPlotFolder+outputFileName+".csv");
				close("saveArray");
			} else {
				Plot.create("cellTrackedData", "t (frame number)", "actual units");
				var1 = Table.getColumn(cellID, fnames[0]);
				var01 = Array.copy(var1); // not needed but kept here for consistency
				Plot.add("Circle", var1);
				Plot.setStyle(0, "red,red,1.0,Circle");
				Plot.setLimits(NaN,NaN,NaN,NaN);
				Plot.addLegend(replace(replace(fnames[0],"cellTimeTrace_",""),".csv","")+"\n", "Auto");	
				outputFileName = replace(replace(fnames[0],"cellTimeTrace_",""),".csv","")+"_"+foldr+"-"+replace(cellID,"cell","");

				Table.create("saveArray");
				Table.setColumn(replace(replace(fnames[0],"cellTimeTrace_",""),".csv",""),var01);
				Table.save(workDir+"../"+trackedPlotFolder+outputFileName+".csv");
				close("saveArray");
			}
			Plot.show;
			selectWindow("cellTrackedData");

			Plot.makeHighResolution(outputFileName,4.0);
			selectWindow(outputFileName);
			run("Scale...", "x=.25 y=.25 width=613 height=355 interpolation=Bilinear average create"); // creates a low resolution image
			rename("shrunk");
			print("Saving "+workDir+"../"+trackedPlotFolder+outputFileName+".tif");
			saveAs("Tiff", workDir+"../"+trackedPlotFolder+outputFileName+".tif");
			close(outputFileName+".tif");
			close("cellTrackedData");
			close("shrunk");
			close("*");
		}
		
		if(nvarplot==3){
			close(fnames[0]);
			close(fnames[1]);
			close(fnames[2]);
		} else if(nvarplot==2){
			close(fnames[0]);
			close(fnames[1]);
		} else {
			close(fnames[0]);
		}
	}

	print("---> Finished making plots! Output: 'analysis/p*/phs/trackedDataPlots/'");
	showMessage("Finished making plots! Output: 'analysis/p*/phs/trackedDataPlots/'");
}






function startsWith_file_dir_list(dir, fType){ // fType =  "/" or ".tif"

	files = getFileList(dir);

	fileNames = newArray();
	//count = 0;
	//for (i=0; i<files.length; i++) {
	//	//flagFtype[i] = false;
	//	if(startsWith(files[i],fType)) count++; //flagFtype[i] = true;
	//}
	//fileNames = newArray(count);
	
	//count = 0;
	for(i=0;i<files.length;i++){
		if(startsWith(files[i],fType)) {
			fileNames = Array.concat(fileNames,files[i]);
			//fileNames[count] = files[i];
			//count++;
		}
	}
	
	return fileNames;
}



function preprocess_MSM(){
	
	workDir = getDirectory("Choose the Directory that contains tnimgs or analysis folder");
	dataDir = workDir+"tnimgs/";
	outDir = workDir+"analysis/";
	userChoiceFile = "analysisChoices.txt";
	shiftFname="part_shift_values_pixel_degree.dat";
	skipAnaFname = "skipAnalysis.txt";
	js = File.makeDirectory(outDir);

//make sure that the image files are within 'folder/analysis/p0/phs/'

	// check if the user input is stored, if it is, prompt to reuse that input
	if(!File.exists(dataDir)) {
		print("Assuming that "+userChoiceFile+" file exists");
	}
	reuseFlag = 0;
	if(File.exists(outDir+userChoiceFile)){
		ff = File.openAsString(outDir+userChoiceFile);
		jjrows = split(ff, "\n");
		Array.print(jjrows);

		reuseFlag = getBoolean("Reuse the existing 'analysisChoices.txt' for preprocessing?", "Yes", "No");
	}
	if(reuseFlag){
		js = File.openAsString(outDir+userChoiceFile);
		jsl = split(js, "\n");
		js = split(jsl[0],"\t");
		nChannels=parseInt(js[0]); nPositions=parseInt(js[1]); nTimePoints=parseInt(js[2]);
		js = split(jsl[1],"\t");
		phaseChan=js[0]; bigBeadChan=js[1]; tnyBeadChan=js[2]; 
		js = split(jsl[2],"\t");
		moveFilesToPosFolder=parseInt(js[0]); doTransRot=parseInt(js[1]); cropNSaveInPosFolder=parseInt(js[2]); 
		js = split(jsl[3],"\t");
		allowableShift=parseInt(js[0]); allowableRotation=parseInt(js[1]);
		bcond = jsl[4];
		pixSz = parseFloat(jsl[5]);
	} else {
		
		files =  endsWith_file_dir_list(dataDir, ".tif");
		fileSettings = get_nChan_nPos_nTime(files);
	
		nChannels = fileSettings[0]+1;
		nPositions = fileSettings[1]+1;
		nTimePoints = fileSettings[2]+1;
	
		chanLabel = newArray(1);
		chanLabel[0] = "Channel 0";
		for(i=1;i<nChannels;i++){
			chanLabel = Array.concat(chanLabel, "Channel "+d2s(i,0));
		}

		// UPDATE: commented June 19, 2020 to allow references images that are of different size than the tny images (this allows cell-free paort to serve as a reference part)
		setBatchMode(false);
		Dialog.create("Indicate channels and choose actions");
		Dialog.addChoice("Transmitted light image: ", chanLabel, chanLabel[0]);
		Dialog.addChoice("Bottom beads image: ", chanLabel, chanLabel[0]);
		Dialog.addChoice("Top beads image: ", chanLabel, chanLabel[0]);
		Dialog.addCheckbox(" - Move files to the position folder", true);
		Dialog.addCheckbox(" - Do additional correction for rigid motion", true);
		Dialog.addCheckbox(" - Crop data and save in position folder", true);
		Dialog.addNumber("Preexisting shift must be < ", 50, 0, 3, "pixels");
		Dialog.addNumber("Preexisting rotation must be < ", 5, 0, 3, "degrees");
		Dialog.addNumber("Pixel size (20X-0.32531): ", 0.65062, 5, 12, " microns");
		Dialog.addMessage("In the data, cells exist across which sides of the image?");
		js = newArray("- LEFT", "- RIGHT", "- TOP", "- BOTTOM");
		js1 = newArray(true, true, true, true);
		Dialog.addCheckboxGroup(1,4, js, js1);
		Dialog.addMessage("NOTE: These choices will applied to all positions. \nIn particular, rotate the images if necessary.");
		js = Dialog.show();
		js = Dialog.getChoice();
		phaseChan = parseInt(replace(js, "Channel ", ""));
		js = Dialog.getChoice();
		bigBeadChan = parseInt(replace(js, "Channel ", ""));
		js = Dialog.getChoice();
		tnyBeadChan = parseInt(replace(js, "Channel ", ""));
		moveFilesToPosFolder = Dialog.getCheckbox();
		doTransRot = Dialog.getCheckbox();
		cropNSaveInPosFolder = Dialog.getCheckbox();
		allowableShift = Dialog.getNumber();
		allowableRotation = Dialog.getNumber();
		pixSz = Dialog.getNumber();
		print("pixelSize="+d2s(pixSz,5));
		leftFlag = Dialog.getCheckbox();
		rightFlag = Dialog.getCheckbox();
		topFlag = Dialog.getCheckbox();
		bottomFlag = Dialog.getCheckbox();
		setBatchMode(true);
		
		if(leftFlag==1 && rightFlag==1 && topFlag==1 && bottomFlag==1){
			bcond = "allFour";
		} else if(leftFlag==0 && rightFlag==0 && topFlag==0 && bottomFlag==0){
			bcond = "none"; 
		} else if(leftFlag==0 && rightFlag==0 && topFlag==1 && bottomFlag==1){
			bcond = "topBottom"; 
		} else if(leftFlag==1 && rightFlag==1 && topFlag==0 && bottomFlag==0){
			bcond = "leftRight";
		} else if(leftFlag==1 && rightFlag==0 && topFlag==1 && bottomFlag==1){
			bcond = "leftTopBottom";
		} else if(leftFlag==0 && rightFlag==1 && topFlag==1 && bottomFlag==1){
			bcond = "rightTopBottom";
		} else if(leftFlag==1 && rightFlag==1 && topFlag==1 && bottomFlag==0){
			bcond = "topLeftRight";
		} else if(leftFlag==1 && rightFlag==1 && topFlag==0 && bottomFlag==1){
			bcond = "bottomLeftRight";
		} else if(leftFlag==1 && rightFlag==0 && topFlag==0 && bottomFlag==1){
			bcond = "leftTopBottom";
		} else if(leftFlag==1 && rightFlag==0 && topFlag==1 && bottomFlag==0){
			bcond = "leftTopBottom";
		} else if(leftFlag==0 && rightFlag==1 && topFlag==1 && bottomFlag==0){
			bcond = "rightTopBottom";
		} else if(leftFlag==0 && rightFlag==1 && topFlag==0 && bottomFlag==1){
			bcond = "rightTopBottom";
		}
		close("jimg");

		bcondOut = fixImages(bcond,dataDir); // get this function to work on c0_p0_t0 and p0/phs/

		// store the numbers
		f = File.open(outDir+userChoiceFile);
		print(f, d2s(nChannels,0) +"\t"+ d2s(nPositions,0) +"\t"+	d2s(nTimePoints,0));
		print(f, phaseChan + " \t" + bigBeadChan + "\t" + tnyBeadChan);
		print(f, moveFilesToPosFolder + " \t" + doTransRot + "\t" + cropNSaveInPosFolder);
		print(f, d2s(allowableShift,0) + " \t" + d2s(allowableRotation,0));
		print(f, bcondOut);
		print(f, d2s(pixSz,5));
		File.close(f);
	}
	
	setBatchMode(true);
	
	if(moveFilesToPosFolder==true){
		// clean up the images
		for(ipos=0; ipos<nPositions; ipos++){
			print("Going for position "+d2s(ipos,0)+" of "+d2s(nPositions,0));
			for(ichan=0; ichan<nChannels; ichan++){
				chanPos = "c"+d2s(ichan,0)+"_p"+d2s(ipos,0)+"_t";
				opnFl = dataDir;
				/*if(File.exists(dataDir+chanPos+"0.tif")){
					chanPos = chanPos+"0.tif"; // updated imagej requires directory only
				} else if(File.exists(dataDir+chanPos+"00.tif")){
					chanPos = chanPos+"00.tif"; // updated imagej requires directory only
				} else if(File.exists(dataDir+chanPos+"000.tif")){
					chanPos = chanPos+"000.tif"; // updated imagej requires directory only
				} else {
					chanPos = chanPos+"0000.tif"; // updated imagej requires directory only
				}*/

				// make sure that the filename matches the label name
				lstNFls = startsWith_file_dir_list(dataDir, chanPos);
				for(i=0; i<lstNFls.length; i++){
					open(dataDir+lstNFls[i]);
					run("Set Label...", "label="+lstNFls[i]);
					run("Save");
					close();
				}
				
				if(ichan==phaseChan){
					run("Image Sequence...", "dir="+opnFl+" filter="+chanPos+" sort");
					rename("imSeq");
					//run("16-bit");
					run("Image Sequence... ", "dir="+outDir+" format=TIFF name=0 use");
					close("*");
				} else if(ichan==bigBeadChan){
					setBatchMode(false);
					run("Image Sequence...", "dir="+opnFl+" filter="+chanPos+" sort");
					run("Brightness/Contrast...");

					Dialog.createNonBlocking("Adjust contrast");
					Dialog.addMessage("Adjust brightness/contrast so that beads appear prominently");
					Dialog.addMessage("Try 'Auto' button, if that does not work drag 'Maximum' slider");
					Dialog.addMessage("After sliding, Click OK");
					Dialog.setLocation(0,0);
					js = Dialog.show();
					run("Apply LUT", "stack");
					setBatchMode(true);
					
					//run("16-bit");
					run("Image Sequence... ", "dir="+outDir+" format=TIFF name=0 use");
					close("*");
				} else if(ichan==tnyBeadChan){	
					run("Image Sequence...", "dir="+opnFl+" filter="+chanPos+" sort");
					//run("16-bit");
					run("Image Sequence... ", "dir="+outDir+" format=TIFF name=0 use");
					close("*");
				} else {
					run("Image Sequence...", "dir="+opnFl+" filter="+chanPos+" sort");
					run("Image Sequence... ", "dir="+outDir+" format=TIFF name=0 use");
					close("*");			
				}
			}	
		}
	
	
	
		// move the files to position folder
		for(ipos=0; ipos<nPositions; ipos++){
			for(ichan=0; ichan<nChannels; ichan++){
				chanPos = "c"+d2s(ichan,0)+"_p"+d2s(ipos,0)+"_t";
				for(itime=0; itime<nTimePoints; itime++){
					// make directories
					posDir = outDir+"/p"+d2s(ipos,0)+"/";
					if(ichan==phaseChan){
						dirPath = posDir+"cels/";	
					} else if(ichan==bigBeadChan){
						dirPath = posDir+"refs/";
					} else if(ichan==tnyBeadChan){
						dirPath = posDir+"defs/";
					} else {
						dirPath = posDir+"otherTag/";
					}
					js = File.makeDirectory(posDir);
					js = File.makeDirectory(dirPath);
					if(File.exists(outDir+chanPos+d2s(itime,0)+".tif")){
						path1 = outDir+chanPos+d2s(itime,0)+".tif";
					} else if(File.exists(outDir+chanPos+"0"+d2s(itime,0)+".tif")){
						path1 = outDir+chanPos+"0"+d2s(itime,0)+".tif";
					} else if(File.exists(outDir+chanPos+"00"+d2s(itime,0)+".tif")){
						path1 = outDir+chanPos+"00"+d2s(itime,0)+".tif";
					} else if(File.exists(outDir+chanPos+"000"+d2s(itime,0)+".tif")){
						path1 = outDir+chanPos+"000"+d2s(itime,0)+".tif";
					}
					//print(path1);
					
					js = getnumString(itime);
					path2 = dirPath+js+".tif";
					
					// move files to those directories			
					js = File.rename(path1, path2);
				}
			}
		}
	}
	
	setBatchMode(true);


	
	width = 0;
	height = 0;
	// correct the remaining translation and rotation
	for(ipos=0; ipos<nPositions; ipos++){
		print("Computing drift for position "+d2s(ipos,0));
		posDir = outDir+"p"+d2s(ipos,0)+"/";
		
		
		if(File.exists(posDir+shiftFname)==1){
			js = File.delete(posDir+shiftFname);
		}
		f=File.open(posDir+shiftFname);

		skipAnalysis = newArray(nTimePoints);
		for(i=0;i<nTimePoints;i++){
			skipAnalysis[i] = 0;
		}
		// ensure file label is same as filename for itime = 0
		open(posDir+"refs/0000.tif");
		run("Set Label...", "label=0000.tif");
		run("Save");
		close();
		open(posDir+"defs/0000.tif");
		run("Set Label...", "label=0000.tif");
		run("Save");
		close();
		open(posDir+"cels/0000.tif");
		run("Set Label...", "label=0000.tif");
		run("Save");
		close();

		for(itime=1; itime<nTimePoints; itime++){
			refFname = "0000.tif";

			if(ipos==0 && itime==1) {
				open(posDir+"refs/"+refFname);
				width = getWidth();
				height = getHeight();
				close(refFname);
			}

			js = getnumString(itime);
			curFname = js+".tif";
			
			refFile = posDir+"refs/"+refFname;
			curFile = posDir+"refs/"+curFname;

			if(doTransRot==true){
				// adapted from the resources provided by the TurboReg makers
				run("TurboReg ",
					"-align " // Register the two images that we have just prepared.
					+ "-file " + refFile + " " // Source (window reference).
					+ "0 0 " + (width - 1) + " " + (height - 1) + " " // No cropping.
					+ "-file " + curFile + " "// Target (file reference).
					+ "0 0 " + (width - 1) + " " + (height - 1) + " " // No cropping.
					+ "-rigidBody " // This corresponds to rotation and translation.
					+ (width / 2) + " " + (height / 2) + " " // Source translation landmark.
					+ (width / 2) + " " + (height / 2) + " " // Target translation landmark.
					+ "0 " + (height / 2) + " " // Source first rotation landmark.
					+ "0 " + (height / 2) + " " // Target first rotation landmark.
					+ (width - 1) + " " + (height / 2) + " " // Source second rotation landmark.
					+ (width - 1) + " " + (height / 2) + " " // Target second rotation landmark.
					+ "-showOutput"); // In case -hideOutput is selected, the only way to
					// retrieve the registration results is by the way of another plugin.
				
				sourceX0 = getResult("sourceX", 0); // First line of the table.
				sourceY0 = getResult("sourceY", 0);
				targetX0 = getResult("targetX", 0);
				targetY0 = getResult("targetY", 0);
				sourceX1 = getResult("sourceX", 1); // Second line of the table.
				sourceY1 = getResult("sourceY", 1);
				targetX1 = getResult("targetX", 1);
				targetY1 = getResult("targetY", 1);
				sourceX2 = getResult("sourceX", 2); // Third line of the table.
				sourceY2 = getResult("sourceY", 2);
				targetX2 = getResult("targetX", 2);
				targetY2 = getResult("targetY", 2);
				dx0 = targetX0 - sourceX0;
				dy0 = targetY0 - sourceY0;
				translation = sqrt(dx0 * dx0 + dy0 * dy0); // Amount of translation, in pixel units.
				
				dx = sourceX2 - sourceX1;
				dy = sourceY2 - sourceY1;
				sourceAngle = atan2(dy, dx);
				dx = targetX2 - targetX1;
				dy = targetY2 - targetY1;
				targetAngle = atan2(dy, dx);
				rotation = (targetAngle - sourceAngle)*180.0/PI; // Amount of rotation, in radian units.
				print("Amount of translation [pixel]: " + translation);
				print("Amount of rotation [degree]: " + rotation);
			} else {
				dx0 = 0;
				dy0 = 0;
				translation = 0;
				rotation = 0;
			}
			close("*");
	

			if((abs(translation)>allowableShift) || (abs(rotation)>allowableRotation)){
				skipAnalysis[itime] = 1;
			}
			
			// sign flipped to recover the drift
			dx0 = -1.0*dx0;
			dy0 = -1.0*dy0;
			rotation = -1.0*rotation;

			print(f, dx0 + " \t" + dy0 + "\t" + rotation);
			
			for(ichan=0;ichan<nChannels;ichan++){
				if(ichan==phaseChan){
					dirPath = posDir+"cels/";	
				} else if(ichan==bigBeadChan){
					dirPath = posDir+"refs/";
				} else if(ichan==tnyBeadChan){
					dirPath = posDir+"defs/";
				} else {
					dirPath = posDir+"otherTag/";
				}
				
				curFile = dirPath+curFname;
				open(curFile);
				// make sure that the filename matches the label name
				run("Set Label...", "label="+curFname);
				run("Translate...", "x=" + dx0 + " y=" + dy0 + " interpolation=Bicubic");
				run("Rotate... ", "angle="+ rotation +" grid=1 interpolation=Bicubic");
				saveAs("Tiff", curFile); // OVERWRITE THE FILE
				close();
			}
		}
		File.close(f);

		f=File.open(posDir+skipAnaFname);
		for(itime=0;itime<nTimePoints; itime++){
			print(f, skipAnalysis[itime]);
		}
		File.close(f);
		
	}
	
	
	if(cropNSaveInPosFolder==true){
		// crop files using max value of drift and save it in parallel folders for parallel python processing
		// find max change
		// correct the remaining translation and rotation

		for(ipos=0; ipos<nPositions; ipos++){
			posDir = outDir+"p"+d2s(ipos,0)+"/";
			skipAnalysis = newArray(nTimePoints);
			str = File.openAsString(posDir+skipAnaFname);
			lines=split(str,"\n");
			skipAnalysis[0] = 0;
			
			for(i=1;i<nTimePoints; i++){
				skipAnalysis[i] = parseInt(lines[i]);
			}
			
			print("Cropping images for position "+d2s(ipos,0));
			str = File.openAsString(posDir+shiftFname);
			lines=split(str,"\n");
		
			maxXVal = 0.0;
			maxYVal = 0.0;
			maxRot = 0.0;
			for(iline=0; iline<lines.length; iline++){
				if(skipAnalysis[iline+1]==0){
					cols = split(lines[iline],"\t");
					if(abs(parseFloat(cols[0]))>maxXVal){
						maxXVal = cols[0];
					}
					if(abs(parseFloat(cols[1]))>maxYVal){
						maxYVal = cols[1];
					}
					if(abs(parseFloat(cols[2]))>maxRot){
						maxRot = cols[2];
					}
				}
			}
			
			print("max X-shift = "+maxXVal);
			print("max Y-shift = "+maxYVal);
			print("max Rotation = "+maxRot);
			
		
			cropSz = 2; // pixels make sure that the rotation and translation does not amount to more than this amount of max change
			if(-floor(-maxXVal)>cropSz){
				cropSz = -floor(-maxXVal);
			}
			if(-floor(-maxYVal)>cropSz){
				cropSz = -floor(-maxYVal);
			}
			print("crop size = "+cropSz);
		
		
			// move the files to position folder
			if(ipos==0) {
				open(posDir+"cels/0000.tif");
				width = getWidth();
				height = getHeight();
				close("0000.tif");
			}

			for(ichan=0; ichan<nChannels; ichan++){
				
				if(ichan!=bigBeadChan){
		
					// make directories
					posDir = outDir+"p"+d2s(ipos,0)+"/";
		
					if(ichan==phaseChan){
						phsDir = posDir+"phs/";
						imDir = posDir+"cels/";
					} else if(ichan==tnyBeadChan){
						phsDir = posDir+"tny/";
						imDir = posDir+"defs/";				
					} else if(ichan!=bigBeadChan && ichan!=tnyBeadChan && ichan!=phaseChan){ // only extra channel images will be stored
						phsDir = posDir+"fluo/";
						imDir = posDir+"otherTag/";	
					}
					
					js = File.makeDirectory(phsDir);
					
					// open image sequence
					run("Image Sequence...", "dir="+imDir+" sort");
					makeRectangle(cropSz, cropSz, width-cropSz*2, height-cropSz*2);
					run("Crop");


					// crop the image to become square
					widthSq = getWidth();
					heightSq = getHeight();
					if(heightSq>widthSq){
						makeRectangle(0,0,widthSq,widthSq);
					} else {
						makeRectangle(0,0,heightSq,heightSq);
					}
					run("Crop");

					
					// VERY IMPORTANT commented lines in the condition statement below are geared to save data for openPIV MPI pattern analysis
					if(ichan==phaseChan){
						run("Image Sequence... ", "format=TIFF name=[] use save="+phsDir);
						close();
						
					} else if(ichan==tnyBeadChan){
						run("Image Sequence... ", "format=TIFF name=[] use save="+phsDir);
						close();
		
					} else if (ichan!=bigBeadChan && ichan!=tnyBeadChan && ichan!=phaseChan){ // only extra channel images will be stored
						run("Image Sequence... ", "format=TIFF name=[] use save="+phsDir);
						close();
					}
				}
			}
		}
	}

	print("---> Finished organizing files! \nOutput: 'analysis/p*/' \n \n \n- Check the alignment of the files in 'phs' or 'tny' folder \n- If not, see if the c*_p*_t*.tif files corresponding to bottom beads need enhancement (0.3, normalize) and cropping \n- Then delete the 'analysis' folder and rerun MSM - pre-processing");
	showMessage("Finished organizing files! \nOutput: 'analysis/p*/' \n \n \n- Check the alignment of the files in 'phs' or 'tny' folder \n- If not, see if the c*_p*_t*.tif files corresponding to bottom beads need enhancement (0.3, normalize) and cropping \n- Then delete the 'analysis' folder and rerun MSM - pre-processing");
}



function get_nChan_nPos_nTime(files){

	letters = split(replace(files[0],".tif",""),"_");
	
	chaLet = substring(letters[0], 0, 1);
	posLet = substring(letters[1], 0, 1);
	timLet = substring(letters[2], 0, 1);

	letters = split(replace(files[0],".tif",""),"_");
	chans = newArray(1); chans[0] = parseInt(replace(letters[0],chaLet,""));
	posns = newArray(1); posns[0] = parseInt(replace(letters[1],posLet,""));
	times = newArray(1); times[0] = parseInt(replace(letters[2],timLet,""));
	for(i=1;i<files.length;i++){
		letters = split(replace(files[i],".tif",""),"_");
		
		chans = Array.concat(chans, parseInt(replace(letters[0],chaLet,"")));
		posns = Array.concat(posns, parseInt(replace(letters[1],posLet,"")));
		times = Array.concat(times, parseInt(replace(letters[2],timLet,"")));

	}

	Array.getStatistics(chans, cmin, cmax, cmean, cstd);
	Array.getStatistics(posns, pmin, pmax, pmean, pstd);
	Array.getStatistics(times, tmin, tmax, tmean, tstd);
	
	fileSettings = newArray(cmax, pmax, tmax);

	print("Detected "+d2s(fileSettings[0]+1,0)+ " Channels, "+d2s(fileSettings[1]+1,0)+" Positions, "+d2s(fileSettings[2]+1,0)+" Times");
	Array.print(fileSettings);
	
	return fileSettings;
}



function calculateDeformation(){
	
	parentDir = getDirectory("Choose the Directory that contains tnimgs or analysis folder");
	dataDir = parentDir+"analysis/";
	dispDir = "displacement/";
	imDir = "tny/";
	dispInputFile = "disp.in"; 
	skipAnaFname = "skipAnalysis.txt";
	userChoiceFile = "analysisChoices.txt";
	
	// check if the user input is stored, if it is, prompt to reuse that input

	if(File.exists(dataDir+userChoiceFile)){
		js = File.openAsString(dataDir+userChoiceFile);
		jsl = split(js, "\n");
		js = split(jsl[0],"\t");
		nChannels=parseInt(js[0]); nPositions=parseInt(js[1]); nTimePoints=parseInt(js[2]);
		js = split(jsl[1],"\t");
		phaseChan=js[0]; bigBeadChan=js[1]; tnyBeadChan=js[2]; 
		bcond = jsl[4];
		pixSz = parseFloat(jsl[5]);
	} else {

		print("Create "+dataDir+userChoiceFile+" with following four lines");
		print("nChannels \\t nPositions \\t nTimePoints");
		print("phaseChan \\t bigBeadChan \\t tnyBeadChan");
		print("moveFilesToPosFolder \\t doTransRot \\t cropNSaveInPosFolder");
		print("allowableShift \\t allowableRotation");
		print("boundaryCondition");
		print("pixelSizeInMicrons");
		exit("Follow the directions from the log and rerun the function");
	}



	// check if input file exist, if it does, ask if one can reuse it


	js = newArray(4);
	js[0] = "128 64 32";
	js[1] = "64 32 16";
	js[2] = "32 16 8";
	js[3] = "16 8 4";
	setBatchMode(false);
	Dialog.create("Parameters for calculating gel deformation");
	Dialog.addChoice("Window sizes: ", js, js[1]);
	Dialog.addNumber("Noise: ", 0.2, 1, 3, "");
	Dialog.addNumber("Threshold: ", 5, 0, 3, "pixels");
	Dialog.addMessage("NOTE: To recalculate, delete the *_disp.dat files");
	js = Dialog.show();
	js = split(Dialog.getChoice()," ");
	win1 = js[0];
	win2 = js[1];
	win3 = js[2];
	dispNoise = Dialog.getNumber();
	dispThresh = Dialog.getNumber();
	setBatchMode(true);
	
	removeExistingFile(dataDir+dispInputFile);
	f=File.open(dataDir+dispInputFile);
	print(f, win1+" "+win2+" "+win3);
	print(f, d2s(dispNoise,1));
	print(f, d2s(dispThresh,0));
	File.close(f);
	
	for(ipos=0; ipos<nPositions; ipos++){
		print("Going for position "+d2s(ipos,0)+" of "+d2s(nPositions,0));
		posDir = dataDir+"p"+d2s(ipos,0)+"/";
		outDir = posDir+dispDir;
		js = File.makeDirectory(outDir); // Displacements
		skipAnalysis = newArray(nTimePoints);
		str = File.openAsString(posDir+skipAnaFname);
		lines=split(str,"\n");
		skipAnalysis[0] = 0;
		for(i=1;i<nTimePoints; i++){
			skipAnalysis[i] = parseInt(lines[i]);
		}

		for(itime=1;itime<nTimePoints;itime++){
			if(skipAnalysis[itime]==0){
				dispLabel = getnumString(itime);
				out_flname = outDir+dispLabel+"_disp.dat";
				if(!File.exists(out_flname)){ // to recalc, delete the files
					im0_flname = getnumString(0);
					im0_flname = posDir + imDir + im0_flname + ".tif";
					imi_flname = getnumString(itime);
					imi_flname = posDir + imDir + imi_flname + ".tif";
					
					print("Going for the image pair  "+im0_flname+":"+imi_flname);
					
					open(im0_flname);
					open(imi_flname);
					run("Images to Stack", "name=Stack title=[] use");
					
					run("iterative PIV(Cross-correlation)...", "piv1="+win1+" piv2="+win2+" piv3="+win3+" what=[Accept this PIV and output] noise="+dispNoise+" threshold="+dispThresh+" c1=3 c2=1 save="+out_flname);
					run("Close All");
				}
			}
		}
	}

	print("---> Finished calculating gel deformation!");
	showMessage("Finished calculating gel deformation!");
}





function calculateTraction(){
	parentDir = getDirectory("Choose the Directory that contains tnimgs or analysis folder");
	dataDir = parentDir+"analysis/";
	tractionDir = "traction/";
	dispDir = "displacement/";
	tractionInputFile = "traction.in";
	skipAnaFname = "skipAnalysis.txt";
	userChoiceFile = "analysisChoices.txt";
	
	// check if the user input is stored, if it is, prompt to reuse that input
	if(File.exists(dataDir+userChoiceFile)){
		js = File.openAsString(dataDir+userChoiceFile);
		jsl = split(js, "\n");
		js = split(jsl[0],"\t");
		nChannels=parseInt(js[0]); nPositions=parseInt(js[1]); nTimePoints=parseInt(js[2]);
		js = split(jsl[1],"\t");
		phaseChan=js[0]; bigBeadChan=js[1]; tnyBeadChan=js[2]; 
		bcond = jsl[4];
		pixSz = parseFloat(jsl[5]);
	} else {

		print("Create "+dataDir+userChoiceFile+" with following four lines");
		print("nChannels \\t nPositions \\t nTimePoints");
		print("phaseChan \\t bigBeadChan \\t tnyBeadChan");
		print("moveFilesToPosFolder \\t doTransRot \\t cropNSaveInPosFolder");
		print("allowableShift \\t allowableRotation");
		print("boundaryCondition");
		print("pixelSizeInMicrons");
		exit("Follow the directions from the log and rerun the function");		
	}


	for(ipos=0; ipos<nPositions; ipos++){
		print("Going for position "+d2s(ipos,0)+" of "+d2s(nPositions,0));
		posDir = dataDir+"p"+d2s(ipos,0)+"/";
		outDir = posDir+tractionDir;
		js = File.makeDirectory(outDir); // Tractions
		skipAnalysis = newArray(nTimePoints);
		str = File.openAsString(posDir+skipAnaFname);
		lines=split(str,"\n");
		skipAnalysis[0] = 0;
		for(i=1;i<nTimePoints; i++){
			skipAnalysis[i] = parseInt(lines[i]);
		}


		// check if input file exist, if it does, ask if one can reuse it
		if(ipos==0){
			bolRes = 0;
			if(File.exists(posDir+tractionInputFile)){
				js = File.openAsString(posDir+tractionInputFile);
				jsl = split(js,"\n");
				for(i=0;i<jsl.length;i++){
					print(jsl[i]);
				}
				bolRes = getBoolean("Reuse saved "+tractionInputFile+" to calculate cell-ECM forces?");
			}
			if(bolRes==1){
				// write file for that specific analysis
				itime = parseInt(jsl[0]);
				pixSz = parseFloat(jsl[1]);
				shearMod = parseInt(jsl[2]);
				gelThk = parseInt(jsl[3]);
				poiRat = parseFloat(jsl[4]);
				flipSides = jsl[5];
				nosieVal = parseInt(jsl[6]);
				meanDispFlag = parseInt(jsl[7]);
			} else {
				setBatchMode(false);
				Dialog.create("Parameters for calculating cell-ECM forces");
				Dialog.addNumber("Shear modulus: ", 1250, 0, 9, " Pa");
				Dialog.addNumber("Gel thickness: ", 100, 0, 5, " microns");
				Dialog.addNumber("Noise: ", 0.2, 1, 3, "");
				Dialog.addCheckbox(" - Mean dispalcement is zero", false);
				Dialog.addMessage("NOTE: ");
				Dialog.addMessage("- Poisson's ratio of the gel is assumed to be 0.49, and that of cells is assumed to be 0.5");
				Dialog.addMessage("- To recalculate cell-ECM forces, delete the *_trac.dat files");
				Dialog.addMessage("- To recalculate cell-cell forces, delete the *_prestress.dat files");
				
				js = Dialog.show();
				shearMod = Dialog.getNumber();
				gelThk = Dialog.getNumber();
				poiRat = 0.49;
				flipSides = bcond;
				nosieVal = Dialog.getNumber();
				meanDispFlag = Dialog.getCheckbox();
				setBatchMode(true);
			}
		}

		for(itime=1;itime<nTimePoints;itime++){
			if(skipAnalysis[itime]==0){

				removeExistingFile(posDir+tractionInputFile);
				// write file for that specific analysis
				f = File.open(posDir+tractionInputFile);
				print(f, d2s(itime,0)); // time point to analyze
				print(f, d2s(pixSz,5));
				print(f, d2s(shearMod,0));
				print(f, d2s(gelThk,0));
				print(f, d2s(poiRat,2));
				print(f, flipSides);
				print(f, d2s(nosieVal,0));
				print(f, d2s(meanDispFlag,0));
				File.close(f);
				
				tracLabel = getnumString(itime);
				out_flname = outDir+tracLabel+"_trac.dat";
				if(!File.exists(out_flname)){
					js = posDir+dispDir+tracLabel+"_disp.dat";
					if(File.exists(js)){
						exec("xterm", "-e", "cd "+posDir+"  && matlab -nodisplay -r \"addpath(\'/opt/iTACS/FTTM/\'); tractionCalc(\'"+posDir+"\')\"");
					} else {
						exit("Run gel deformation function \nFile: "+js+" is absent");
					}
				}
			}
		}
	}

	print("---> Finished calculating cell-ECM forces! \n Output: analysis/p*/traction/");

	return parentDir;
}




function calculateStress(parentDir){
	//parentDir = getDirectory("Choose the Directory that contains tnimgs or analysis folder");
	dataDir = parentDir+"analysis/";
	tractionDir = "traction/";
	stressDir = "prestress/";
	stressInputFile = "prestress.in";
	skipAnaFname = "skipAnalysis.txt";
	userChoiceFile = "analysisChoices.txt";
	allForceExtn = "_allForces.dat";
	
	// check if the user input is stored, if it is, prompt to reuse that input
	if(File.exists(dataDir+userChoiceFile)){
		js = File.openAsString(dataDir+userChoiceFile);
		jsl = split(js, "\n");
		js = split(jsl[0],"\t");
		nChannels=parseInt(js[0]); nPositions=parseInt(js[1]); nTimePoints=parseInt(js[2]);
		js = split(jsl[1],"\t");
		phaseChan=js[0]; bigBeadChan=js[1]; tnyBeadChan=js[2]; 
		bcond = jsl[4];
		pixSz = parseFloat(jsl[5]);
	} else {
		
		print("Create "+dataDir+userChoiceFile+" with following four lines");
		print("nChannels \\t nPositions \\t nTimePoints");
		print("phaseChan \\t bigBeadChan \\t tnyBeadChan");
		print("moveFilesToPosFolder \\t doTransRot \\t cropNSaveInPosFolder");
		print("allowableShift \\t allowableRotation");
		print("boundaryCondition");
		print("pixelSizeInMicrons");
		exit("Follow the directions from the log and rerun the function");
	}
	// check if input file exist, if it does, ask if one can reuse it

	gridSz = 0;
	
	for(ipos=0; ipos<nPositions; ipos++){
		print("Going for position "+d2s(ipos,0)+" of "+d2s(nPositions,0));
		posDir = dataDir+"p"+d2s(ipos,0)+"/";
		outDir = posDir+stressDir;
		js = File.makeDirectory(outDir); // prestress

		skipAnalysis = newArray(nTimePoints);
		str = File.openAsString(posDir+skipAnaFname);
		lines=split(str,"\n");
		skipAnalysis[0] = 0;
		for(i=1;i<nTimePoints; i++){
			skipAnalysis[i] = parseInt(lines[i]);
		}
		
		nxPts = 0; nyPts = 0;
		for(itime=1;itime<nTimePoints;itime++){
			if(skipAnalysis[itime]==0){
				if(nxPts==0){ // all other time points for this position are expected to have same number of points
					nx_ny_pts = get_nxnyPts(posDir+tractionDir, "_trac.dat");
					nxPts = nx_ny_pts[0]; nyPts = nx_ny_pts[1];
					gridSzInPx = nx_ny_pts[2];
					print("xpts="+d2s(nxPts,0)+", ypts="+d2s(nyPts,0)+", gridSize="+d2s(gridSzInPx,0));
				}
				
				removeExistingFile(posDir+stressInputFile);
				f = File.open(posDir+stressInputFile);
				print(f, d2s(itime,0));
				print(f, d2s(nxPts,0)+" "+d2s(nyPts,0));
				print(f, d2s(pixSz,5)+"e-6"); // meters
				File.close(f);
				stressLabel = getnumString(itime);
				out_flname = outDir+stressLabel+"_prestress.dat";
				if(!File.exists(out_flname)){
					dom_flname = dataDir+tractionDir+stressLabel+"_domain.dat";
					if(!File.exists(dom_flname)){
						createDomainFile(posDir+"phs/",posDir+tractionDir,stressLabel+"_domain.dat",stressLabel+"_trac.dat");
					}
					if(bcond=="allFour"){
						exec("xterm", "-e", "echo 'Calculating cell-cell forces' && cd "+posDir+"&& /opt/MSM/inti >> "+posDir+"../analysis.out");
					} else if(bcond=="leftTopBottom"){
						exec("xterm", "-e", "echo 'Calculating cell-cell forces' && cd "+posDir+"&& /opt/MSM/edge >> "+posDir+"../analysis.out");
					} else if(bcond=="allTwo"){
						exec("xterm", "-e", "echo 'Calculating cell-cell forces' && cd "+posDir+"&& /opt/MSM/strip >> "+posDir+"../analysis.out");
					} else if(bcond=="none"){
						exec("xterm", "-e", "echo 'Calculating cell-cell forces' && cd "+posDir+"&& /opt/MSM/island >> "+posDir+"../analysis.out");
					}
				}
			}
		}
		
		exec("xterm","-e", "rm -rf "+outDir+"*"+allForceExtn);
		stressFileExtn = "_prestress.dat"; 
		tracFileExtn = "_bforce.dat";
		coordFileExtn = "_node_coords.dat";
		invPixSzSq = d2s(1.0/(parseFloat(gridSzInPx)*parseFloat(gridSzInPx)*pixSz*pixSz*1.0e-12),12);
		
		nodeFiles = endsWith_file_dir_list(outDir, coordFileExtn);
		bforceFiles = endsWith_file_dir_list(outDir, tracFileExtn);
		stressFiles = endsWith_file_dir_list(outDir, stressFileExtn);
		if(stressFiles.length==0){
			exit("Stress calculation DID NOT produce 'prestress.dat' files! \nCheck 'analysis/analysis.out' for the reason. \nIn the images in the bwImages folder, ensure that there are no white spots that are unconnected.");
		}
		for(i=0;i<nodeFiles.length;i++){
			exec("xterm","-e","awk '{print $1/"+pixSz*1.0e-6+" \" \" $2/"+pixSz*1.0e-6+"}' "+outDir+nodeFiles[i]+" > "+outDir+"tempC.dat");
			exec("xterm","-e","awk '{print $1*"+invPixSzSq+" \" \" $2*"+invPixSzSq+"}' "+outDir+bforceFiles[i]+" > "+outDir+"tempT.dat"); // get the values in terms of Pa
			exec("xterm","-e","paste "+outDir+"tempC.dat "+outDir+"tempT.dat "+outDir+stressFiles[i]+" > "+outDir+"temp.dat && mv "+outDir+"temp.dat "+outDir+replace(stressFiles[i],"_prestress.dat",allForceExtn));
		}
		exec("xterm","-e","rm -rf "+outDir+"tempC.dat "+outDir+"tempT.dat");
		
		exec("xterm","-e", "cd "+outDir+"&& for f in *"+allForceExtn+"; do sed \"s/\\t/ /g\" $f > temp.dat && mv temp.dat $f; done;"); // to remove tabs
		
	}

	print("---> Finished calculating cell-ECM and cell-cell forces and combining MSM results.\nOutput: analysis/p*/prestress/*_allForces.dat!");
	showMessage("Finished calculating cell-ECM and cell-cell forces and combining MSM results.\nOutput: analysis/p*/prestress/*_allForces.dat!");
}







function calculateVelocity(){
	parentDir = getDirectory("Choose the Directory that contains tnimgs or analysis folder");
	dataDir = parentDir+"analysis/";
	velDir = "velocity/";
	imDir = "phs/";
	velInputFile = "vel.in"; 
	skipAnaFname = "skipAnalysis.txt";
	userChoiceFile = "analysisChoices.txt";
	
	// check if the user input is stored, if it is, prompt to reuse that input
	if(File.exists(dataDir+userChoiceFile)){
		js = File.openAsString(dataDir+userChoiceFile);
		jsl = split(js, "\n");
		js = split(jsl[0],"\t");
		nChannels=parseInt(js[0]); nPositions=parseInt(js[1]); nTimePoints=parseInt(js[2]);
		js = split(jsl[1],"\t");
		phaseChan=js[0]; bigBeadChan=js[1]; tnyBeadChan=js[2]; 
		bcond = jsl[4];
		pixSz = parseFloat(jsl[5]);
	} else {

		print("Create "+dataDir+userChoiceFile+" with following four lines");
		print("nChannels \\t nPositions \\t nTimePoints");
		print("phaseChan \\t bigBeadChan \\t tnyBeadChan");
		print("moveFilesToPosFolder \\t doTransRot \\t cropNSaveInPosFolder");
		print("allowableShift \\t allowableRotation");
		print("boundaryCondition");
		print("pixelSizeInMicrons");
		exit("Follow the directions from the log and rerun the function");
	}


	// check if input file exist, if it does, ask if one can reuse it


	js = newArray(5);
	js[0] = "256 128 64";
	js[1] = "128 64 32";
	js[2] = "64 32 16";
	js[3] = "32 16 8";
	js[4] = "16 8 4"; // UPDATE, June 20, 2020 changed the index from 3 to 4
	setBatchMode(false);
	Dialog.create("Parameters for calculating gel deformation");
	Dialog.addChoice("Window sizes: ", js, js[2]);
	Dialog.addNumber("Noise: ", 0.2, 1, 3, "");
	Dialog.addNumber("Threshold: ", 5, 0, 3, "pixels");
	Dialog.addMessage("NOTE: To recalculate, delete the *_vel.dat files");
	js = Dialog.show();
	js = split(Dialog.getChoice()," ");
	win1 = js[0];
	win2 = js[1];
	win3 = js[2];
	velNoise = Dialog.getNumber();
	velThresh = Dialog.getNumber();
	setBatchMode(true);

	removeExistingFile(dataDir+velInputFile);
	f=File.open(dataDir+velInputFile);
	print(f, win1+" "+win2+" "+win3);
	print(f, d2s(velNoise,1));
	print(f, d2s(velThresh,0));
	File.close(f);
	
	for(ipos=0; ipos<nPositions; ipos++){
		print("Going for position "+d2s(ipos,0)+" of "+d2s(nPositions,0));
		posDir = dataDir+"p"+d2s(ipos,0)+"/";
		outDir = posDir+velDir;
		js = File.makeDirectory(outDir); // Displacements
		skipAnalysis = newArray(nTimePoints);
		str = File.openAsString(posDir+skipAnaFname);
		lines=split(str,"\n");
		skipAnalysis[0] = 0;
		for(i=1;i<nTimePoints; i++){
			skipAnalysis[i] = parseInt(lines[i]);
		}

		for(itime=2;itime<nTimePoints;itime++){
			if(skipAnalysis[itime]==0){
				velLabel = getnumString(itime);
				out_flname = outDir+velLabel+"_vel.dat";
				if(!File.exists(out_flname)){ // to recalc, delete the files
					im0_flname = getnumString(itime-1); // preceding
					im0_flname = posDir + imDir + im0_flname + ".tif";
					imi_flname = getnumString(itime); // current
					imi_flname = posDir + imDir + imi_flname + ".tif";
					
					print("Going for the image pair  "+im0_flname+":"+imi_flname);
					
					open(im0_flname);
					open(imi_flname);
					run("Images to Stack", "name=Stack title=[] use");
					
					run("iterative PIV(Cross-correlation)...", "piv1="+win1+" piv2="+win2+" piv3="+win3+" what=[Accept this PIV and output] noise="+velNoise+" threshold="+velThresh+" c1=3 c2=1 save="+out_flname);
					run("Close All");
				}
			}
		}
	}

	print("---> Finished calculating cell velocities! \nOutput: analysis/p*/velocity/");
	showMessage("Finished calculating cell velocities! \nOutput: analysis/p*/velocity/");
}



function get_nxnyPts(direc, fType){
	tracFiles =  endsWith_file_dir_list(direc, fType);

	js = File.openAsString(direc+tracFiles[0]);
	jsLines = split(js,"\n");

	// check which is constant x or y
	ji1 = split(jsLines[0]," ");
	ji2 = split(jsLines[1]," ");
	constCol = 0; refNum = parseFloat(ji1[0]);
	gridSz = abs(parseFloat(ji2[1])-parseFloat(ji1[1]));
	if(ji1[1]==ji2[1]){
		constCol = 1;
		refNum = parseFloat(ji1[1]);
		gridSz = abs(parseFloat(ji2[0])-parseFloat(ji1[0]));
	}

	sideSize = 0;
	loopEnd = jsLines.length;
	for(i=0;i<loopEnd;i++){
		ji1 = split(jsLines[i]," ");

		if(parseFloat(ji1[constCol])==refNum){
			sideSize = sideSize + 1;
		} else {
			loopEnd = 0;
		}
	}

	nxnyPts = newArray(sideSize, jsLines.length/sideSize, 0);
	if(constCol==1){
		nxnyPts[0] = jsLines.length/sideSize; 
		nxnyPts[1] = sideSize;
	}
	nxnyPts[2] = gridSz;

	return nxnyPts;
}	




function createDomainFile(phsDir, domTracDir,domFlName,tracFlName){
	// read bw file
	close("*");
	imgFl = phsDir+"bwImages/"+replace(domFlName,"_domain.dat",".tif");
	if(File.exists(imgFl)){
		open(imgFl);
		rename("bw");
	} else {
		print("bwImages absent for "+phsDir+", hence running 'Segmentation - cellular cluster' function");
		clusterSegmentation(phsDir+"../"); //exit("bwImages absent for "+phsDir+" \n \nrun 'Segmentation - cellular cluster' first and then rerun 'MSM - cell-cell forces'");

		open(imgFl);
		rename("bw");
	}
	// read traction file
	if(File.exists(domTracDir+tracFlName)){
		js = File.openAsString(domTracDir+tracFlName);
		jsLines = split(js,"\n");

		// open domain file for writing
		if(File.exists(domTracDir+domFlName)){
			File.delete(domTracDir+domFlName);
		}
		f=File.open(domTracDir+domFlName);
	
		for(i=0;i<jsLines.length;i++){
			ji = split(jsLines[i]," ");
			xloc = parseInt(ji[0]); yloc = parseInt(ji[1]);
			
			// for each xy in traction file get the pixel intensity and save that line in the dom file
			selectWindow("bw");
			realPixVal = getPixel(xloc, yloc);
			domVal = 0;
			if(realPixVal>0){
				domVal = 1;
			}
			// loop over number of lines in the 
			print(f, d2s(domVal,0));
			
		}
		File.close(f);
		close("bw");
	} else {
		exit("Run the function for cell-ECM forces \nFile: "+domTracDir+tracFlName+" is absent");
	}
}










function dirs2Combine(dirs){

	input = newArray("");

	nrows = round(dirs.length/2);
	if(nrows==0) exit("Could not find column labels for the data file");
	ncols = dirs.length/nrows;

	if(dirs.length > nrows*ncols){
	   nrows = nrows + 1;
	}
	defaults = newArray(dirs.length);
	for (i=0; i<dirs.length; i++) {
	   if(i<2){
	   	defaults[i] = false;
	   } else {
	   	defaults[i] = false;
	   }
	}
	
	setBatchMode(false);
	Dialog.create("Choose the directories to combine the data:");
	Dialog.addCheckboxGroup(nrows,ncols,dirs,defaults);
	Dialog.addString("Get prefix for the output file *combinedData.csv:", "");
	Dialog.addNumber("Enter number of files to be collected from each directory:", 10);
	js = Dialog.show();

	inputCount = 0;
	for (i=0; i<dirs.length; i++){
		print(d2s(i,0));
		ji = Dialog.getCheckbox();
		if(ji==1){
			if(inputCount==0){
				input[0] = dirs[i];
				inputCount = 1;
			} else {
				input = Array.concat(input,dirs[i]);
			}
		}
	}
	fPrefix = Dialog.getString();
	fnum = Dialog.getNumber();
	setBatchMode(true);
	
	input = Array.concat(input, fPrefix+"combinedData.csv");
	input = Array.concat(input, d2s(fnum,0));
	
	Array.print(input);
	
	return input;
}




function properties2BCollected(colLabel){
	input = newArray("");

	nrows = round(colLabel.length/4);
	if(nrows==0) exit("Could not find column labels for the data file");
	ncols = colLabel.length/nrows;

	if(colLabel.length > nrows*ncols){
	   nrows = nrows + 1;
	}
	defaults = newArray(colLabel.length);
	for (i=0; i<colLabel.length; i++) {
	   if(i<2){
	   	defaults[i] = false;
	   } else {
	   	defaults[i] = false;
	   }
	}

	title = "Check the variables to collect the data for";

	setBatchMode(false);
	Dialog.create(title);
	Dialog.addCheckboxGroup(nrows,ncols,colLabel,defaults);
	js = Dialog.show();
	title = Dialog.getString();
	print("Following properties of the cell will be collected");

	inputCount = 0;
	for (i=0; i<colLabel.length; i++){
		ji = Dialog.getCheckbox();
		if(ji==1){
			if(inputCount==0){
				input[0] = colLabel[i];
				inputCount = 1;
			} else {
				input = Array.concat(input,colLabel[i]);
			}
			// print(colLabel[i]);
		}
	}
	setBatchMode(true);

	Array.print(input);
	
	return input;
}



function appendColumn(inTableName, outTableName, columnName, firstTimeFlag){
	// change the name of inTable
	selectWindow(inTableName);
	
	// read array
	array1 = Table.getColumn(columnName);	
	
	selectWindow(outTableName);

	array2 = newArray();
	if(firstTimeFlag==0){
		array2 = Table.getColumn(columnName);
	}
	
	// append array
	array2 = Array.concat(array2, array1);
	
	// write array
	Table.setColumn(columnName, array2);
	
}





// createBandROI(bandSize,workDir+nestedFolder+resultsDir,files,workDir+nestedFolder
function createBandROI(bandSize,roiZipFileLoc,files,phaseFileLoc){
	nfiles = files.length;

	print("Making BAND rois for "+roiZipFileLoc);
	print("This will take a while");
	for(ifile=1;ifile<nfiles;ifile++){
		print("file="+replace(files[ifile],"_areaStat.txt","_cellID.tif")+" of "+d2s(nfiles,0)+" files");
		open(roiZipFileLoc+replace(files[ifile],"_areaStat.txt","_cellID.tif"));
		rename("phaseSeq0");
//print("ifile="+d2s(ifile,0));
		if(!File.exists(roiZipFileLoc+replace(files[ifile],"_areaStat.txt","_BANDcellID.tif"))){
			Overlay.selectable(false);
			nROIs = Overlay.size;
			run("Duplicate...", "title=dup");
			run("Remove Overlay");
			selectWindow("phaseSeq0");
			run("Images to Stack", "name=OverStack title=[] use");
			//print("Number of overlays = "+d2s(nROIs,0));
			for(i=0;i<nROIs;i++){
//print("iroi="+d2s(i,0));
				setSlice(1);
				Overlay.activateSelection(i);
				run("Make Band...", "band="+d2s(bandSize,0));
				Overlay.addSelection;
				Overlay.setPosition(2);
			}
			run("Stack to Images");
			selectWindow("dup");
			saveAs("Tiff", roiZipFileLoc+replace(files[ifile],"_areaStat.txt","_BANDcellID.tif"));
			run("Close All");
		}
	}
}




function createCellIDImage(refOverlayTitle, labelIndx){
	
	selectWindow(refOverlayTitle);
	nrCells = Overlay.size;
	if(nrCells != labelIndx.length){
		exit("Number of overlay are not same as number of labels");
	}
	// create a filled label area
	run("32-bit");
	ht = getHeight();
	wd = getWidth();
	newImage("colrdCellLabls", "32-bit", wd, ht, 0);
	//fillIm = getImageID();
	setForegroundColor(1);
	setBackgroundColor(0);
	for(i=0;i<nrCells;i++){
		selectWindow(refOverlayTitle);
		Overlay.activateSelection(i);
		run("Create Mask");
		rename("m1");
		run("32-bit");
		run("Divide...", "value=255"); // mask creates cell with 255 filled
		run("Multiply...", "value="+d2s(labelIndx[i],0)); // replace value of each pixel by the index value
		imageCalculator("add", "colrdCellLabls", "m1");
		close("m1");
	}
	
	return "colrdCellLabls";
	
}





// untrackableCellIDs = ids of cells that could not be traced back to the first frame ... returned variable
// REFcellID.tif = file containing labels 
// most important function for tracking!
function traceOriginalIDs(lastREFROIfile, currROIfile, ncells0, outFileName){ //
//print("traceOriginalIDs:  "+lastREFROIfile+"  "+currROIfile+"  "+d2s(ncells0,0)+"  "+outFileName);
	open(lastREFROIfile); // label colord file
	rename("rflstFl");

	open(currROIfile);
	rename("currFl");
	
	tiledRefIm = "rflstFl";
	ovrlCurIm = "currFl";
	
	setForegroundColor(1);
	setBackgroundColor(0);
	selectWindow(ovrlCurIm);
	Overlay.copy;
	selectWindow(tiledRefIm);
	Overlay.paste;
	run("Set Measurements...", "area median mean modal min redirect="+tiledRefIm+" decimal=6");
	
	run("Clear Results");
	
	Overlay.measure;
	//ncCells = nResults;
	ncCells = Overlay.size;
	tTitle = Table.title;
	overlayMeasureIm = "measureImTitle";
	makeTImage(tTitle,overlayMeasureIm);
	
	// get mean area (tiny cells will be neglected)
	selectWindow(overlayMeasureIm);
	jarea = newArray(ncCells);
	for(i=0;i<ncCells;i++){
		jarea[i] = getPixel(0,i); // Area
	}
	//jarea = Table.getColumn("Area");
	Array.getStatistics(jarea, jmina, jmaxa, meanArea, jstdDeva);
	
	tracedID = newArray(ncCells);
	for(i=0;i<ncCells;i++){ // initialize
		tracedID[i] = 0;
	}

	jzeros = 0;
	for(i=0;i<ncCells;i++){
		tracedID[i] = getPixel(5,i); //getResult("Median",i); // new ID of the cell ("mode",i) is i
		if(tracedID[i]==0){ // if most of the cell is covered by previously unoccupied area then it will be detected to have an id of 0
			tracedID[i] = getPixel(4,i); //getResult("Max",i);
			jzeros = jzeros + 1;
		}
	}
//Array.print(tracedID);

	//Table.rename("Results", "intersectStat");

	// correct cells that are traced to the same ref ID (detect duplicates)
	// get unique IDs 
	
	uniqueIDs = ArrayUnique(Array.copy(tracedID));
	uniqueIDs = Array.deleteIndex(uniqueIDs, 0); // remove zero from the list as we do not care about this ID
	nUniqueIDs = uniqueIDs.length;
	if(nUniqueIDs != ncCells){
		print("Resolving "+d2s(ncCells-nUniqueIDs,0)+" duplicates");
		uniqueIDsRepeated = newArray(); // array that can expand in size dynamically
		repeatCounts = newArray();
		//jrptCount = 0;
		for(i=0;i<nUniqueIDs;i++){
			jc = 0;
			for(j=0;j<ncCells;j++){
				if(tracedID[j]==uniqueIDs[i]){
					jc=jc+1;
				}
			}
			if(jc>1){
				//uniqueIDsRepeated[jrptCount] = uniqueIDs[i];
				//repeatCounts[jrptCount] = jc;
				//jrptCount = jrptCount + 1;
				uniqueIDsRepeated = Array.concat(uniqueIDsRepeated,uniqueIDs[i]);
				repeatCounts = Array.concat(repeatCounts,jc);
			}
		}
		
		nrepeatIDs = uniqueIDsRepeated.length;
		
		print("Repeat count = "+d2s(nrepeatIDs,0)+" of "+d2s(ncCells,0));

		// decide which of the duplicates win based on which one has mean intensity closest to the label value
		// first filter: If area is smaller than half of mean area, give it an id of 0
		// second filter: if mean is least different from median, choose it for nonzero ID
		
		for(jrpt=0;jrpt<nrepeatIDs;jrpt++){
			//run("Clear Results");
			//Table.rename("intersectStat","Results");

			//print("Going for ID "+d2s(uniqueIDsRepeated[jrpt],0)+" with "+d2s(repeatCounts[jrpt],0)+" repeats");
			zeroTheseIdenticalTracedIDIndices = newArray(repeatCounts[jrpt]);
			jjcount = 0;
			for(icl=0;icl<ncCells;icl++){
				if(tracedID[icl]==uniqueIDsRepeated[jrpt]){
					zeroTheseIdenticalTracedIDIndices[jjcount] = icl; // this assumes that icl will be the location in results array
					jjcount = jjcount + 1;
					if(jjcount == repeatCounts[jrpt]) break;
				}
			}

			// For each repeated ID
			
			// collect properties of those cells
			meanVals = newArray(repeatCounts[jrpt]);
			areaVals = newArray(repeatCounts[jrpt]);
			for(j=0;j<repeatCounts[jrpt];j++){
				selectWindow(overlayMeasureIm);
				areaVals[j] = getPixel(0,zeroTheseIdenticalTracedIDIndices[j]);
				//areaVals[j] = getResult("Area",zeroTheseIdenticalTracedIDIndices[j]);
				areaVals[j] = (areaVals[j] - meanArea)/meanArea*100.0;
				
				meanVals[j] = getPixel(1,zeroTheseIdenticalTracedIDIndices[j]); // collect mean values of all these cells
				//meanVals[j] = getResult("Mean",zeroTheseIdenticalTracedIDIndices[j]); // collect mean values of all these cells
				meanVals[j] = meanVals[j] - tracedID[zeroTheseIdenticalTracedIDIndices[j]]; // find which one has mean closest to mode
			}
			//Table.rename("Results","intersectStat");
	
			// filter 1: reject tiny area
			removeTheseARRIDs = newArray();
			rmARRcount = 0;
			for(j=0;j<repeatCounts[jrpt];j++){
				if(areaVals[j]<20.0){ // remove all that have less than a fifth the mean area
					removeTheseARRIDs = Array.concat(removeTheseARRIDs,j);
					//removeTheseARRIDs[rmARRcount] = j;
					rmARRcount = rmARRcount + 1;
				}
			}
			
			if(repeatCounts[jrpt]==rmARRcount){ // keep the largest cell ...
				Array.getStatistics(areaVals, amin, amax, amean, astdDev);
				jmaxLoc = Array.findMaxima(areaVals, (amax-amin));
				for(j=0;j<rmARRcount;j++){
					if(removeTheseARRIDs[j]==jmaxLoc[0]){ // this is checked
						removeTheseARRIDs = Array.deleteIndex(removeTheseARRIDs, j);
						break;
					}
				}
				rmARRcount = rmARRcount - 1;
				repeatCounts[jrpt] = repeatCounts[jrpt] - 1;
			} 
			// ...  and remove all others that are tiny
			for(j=rmARRcount-1;j>=0;j--){ // removing indices requires backward loop
				tracedID[zeroTheseIdenticalTracedIDIndices[removeTheseARRIDs[j]]] = 0;
				meanVals = Array.deleteIndex(meanVals, removeTheseARRIDs[j]);
				zeroTheseIdenticalTracedIDIndices = Array.deleteIndex(zeroTheseIdenticalTracedIDIndices, removeTheseARRIDs[j]);
				repeatCounts[jrpt] = repeatCounts[jrpt] - 1;
			}
						
			// check if meanVals is one single number
			applySecondFilter = true;
			if(repeatCounts[jrpt]<=1){ // improvement: can limit removal to have at least one candidate remaining
				applySecondFilter = false;
			}
			
			// filter 2: select the one with mean closest to median
			// make other cells in the duplicate list to have an ID of 0
			if(applySecondFilter){
				Array.getStatistics(meanVals, jmin, jmax, jx, jx);
				minLocn = Array.findMinima(meanVals,jmax-jmin); // assumption is that there will be no local minima that is more than 999999 different in height than global minima
				// caveat - it reports first minimum in th array (1, 0, 1, 0) only index [1] will be reported as sminimum
				for(j=0;j<repeatCounts[jrpt];j++){
					if(j!=minLocn[0]){ // remove all that have mode farther away from mean
						tracedID[zeroTheseIdenticalTracedIDIndices[j]] = 0; // Overlay IDs start at 1
					}
				}
			}
		}
	}
	//close("intersectStat");
//Array.print(tracedID);

	// make the REFcellID.tif image
	tiledRefIm0 = createCellIDImage(ovrlCurIm,tracedID);
	selectWindow(tiledRefIm0);
	saveAs("Tiff", outFileName); // _REFcellID.tif has numbers corresponding to original frame, so when observed sequentially, these frames will show track of each cell
	close(ovrlCurIm);
	close(tiledRefIm);
	close(tiledRefIm0);

	// get the traced ID as a function of tracking array in the first frame
	tracedID_1stFrame = newArray(ncells0);
	for(i=0;i<ncells0;i++){
		tracedID_1stFrame[i] = 0; // initialize
		for(j=0;j<ncCells;j++){
			if(tracedID[j] == i+1){
				tracedID_1stFrame[i] = j+1;
				break;
			}
		}
	}
	
	return tracedID_1stFrame;
	// cells that are traced have nonzero ID, others have zero ID
}





// following function is from https://imagej.nih.gov/ij/macros/Array_Functions.txt
function ArrayUnique(array) {
	array 	= Array.sort(array);
	array 	= Array.concat(array, 999999);
	uniqueA = newArray();
	i = 0;	
   	while (i<(array.length)-1) {
		if (array[i] == array[(i)+1]) {
			//print("found: "+array[i]);			
		} else {
			uniqueA = Array.concat(uniqueA, array[i]);
		}
   		i++;
   	}
	return uniqueA;
}



function arrayDetectVal(a,targetVal){
	Table.showArrays("Results", a);
	run("Results to Image");
	run("Clear Results");
	rename("arr");
	run("Subtract...", "value="+d2s(targetVal,0));
	run("Abs");
	run("Multiply...", "value=255");
	run("Convert to Mask");
	run("32-bit");
	run("Divide...", "value=255");
		
	run("Image to Results");
	returnArr = newArray(nResults);
	for(i=0; i<nResults; i++) {
		returnArr[i] = getResult("X0", i);
	}
	close("arr");
	selectWindow("Results"); 
    run("Close");
	
	return returnArr;
}




function sumArray(arr){
	sumVal = 0;
	for (i=0;i<lengthOf(arr);i++){
		sumVal = sumVal + arr[i];
	}
	return sumVal;
}


