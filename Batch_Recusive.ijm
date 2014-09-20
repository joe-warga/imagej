print("Batch_Recursive.ijm");
print("Macro written by Joe Warga on 2014-04-22");
print("The script is a generic recursive script");

// Recursively runs through the files in a user-specified directory.

dir = getDirectory("Choose Source Directory of time series of the same image"); //picks the directory to list recursively
count = 1; //initializes the file count
setBatchMode(true);
listFiles(dir);  //calls the function defined below

function listFiles(dir) {
	list = getFileList(dir); // gets the list of files in variable dir
		for (i=0; i<list.length; i++) {
			if (endsWith(list[i], "/")) {
				print(" ");
				print(list[i]);
				listFiles(""+dir+list[i]); // recursive part, if file is folder ends with /, then run function
				}
			else{			
				print("not a folder");
				}
	}
}


// single line comment
/* multiline comment
*/

print("Finished");