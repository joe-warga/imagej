print("Written by Joe Warga 2014-07-24");
print("This script debayers raw images from sats");
print("debayer plugin downloaded here: http://www.umanitoba.ca/faculties/science/astronomy/jwest/plugins.html");
dir1 = getDirectory("Choose Source Directory of Oringinals ");
dir2 = getDirectory("Choose Destination Directory for DeBayered Images ");
list = getFileList(dir1);
suff = "_DeBayer"
setBatchMode(true);

function CloseWin() {
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
}

for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	open(dir1+list[i]);
	run("16-bit");
	run("Debayer Image", "order=G-B-G-B demosaicing=Bilinear radius=2 radius=2 display");
	selectWindow("RGB Stack (RGB)");
	saveAs("TIFF", dir2+list[i]+suff);
	CloseWin();
	j=list.length - i;
	print(j);
}

print("Finished");
