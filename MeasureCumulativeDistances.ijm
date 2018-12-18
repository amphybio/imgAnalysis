// Measure Cumulative Distances
//
// This macro measures�cumulative distances along a 
// segmented line selection or between the points
// of a point selection.

  macro "Measure Cumulative Distances [1]" {
     if (!(selectionType==6||selectionType==10))
         exit("Segmented line or point selection required");
     getSelectionCoordinates(x, y);
     if (x.length<2)
         exit("At least two points required");
     getPixelSize(unit, pw, ph);
     n = nResults;
     distance = 0;
     for (i=1; i<x.length; i++) {
        dx = (x[i] - x[i-1])*pw;
        dy = (y[i] - y[i-1])*ph;
        distance += sqrt(dx*dx + dy*dy);
        setResult("D"+i, n, distance);
     }
     updateResults;
  }
