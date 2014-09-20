print("Macro written by Joe Warga on 2014-01-02");
print("This script shows a photo and files it depending on input");

defaultValue = 1
dir1 = getDirectory("Choose Source Directory "); 
dir2 = getDirectory("Choose Discard Directory "); 
list = getFileList(dir1); 

for (i=0; i<list.length; i++) { 
	showProgress(i+1, list.length); 
	filename1 = dir1 + list[i];
	filename2 = dir2 + list[i];
	open(filename1);
	// run("Set... ", "zoom=33 x=2016 y=1344");
	run("Set... ", "zoom=67 x=1536 y=1024");
	num = getNumber("Keep = 1; Discard = 0", defaultValue);
	if (num) {
		print ("keep");
	} else {
		// File.delete(filename1);
		File.rename(filename1, filename2);
		print ("discard ugly photo");
	}
	close();
} 
print("Finished");