print("Macro written by Joe Warga on 2014-04-10");
print("This script crops the image to whatever");
//Define ROI
x0 = 1400;
y0 = 980;
x1 = 2200;
y1 = 1300;
w = x1-x0;
h = y1-y0;

print("starting point top left: x, y");
print(x0);
print(y0);
print("width and height");
print(w);
print(h);

dir1 = getDirectory("Source Directory ");
//dir2 = getDirectory("Destination Directory ");
File.makeDirectory(dir1 + "//Crop");
dir2 = dir1 + "//Crop//"
list = getFileList(dir1); 
setBatchMode(true);

for (i=0; i<list.length; i++) { 
	showProgress(i+1, list.length); 
	filename1 = dir1 + list[i];
	open(filename1);
	
	// makeRectangle(x_left, y_top, width, height)
	//top left of image is 1,1
	makeRectangle(x0, y0, w, h);
	run("Crop");
	saveAs("tiff", dir2+list[i]);
	close();
} 
print("Finished");
