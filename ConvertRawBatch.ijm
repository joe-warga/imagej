print("Written by Joe Warga 2013-12-16");
print("This script converts RAW files captured through GEV Player into TIFFs");
dir1 = getDirectory("Choose Source Directory of RAWs "); 
dir2 = getDirectory("Choose Destination Directory for TIFFs "); 
list = getFileList(dir1); 
setBatchMode(true);
 
function CloseWin() {
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
}

for (i=0; i<list.length; i++) { 
        showProgress(i+1, list.length); 
		filename1 = dir1 + list[i];
        run("Raw...", "open=filename1 image=8-bit width=4032 height=2688 offset=2 number=1 gap=0");
        saveAs("tiff", dir2+list[i]);
		CloseWin();
		j=list.length - i;
		print(j);
}
print("Finished");