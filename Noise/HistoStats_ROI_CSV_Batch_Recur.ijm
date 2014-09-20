print("Macro written by Joe Warga on 2014-07-14");
print("This script puts statistics from images into a csv");

p = "/Users/joewarga/Documents/flats/1c-noise/NoiseStats.txt";
// f = File.open(p); // create the file to write to, deletes if exists
dir1 = getDirectory("Choose Source Directory"); //picks the directory to list recursively
count = 1; //initializes the file count
setBatchMode(true);
listFiles(dir1);  //calls the function defined below
print(dir1);

function CloseWin() {
	while (nImages>0) {
		selectImage(nImages);
		close();
	}
}

function listFiles(dir) {
	list = getFileList(dir); // gets the list of files in variable dir
		for (i=0; i<list.length; i++) {
			if (endsWith(list[i], "/")) {
				print(" ");
				//if (startsWith(list[i],"090")){
				//	hwid = list[i];
				//	}
				print(list[i]);
				listFiles(""+dir+list[i]); // recursive part, if file is folder ends with /, then run function
				}
			else{			
				print("not a folder");
				if (startsWith(list[i], 'average')) {
					print("Found the average, MFer " + list[i]);
					print("dir: " + dir);
					print("average image: " + list[i]);
					StatsAndStats("" + dir + list[i]);
					}
				if (startsWith(list[i], 'SNR')) {
					print("Found the SNR, MFer " + list[i]);
					print("dir: " + dir);
					print("SNR image: " + list[i]);
					StatsAndStats("" + dir + list[i]);
					}
				if (startsWith(list[i], 'StdDev')) {
					print("Found the StdDev, MFer " + list[i]);
					print("dir: " + dir);
					print("StdDev image: " + list[i]);
					StatsAndStats("" + dir + list[i]);
					}
				}
	}
}


function StatsAndStats(im) {
	//p = "/Users/joewarga/Documents/flats/1c-noise/NoiseStats.txt";
	open(im);
	imWidth = getWidth;
	imHeight = getHeight;
	// File.append(imWidth, p);
	// File.append(imHeight, p);

	factor = 0.1; // factor of the image to be used as ROI
	w = round(factor * imWidth);
	h = round(factor * 2 * imHeight);
	// print(f, w);
	// print(f, h);

	// buffer from center line
	buff = 0.01;
	CenterBuffer = round(buff * imWidth);
	// print(f, CenterBuffer);

	// Define ROI, a
	xa0 = imWidth / 2 - w - CenterBuffer;
	ya0 = round((imHeight - h) / 2);
	w = w;
	h = h;
	makeRectangle(xa0, ya0, w, h);
	getStatistics(area0, mean0, min0, max0, std0, histogram0);
	
	// Define ROI, b (mirror about verticle center)
	xb0= ((imWidth/2)+CenterBuffer) ;
	yb0 = round((imHeight - h) / 2);
	makeRectangle(xb0, yb0, w, h);
	getStatistics(area1, mean1, min1, max1, std1, histogram1);
	
	File.append(im + ',left,' + area0 + ',' + mean0 + ',' + min0 + ',' + max0 + ',' + std0 + ',right,' + area1 + ',' + mean1 + ',' + min1 + ',' + max1 + ',' + std1, p);
	//File.append(im + ',right,' + area + ',' + mean + ',' + min + ',' + max + ',' + std, p);
	
	CloseWin();
}


/*
*/
print("Finished");