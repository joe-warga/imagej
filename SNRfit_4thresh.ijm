print("Script takes images and estimates the SNR from signal of the image");
print("Macro written by Joe Warga on 2014-04-11");

dir1 = getDirectory("Choose Source Directory of RAW images ");
dir2 = getDirectory("Directory for SNR images ");
list = getFileList(dir1);
suff1 = "SNRestimate_";
thresh1 = 8;
thresh2 = 10;
thresh3 = 20;
thresh4 = 30;
suff2 = "SNRthresh" + thresh1 + "_";
suff3 = "SNRthresh" + thresh2 + "_";
suff4 = "SNRthresh" + thresh3 + "_";
suff5 = "SNRthresh" + thresh4 + "_";
intercept = 3.6519;
slope = 0.2755;

IntLine = d2s(intercept, 4);
SlopLine = d2s(slope, 4);

setBatchMode(true);
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	open(dir1+list[i]);

	//do the math
	run("32-bit");
	run("Multiply...", "value=" + SlopLine);
	run("Subtract...", "value=" + IntLine);

	//make sure converting back to 8-bit is scaled right
	makeRectangle(4030, 9, 2, 1);
	run("Multiply...", "value=0.000");
	makeRectangle(4031, 9, 1, 1);
	run("Add...", "value=255");
	run("8-bit");
	makeRectangle(4031, 9, 1, 1);
	run("Subtract...", "value=255");
	saveAs("TIFF", dir2+suff1+list[i]);
	
	//Show the SNR = threshold 1
	setAutoThreshold("Default");
	setThreshold(0, thresh1);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	saveAs("TIFF", dir2+suff2+list[i]);
	close();
	open(dir2+suff1+list[i]);
	//Show the SNR = threshold 2
	setAutoThreshold("Default");
	setThreshold(0, thresh2);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	saveAs("TIFF", dir2+suff3+list[i]);
	close();
	open(dir2+suff1+list[i]);
	//Show the SNR = threshold 3
	setAutoThreshold("Default");
	setThreshold(0, thresh3);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	saveAs("TIFF", dir2+suff4+list[i]);
	close();
	open(dir2+suff1+list[i]);
	//Show the SNR = threshold 4
	setAutoThreshold("Default");
	setThreshold(0, thresh4);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	saveAs("TIFF", dir2+suff5+list[i]);
	close();
	open(dir2+suff1+list[i]);
	
	print(list.length-i);
}
print(0);
print("Finished");
