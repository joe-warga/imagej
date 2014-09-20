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
		makeRectangle(x1, y1, x2, y2);
		getStatistics(arear, meanr, minr, maxr, stdr);
		selectWindow("G1") ;
		makeRectangle(x1, y1, x2, y2);
		getStatistics(areag1, meang1, ming1, maxg1, stdg1);
		selectWindow("G2") ;
		makeRectangle(x1, y1, x2, y2);
		getStatistics(areag2, meang2, ming2, maxg2, stdg2);
		selectWindow("B") ;
		makeRectangle(x1, y1, x2, y2);
		getStatistics(areab, meanb, minb, maxb, stdb);
		print(list [i], ", red histo-mean," + meanr + ",red histo-StdDev," + stdr + ",red max pixel value," + maxr + ",red min pixel value," + minr + ", g1 histo-mean," + meang1 + ",g1 histo-StdDev," + stdg1 + ",g1 max pixel value," + maxg1 + ",g1 min pixel value," + ming1 + ", g2 histo-mean," + meang2 + ",g2 histo-StdDev," + stdg2 + ",g2 max pixel value," + maxg2 + ",g2 min pixel value," + ming2 + ", b histo-mean," + meanb + ",b histo-StdDev," + stdb + ",b max pixel value," + maxb + ",b min pixel value," + minb);
		
		selectWindow("R") ;
		close();
		selectWindow("G1") ;
		close();
		selectWindow("G2") ;
		close();
		selectWindow("B") ;
		close();
} 

selectWindow("Log") ;
saveAs("txt",dir2+"output.csv"); 


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