print("Written by Joe Warga 2013-12-16");
print("This script opens RAW files captured through GEV Player and measures the Variance of the centre ROI");

ROIsize = 256;

ImWidth=4032;
ImHeight=2688;

x1 = ImWidth / 2 - ROIsize / 2;
y1 = ImHeight / 2 - ROIsize / 2;
x2 = ImWidth / 2 + ROIsize / 2;
y2 = ImHeight / 2 + ROIsize / 2;

dir1 = getDirectory("Choose Source Directory of RAWs "); 
dir2 = getDirectory("Choose Destination Directory for output "); 
list = getFileList(dir1); 
setBatchMode(true); 
print("Data from directory:," + dir1);

for (i=0; i<list.length; i++) { 
        showProgress(i+1, list.length); 
		filename1 = dir1 + list[i];
        open(filename1);
        // saveAs("tiff", dir2+list[i]);
		makeRectangle(x1, y1, x2, y2);
		getStatistics(area1, mean1, min1, max1, std1);
		print(list [i], ",histo-mean," + mean1 + ",histo-StdDev," + std1 + ",max pixel value," + max1 + ",min pixel value," + min1);
		selectWindow("Log") ;
		saveAs("txt",dir2+"output.csv"); 
} 
print("Finished");