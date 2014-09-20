print("Macro written by Joe Warga on 2014-01-12");
print("This script stretches the histogram");

// file extension for save:
ext = "tif";

// number of pixels saturated
pxsat = "saturated=0.01";

dir1 = getDirectory("Source Directory ");
list = getFileList(dir1); 
File.makeDirectory(dir1 + "//HistoStretch");
setBatchMode(true);

for (i=0; i<list.length; i++) { 
	showProgress(i+1, list.length); 
	filename1 = dir1 + list[i];
	filename2 = dir1 + "//HistoStretch//" + list[i];
	open(filename1);
	run("Enhance Contrast", pxsat);
	saveAs(ext, filename2);
	close();
} 
print("Finished");
