// single line comment
/* multiline comment
*/

print("test to show"); // this prints what is within the quotes to the log window

// convert digit to string
string = d2s(number, 0);

// write to csv, make a log
File.append(list[i] + "," + NumVar, dir1 + "//sample.csv") // syntax: File.append(writable stuff, file)

// close all open images
function CloseWin() {
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
	call("java.lang.System.gc"); // clears the garbage in Java
}
// to call this function
CloseWin()

// call macro within macro
// todo
	// send a macro a directory

// run headless

// Recursively run through the files in a user-specified directory.
dir = getDirectory("Choose Source Directory of time series of the same image"); //picks the directory to list recursively
count = 1; //initializes the variable count
setBatchMode(true); // batchmode suppresses windows from opening
listFiles(dir);  //calls the function defined below
function listFiles(dir) {
	list = getFileList(dir); // gets the list of files in variable dir, which is a folder sent to the function
		for (i=0; i<list.length; i++) { // loops through the files in the folder, {} allows multiple lines in the statement
			showProgress(i+1, list.length); // displays a completion bar, 100% = (length of list)
			if (endsWith(list[i], "/")) { // finds a folder
				print(list[i]); // prints the folder found
				listFiles(""+dir+list[i]); // recursive part, if file is folder ends with /, then run function
				}
			else{			
				print("not a folder"); // executes commands for each non folder (non-folder b/c of previous if statement)
				print(list[i]); // prints the file found
				}
	}
}




print("Finished"); // good to show when the job is over
