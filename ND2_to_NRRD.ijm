// Select input and output directories
inputDir = getDirectory("Choose Input Directory");
fileList = getFileList(inputDir);
outputDir = getDirectory("Choose Output Directory");

for (i = 0; i < fileList.length; i++) {
    filePath = inputDir + fileList[i];
    
    if (endsWith(filePath, ".tif") || endsWith(filePath, ".nd2")) { // Add more formats if needed
        open(filePath);

        // Split channels
        run("Split Channels");

        // Select channel
        channelName = "C3-" + fileList[i];

        // Wait step
        wait(500);

        // Select the specific channel
        if (isOpen(channelName)) {
            selectWindow(channelName);
        } else {
            print("Error: Channel window not found: " + channelName);
            continue; // Skip this file if channel is not found
        }

        // Adjust brightness/contrast 
        run("Despeckle", "stack");
	run("Remove Outliers...", "radius=3 threshold=50 which=Bright stack");
	run("Enhance Contrast", "saturated=0.35");
	setMinAndMax(64, 820);
	run("Apply LUT", "stack");
        
        // Construct output filename
        baseName = replace(fileList[i], ".tif", ""); // Remove extension
        baseName = replace(baseName, ".nd2", ""); // Remove extension if .nd2
        outputFilePath = outputDir + "C3-" + baseName + "_processed.nrrd";
        
        // Save as NRRD
        run("Nrrd ... ", "nrrd=[" + outputFilePath + "]");

        // Close the channel image
        close();
    }
}

// Close all remaining images
run("Close All");
