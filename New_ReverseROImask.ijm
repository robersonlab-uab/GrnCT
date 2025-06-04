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

        // Step 3: Identify and process the "C=2" channel
        nameC2 = fileName + " - C=2";
        selectWindow(nameC2);
        print("Processing: " + nameC2);
        // Z-Projection (Max Intensity)
        run("Enhance Contrast", "saturated=0.35");
        run("Apply LUT", "stack");
        run("Despeckle", "stack");
        run("Remove Outliers...", "radius=2 threshold=50 which=Bright stack");
        run("Z Project...", "projection=[Max Intensity]");
        setAutoThreshold("RenyiEntropy dark no-reset");
        roiManager("Reset");
        run("Analyze Particles...", "size=1000-10000 pixel show=Outlines add composite");


        // Apply RenyiEntropy threshold
        setAutoThreshold("RenyiEntropy dark no-reset");

        // Step 4: Identify and process the "C=1" channel
        nameC1 = fileName + " - C=1";
        selectWindow(nameC1);

        // Z-Projection (Max Intensity)
        run("Z Project...", "projection=[Max Intensity]");

        // Step 5: Apply ROIs onto C=1 Projection
        roiManager("Show All");

        // Step 6: Clear everything inside the ROIs in C=1
        if (roiManager("Count") > 0) {  
            for (r = 0; r < roiManager("Count"); r++) {
                roiManager("Select", r); // Select each ROI one by one
                run("Clear"); // Clears only inside the selected ROI
            }
        } else {
            print("No ROIs found to clear.");
        }

        // Step 7: Apply the RenyiEntropy threshold again and save the mask
        setAutoThreshold("RenyiEntropy dark no-reset");


        // Step 8: Measure ROIs (Note: mask will be used here)
        run("Select All");
        roiManager("Deselect");
        roiManager("Delete");
        setAutoThreshold("RenyiEntropy dark no-reset");
        run("Convert to Mask");

        // Save the mask after thresholding
        maskTitle = "MAX_" + nameC1;
        if (isOpen(maskTitle)) {
            selectWindow(maskTitle);
            savePathMask = folderPath + replace(fileName, ".nd2", "_mask.tif");
            print("Saving Mask image to: " + savePathMask);
            saveAs("Tiff", savePathMask);
        } else {
            print("Warning: Mask not found for " + nameC2);
        }
        run("Measure");

        // Step 9: Save Measurements
        savePath = folderPath + replace(fileName, ".nd2", "_measurements.csv");
        print("Saving measurements to: " + savePath);
        saveAs("Results", savePath);

        // Close images before moving to the next file
        close("*");
    }
}

print("Processing complete!");
