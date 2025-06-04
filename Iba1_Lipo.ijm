// Step 1: Select a folder containing the .nd2 files
folderPath = getDirectory("Select a folder containing .nd2 files");
print("Selected folder: " + folderPath);

// Get a list of all .nd2 files in the folder
fileList = getFileList(folderPath);

if (fileList.length == 0) {
    print("No .nd2 files found in the selected folder.");
    exit();
}

// Process each .nd2 file in the folder
for (i = 0; i < fileList.length; i++) {
    fileName = fileList[i];
    
    if (endsWith(fileName, ".nd2")) {
        fullPath = folderPath + fileName;
        print("Processing: " + fullPath);
        open(fullPath);

      

        // Step 3: Identify and process the Microglial channel
        nameC2 = fileName + " - C=2";
        selectWindow(nameC2);
        print("Processing: " + nameC2);

        // Z-Projection (Max Intensity)
        //run("Brightness/Contrast...");
		run("Enhance Contrast", "saturated=0.35");
		run("Apply LUT", "stack");
		run("Despeckle", "stack");
		run("Remove Outliers...", "radius=2 threshold=50 which=Bright stack");
		run("Z Project...", "projection=[Max Intensity]");
		setAutoThreshold("RenyiEntropy dark no-reset");
		roiManager("Reset");
		run("Analyze Particles...", "size=1000-10000 pixel show=Outlines add composite");


    
        // Step 3.1: Save the "Drawing of..." image
        wait(1000); // Increase delay to ensure Drawing image has time to appear
        drawingTitle = "Drawing of MAX_" + nameC2;
        
        // Confirm the Drawing window is open and then save it
        if (isOpen(drawingTitle)) {
            selectWindow(drawingTitle);
            savePathDrawing = folderPath + replace(fileName, ".nd2", "_drawing.tif");
            print("Saving Drawing image to: " + savePathDrawing);
            saveAs("Tiff", savePathDrawing);
        } else {
            print("Warning: 'Drawing' image not found for " + nameC2);
        }

        // Step 4: Identify and process the lipofuscin channel
        nameC1 = fileName + " - C=1";
        selectWindow(nameC1);

        // Z-Projection (Max Intensity)
        run("Z Project...", "projection=[Max Intensity]");
		//setAutoThreshold("RenyiEntropy dark no-reset");
        // Step 5: Apply ROIs onto lipofuscin projection
        roiManager("Show All");

        // Step 6: Measure ROIs
        roiManager("Measure");

        // Step 7: Save Measurements
        savePath = folderPath + replace(fileName, ".nd2", "_measurements.csv");
        print("Saving measurements to: " + savePath);
        saveAs("Results", savePath);

        // Close images before moving to the next file
        close("*");
    }
}

print("Finished");
