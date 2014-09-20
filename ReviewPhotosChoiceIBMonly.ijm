print("Macro written by Joe Warga on 2014-01-02");
print("This script shows a photo and files it depending on input");
// R1 implements creating the folders

defaultValue = 1	// this value is default of the user prompt

// Set dir3 to some universal great photo folder
// Set dir2 to some universal trash to be disposed of later
// Keep dir4 inside folders for ease of replacing them once cropped

dir1 = getDirectory("Source Directory "); 
list = getFileList(dir1); 
dir2 = "//home//joewarga//Pictures//BadPhotos//"
dir3 = "//home//joewarga//Pictures//BestPhotos//"
File.makeDirectory(dir1 + "//Crop");
dir4 = dir1 + "//Crop//"

for (i=0; i<list.length; i++) { 
	showProgress(i+1, list.length); 
	filename1 = dir1 + list[i];
	filename2 = dir2 + list[i];
	filename3 = dir3 + list[i];
	filename4 = dir4 + list[i];
	open(filename1);
	// run("Set... ", "zoom=33 x=2016 y=1344");
	run("Set... ", "zoom=50 x=1536 y=1024");
	num = getNumber("Discard = 0; Keep = 1; SuperGood = 2; CropLater = 3", defaultValue);
	if (num == 1) {
		print ("keep");
	}
	if (num == 0) {
		// File.delete(filename1);
		File.rename(filename1, filename2);
		print ("discard ugly photo");
	}
	if (num == 2) {
		print ("Oh, shit you took a real nice photo!");
		saveAs("jpeg", filename3);
	}
	if (num == 3) {
		// File.delete(filename1);
		File.rename(filename1, filename4);
		print ("We will crop this one later, master.");
	}
	close();
} 
File.makeDirectory(dir1 + "//Reviewed");
print("Finished");
