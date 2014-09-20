print("Macro written by Joe Warga on 2014-01-12");
print("This script stretches the histogram from 0 to 255");

dir1 = getDirectory("Source Directory ");
list = getFileList(dir1); 
setBatchMode(true);

for (i=0; i<list.length; i++) { 
	showProgress(i+1, list.length); 
	filename1 = dir1 + list[i];
	open(filename1);
	
//Stuff to do here

	close();
} 
print("Finished");
