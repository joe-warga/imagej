print("Script converts a 32 bit image to an 8 bit image, if the values are supposed to be 8 bit");
print("therefore the values must already be between 0 and 255");
print("Macro written by Joe Warga on 2014-04-11");

	//make sure converting back to 8-bit is scaled right
	setMinAndMax(0, 256);
	makeRectangle(1, 1, 2, 1);
	run("Multiply...", "value=0.000");
	makeRectangle(1, 1, 1, 1);
	run("Add...", "value=255");
	run("8-bit");
	makeRectangle(1, 1, 1, 1);
	run("Subtract...", "value=255");
	//saveAs("TIFF");
	
print("Finished");
