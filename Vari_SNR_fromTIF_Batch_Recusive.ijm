print("Vari_SNR_fromTIF_Batch_Recursive.ijm");
print("Macro written by Joe Warga on 2014-04-18");
print("Updated: 2014-04-25");
print("Calculates the SNR, variance, StdDev, and Average of a set of images");
print("Source directory should contain subfolders with only the same images within one folder");

/* Note to self
This macro was running very slow and eating memory becasue I had been leaving images open
*/

// Recursively computes SNR from the files in a user-specified directory.

dir = getDirectory("Choose Source Directory of time series of the same image"); //picks the directory for recursive function
mothdir = dir;
print(dir);
count = 1; //initializes the file count
setBatchMode(true);
listFiles(dir);  //calls the function defined below

function CloseWin() {
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
}

function listFiles(dir) {
	list = getFileList(dir); // gets the list of files in variable dir
		for (i=0; i<list.length; i++) {
			// the first list item should be an image if any images are present
			if (endsWith(list[i], "/")) {
				print(" ");
				print(list[i]);
				currentfolder = dir + list[i];
				File.append("working on folder:," + dir + list[i], mothdir + "//log.csv");
				listFiles(""+dir+list[i]); // recursive part, if file is folder ends with /, then run function
				}
			else{			
				// sets up image to be the sum of others
				filename1 = dir+list[1];
				open(filename1);
				rename("sum");
				run("32-bit");
				run("Multiply...", "value=0");

				filename1 = dir+list[1];
				open(filename1);
				rename("sum1");

				// Defines file names
				Hen = d2s(list.length, 0);
				suff1 = "Variance_noise_nequals_" + Hen;
				suff2 = "StandardDeviation_noise_nequals_" + Hen;
				suff3 = "Average_nequals_" + Hen;
				suff4 = "SNR_nequals_" + Hen;


				for (i=0; i<list.length; i++) {
					showProgress(i+1, list.length);
					filename1 = dir+list[i];
					open(filename1);
					//print(i);
					print(list[i]);
				}


				//finding the average
				for (i=1; i<list.length; i++) {
					showProgress(i+1, list.length);
					imageCalculator("Add 32-bit", "sum1", list[i]);
					rename("sum2");
					selectWindow("sum1");
					close();
					selectWindow("sum2");
					rename("sum1");
				}

				selectWindow("sum1");
				NNN = "value=" + Hen;
				run("Divide...", NNN);
				saveAs("TIFF", dir+suff3);
				rename("Avg");
				print("Saved the average!");

				for (i=0; i<list.length; i++) {
					showProgress(i+1, list.length);
					for (j=0; j<list.length; j++) {
						imageCalculator("Subtract create 32-bit", list[i], list[j]);
						//d2s converts digits to strings with 0 as the number of decimal places
						RNamei = d2s(i, 0);
						RNamej = d2s(j, 0);
						RName = RNamei + " " + RNamej;
						rename(RName);
						run("Square");
						run("Divide...", "value=2.000");
						imageCalculator("Add create 32-bit", "sum", RName);
						selectWindow("Result of sum");
						rename("sum0");
						selectWindow("sum");
						close();
						selectWindow("sum0");
						rename("sum");
						selectWindow(RName);
						close();
						//print(i, j);
					}
				}


				selectWindow("sum");
				nsqr = (list.length)*(list.length);
				NSQR = "value=" + d2s(nsqr, 3);
				run("Divide...", NSQR);
				saveAs("TIFF", dir+suff1);
				print("Saved the variance!");
				run("Square Root");
				saveAs("TIFF", dir+suff2);
				print("Saved the standard deviation!");

				open(dir+suff2+".tif");
				rename("StDev");
				open(dir+suff3+".tif");
				rename("Av");
				imageCalculator("Divide 32-bit", "Av", "StDev");

				rename("SNR");
				saveAs("TIFF", dir+suff4);
				print("Saved the SNR!");
				File.append("folder completed:," + currentfolder, mothdir + "//log.csv");
				CloseWin();
				call("java.lang.System.gc");
				}
	}
}


// single line comment
/* multiline comment
*/

print("Finished");
