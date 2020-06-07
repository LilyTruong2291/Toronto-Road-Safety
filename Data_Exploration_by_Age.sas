Title "Pedestrian Related Accidents by Age";
proc sgplot data=KSI;
  vbar AGE / response=PEDESTRIAN datalabel
       categoryorder=respdesc nostatlabel  fillattrs=(color=orange);;
  xaxis grid display=all;
  yaxis grid discreteorder=data display=all;
run;
title;

Title "Pedestrian Related Fatalities by Age";
proc sgplot data=KSI;
  vbar AGE / response=FATAL datalabel
       categoryorder=respdesc nostatlabel  fillattrs=(color=orange);;
  xaxis grid display=all;
  yaxis grid discreteorder=data display=all;
  where Pedestrian=1;
run;
title;

Title "55+ Pedestrian Related Accidents in Each Ward";
proc sgplot data=KSI;
  vbar WardNum/ response=PEDESTRIAN datalabel
       categoryorder=respdesc nostatlabel  fillattrs=(color=orange);;
  xaxis grid display=all;
  yaxis grid discreteorder=data display=all;
  where  Age ='55+' and Pedestrian=1 and Fatal=1;
run;
title;

