print("Macro written by Joe Warga on 2014-03-31");
print("This script crops the image to 100x100 in the center");
p = 100;

dir1 = getDirectory("Source Directory ");
dir2 = getDirectory("Destination Directory ");
list = getFileList(dir1); 
setBatchMode(true);

for (i=0; i<list.length; i++) { 
	showProgress(i+1, list.length); 
	filename1 = dir1 + list[i];
	open(filename1);
	
//Stuff to do here
	h = getHeight();
	w = getWidth();
	x0 = w/2 - p/2;
	y0 = h/2 - p/2;
	makeRectangle(x0, y0, p, p);
	run("Crop");
	saveAs("tiff", dir2+list[i]);
	close();
} 
print("Finished");
