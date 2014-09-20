dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Destination Directory for flat fields ");
dir3 = getDirectory("Choose Destination Directory for white balanced flat fields ");
list = getFileList(dir1);
suff1 = "_darkflat"
suff2 = "_darkflat_whtbal"
setBatchMode(true);

open("C:\\Users\\joewarga\\Documents\\Dove3 images\\211-239\\dark.tiff");
open("C:\\Users\\joewarga\\Documents\\Dove3 images\\211-239\\flat-dark.tif");

for (i=0; i<list.length; i++) {

showProgress(i+1, list.length);
open(dir1+list[i]);
run("Split Channels");

imageCalculator("Subtract create 32-bit", list[i]+ " (red)","dark.tiff");
imageCalculator("Subtract create 32-bit", list[i]+ " (green)","dark.tiff");
imageCalculator("Subtract create 32-bit", list[i]+ " (blue)","dark.tiff");

imageCalculator("Divide create 32-bit", "Result of " + list[i]+ " (red)","flat-dark.tif");
imageCalculator("Divide create 32-bit", "Result of " + list[i]+ " (green)","flat-dark.tif");
imageCalculator("Divide create 32-bit", "Result of " + list[i]+ " (blue)","flat-dark.tif");

run("Merge Channels...", "c1=[Result of Result of " + list[i]+ " (red)] c2=[Result of Result of " + list[i]+ " (green)] c3=[Result of Result of " + list[i]+ " (blue)] keep");
saveAs("TIFF", dir2+list[i]+suff1);

run("Color Balance...");
resetMinAndMax();
run("Enhance Contrast", "saturated=0.35");
saveAs("TIFF", dir3+list[i]+suff2);

selectWindow(list[i]+ " (green)");
close();
selectWindow(list[i]+ " (red)");
close();
selectWindow(list[i]+ " (blue)");
close();
selectWindow("Result of " + list[i]+ " (green)");
close();
selectWindow("Result of " + list[i]+ " (red)");
close();
selectWindow("Result of " + list[i]+ " (blue)");
close();
selectWindow("Result of Result of " + list[i]+ " (green)");
close();
selectWindow("Result of Result of " + list[i]+ " (red)");
close();
selectWindow("Result of Result of " + list[i]+ " (blue)");
close();

}

print("Finished");
