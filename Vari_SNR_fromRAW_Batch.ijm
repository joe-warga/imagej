print("Vari_SNR_fromRAW_Batch.ijm");
print("Macro written by Joe Warga on 2014-02-25");
print("Calculates the SNR, variance, StdDev, and Average of a set of images");
dir1 = getDirectory("Choose Source Directory of time series of the same RAW image (flats)");
list = getFileList(dir1);

setBatchMode(true);

ImWidth=4032;
ImHeight=2688;

//open(dir1+list[1]);
filename1 = dir1+list[1];
run("Raw...", "open=filename1 image=8-bit width=ImWidth height=ImHeight offset=2 number=1 gap=0");
rename("sum")
run("32-bit");
run("Multiply...", "value=0");

filename1 = dir1+list[1];
run("Raw...", "open=filename1 image=8-bit width=ImWidth height=ImHeight offset=2 number=1 gap=0");
rename("sum1")
//run("Multiply...", "value=0");

Hen = d2s(list.length, 0);
suff1 = "Variance_noise_nequals_" + Hen;
suff2 = "StandardDeviation_noise_nequals_" + Hen;
suff3 = "Average_nequals_" + Hen;
suff4 = "SNR_nequals_" + Hen;


for (i=0; i<list.length; i++) {
showProgress(i+1, list.length);
filename1 = dir1+list[i];
run("Raw...", "open=filename1 image=8-bit width=ImWidth height=ImHeight offset=2 number=1 gap=0");
print(i);
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
saveAs("TIFF", dir1+suff3);
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
print(i, j);
}
}


selectWindow("sum");
nsqr = (list.length)*(list.length);
NSQR = "value=" + d2s(nsqr, 3);
run("Divide...", NSQR);
//print(NSQR);
saveAs("TIFF", dir1+suff1);
print("Saved the variance!");
run("Square Root");
saveAs("TIFF", dir1+suff2);
rename("StdDev");
print("Saved the standard deviation!");

open(dir1+suff2+".tif")
rename("StDev")
open(dir1+suff3+".tif")
rename("Av")
imageCalculator("Divide 32-bit", "Av", "StDev");

rename("SNR");
saveAs("TIFF", dir1+suff4);
print("Saved the SNR!");
print("Finished");