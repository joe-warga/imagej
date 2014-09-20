dir1 = getDirectory("Choose Source Directory of Oringinals ");
dir2 = getDirectory("Choose Destination Directory for DeBayered Images ");
list = getFileList(dir1);
suff = "_DeBayer"
setBatchMode(true);
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	open(dir1+list[i]);
	run("16-bit");
	run("Debayer Image", "order=G-B-G-B demosaicing=Replication apply radius=2 radius=2 display");
	selectWindow("RGB Stack");
	close();
	selectWindow("RGB Stack (RGB)");
	saveAs("TIFF", dir2+list[i]+suff);
	close();
	selectWindow(list[i]);
	close();
}

print("Finished");
