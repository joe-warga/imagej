print("Variance_Time_noise_Batch");
print("Macro written by Joe Warga on 2013-12-20");
dir1 = getDirectory("Choose Source Directory of time series of the same image (flats)");
list = getFileList(dir1);


setBatchMode(true);

open(dir1+list[1]);
rename("sum")
run("32-bit");
run("Multiply...", "value=0");

Hen = d2s(list.length-1, 0);
suff1 = "Variance_noise_nequals_" + Hen;
suff2 = "StandardDeviation_noise_nequals_" + Hen;


for (i=0; i<list.length-1; i++) {
showProgress(i+1, list.length);
open(dir1+list[i]);
print(i);
print(list[i]);
}

for (i=0; i<list.length-1; i++) {
for (j=0; j<list.length-1; j++) {
imageCalculator("Subtract create 32-bit", list[i], list[j]);
//d2s converts digits to strings with 0 as the number of decimal places
RNamei = d2s(i, 0);
RNamej = d2s(j, 0);
RName = RNamei + " " + RNamej;
rename(RName);
run("Square");
run("Divide...", "value=2.000");
imageCalculator("Add 32-bit", "sum",RName);
selectWindow(RName);
close();
print(i, j);
}
}
selectWindow("sum");
nsqr = (list.length-1)*(list.length-1);
NSQR = "value=" + d2s(nsqr, 3);
run("Divide...", NSQR);
//print(NSQR);
saveAs("TIFF", dir1+suff1);
run("Square Root");
saveAs("TIFF", dir1+suff2);
print("Finished");