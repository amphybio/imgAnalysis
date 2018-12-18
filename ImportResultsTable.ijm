// Import Results Table
//
// This macro populates a fresh "Results" table
// from a saved ImageJ results table, or from
// any tab or comma-separated data file.

// This macro is built into ImageJ 1.38r and
// later as the 'File>Import>Results...' command.

// Image size
imgWidth = 400;
imgHeight = 400;

 macro "Import Results Table" {
     requires("1.35r");
     lineseparator = "\n";
     cellseparator = "\t";

     // copies the whole RT to an array of lines
     lines=split(File.openAsString(""), lineseparator);

     // recreates the columns headers
     labels=split(lines[0], cellseparator);
     if (labels[0]==" ")
        k=1; // it is an ImageJ Results table, skip first column
     else
        k=0; // it is not a Results table, load all columns
     for (j=k; j<labels.length; j++)
        setResult(labels[j],0,0);

     // dispatches the data into the new RT
     run("Clear Results");
     for (i=1; i<lines.length; i++) {
        items=split(lines[i], cellseparator);
        for (j=k; j<items.length; j++)
           setResult(labels[j],i-1,items[j]);
     }
     updateResults();


	// get the cell positions
	X = newArray(nResults);
	Y = newArray(nResults);

	for (l = 0; l < nResults; l++) {
		X[l] = getResult("X", l);
		Y[l] = getResult("Y", l);
	}
	//run("Close");

	// generate empty image
	setForegroundColor(255, 255, 255);
	setBackgroundColor(0, 0, 0);
	newImage("temp", "32-bit black", imgWidth, imgHeight, 1);

	for(l = 0; l < nResults; l++) {
		makePoint(X[l], Y[l]);
		fill();
	}
	run("Select None");
	imgID = getImageID();
	imgName = File.nameWithoutExtension;
 }
