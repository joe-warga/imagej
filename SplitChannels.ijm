// print("Written by Joe Warga 2013-12-17");
// print("This script opens RAW files captured through GEV Player and measures the Variance of the centre ROI");

id = getImageID(); 
makeColorChannel("R", -1, 0); 
selectImage(id); 
makeColorChannel("G1", 0, 0); 
selectImage(id); 
makeColorChannel("G2", -1, -1); 
selectImage(id); 
makeColorChannel("B", 0, -1); 

function makeColorChannel(name, dx, dy)
{ 
  slices = nSlices(); 
  newWidth = getWidth()/2; 
  newHeight = getHeight()/2; 
  run("Duplicate...", "title=&name duplicate range=1-&slices"); 
  run("Translate...", "x=&dx y=&dy interpolation=None stack"); 
  run("Size...", "width=&newWidth height=&newHeight depth=&slices interpolation=None"); 
} 

// print("Finished");