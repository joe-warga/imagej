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
		id = getImageID(); 
		makeColorChannel("R", 0, -1); 
		selectImage(id); 
		makeColorChannel("G1", 0, 0); 
		selectImage(id); 
		makeColorChannel("G2", -1, -1); 
		selectImage(id); 
		makeColorChannel("B", -1, 0); 
        // saveAs("tiff", dir2+list[i]);
		
		selectWindow("R") ;
		saveAs("tiff", dir2+list[i]+"R");
		close();
		selectWindow("G1") ;
		saveAs("tiff", dir2+list[i]+"G1");
		close();
		selectWindow("G2") ;
		saveAs("tiff", dir2+list[i]+"G2");
		close();
		selectWindow("B") ;
		saveAs("tiff", dir2+list[i]+"B");
		close();
		
} 


function makeColorChannel(name, dx, dy)
{ 
  slices = nSlices(); 
  newWidth = getWidth()/2; 
  newHeight = getHeight()/2; 
  run("Duplicate...", "title=&name duplicate range=1-&slices"); 
  run("Translate...", "x=&dx y=&dy interpolation=None stack"); 
  run("Size...", "width=&newWidth height=&newHeight depth=&slices interpolation=None"); 
} 

print("Finished");