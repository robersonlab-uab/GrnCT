input = "file path here";
output = "file path here";
list = getFileList(input);

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".nd2") || endsWith(list[i], ".nd2")) {
        open(input + list[i]);
        run("Despeckle", "stack");
		run("Remove Outliers...", "radius=3 threshold=50 which=Bright stack");
		run("Enhance Contrast", "saturated=0.35");
		setMinAndMax(64, 820);
		run("Apply LUT", "stack");
        saveAs("Tiff", output + list[i]);
        close();
    }
}