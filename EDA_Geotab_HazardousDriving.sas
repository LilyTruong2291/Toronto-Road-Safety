%let path=/home/u42959472/Capstone;
libname tps "/home/u42959472/Capstone";

/*Access Data  */
options validvarname=v7;
proc import datafile="/home/u42959472/Capstone/Hazardous Driving_Toronto.csv"
		dbms = csv
		out = tps.hazdriving
		replace;
		guessingrows=max;
run;

/*Explore Data  */
proc print data=tps.hazdriving (obs=30);
run;

proc contents data=tps.hazdriving varnum;
run;

proc sort data=tps.hazdriving
	out=tps.hazdriving_nodups
	nodupkey;
	by _all_;
run;

proc freq data=tps.hazdriving_nodups nlevels;
table _char_ /noprint;
table _numeric_ /noprint;
run;

proc sort data=tps.hazdriving_nodups;
	by SeverityScore ;
run;

data tps.hazdriving_cleaned;
	set tps.hazdriving_nodups; 
	drop  State ISO_3166_2 Updatedate Version;
run;
/* Analyze Data */
Title "Hazardous driving hot spot regions in the City of Toronto";
proc sgmap plotdata=tps.hazdriving_cleaned;
   openstreetmap;
   scatter x=Longitude_SW y=Latitude_SW/ markerattrs=(symbol=star color=red size=10 px);
   scatter x=Longitude_NE y=Latitude_NE / transparency=1;
run;
title;

/* top 10 % of Severity Score */
proc sort data=tps.hazdriving_cleaned; 
By descending SeverityScore;
run;

data tps.hazdriving_10percent;
  set tps.hazdriving_cleaned;
  if n/&sqlobs. gt .1 then stop;
  output;
run;

Title "Hazardous driving hot spot regions in the City of Toronto";
proc sgmap plotdata=tps.hazdriving_10percent;
   openstreetmap;
   scatter x=Longitude_SW y=Latitude_SW/ markerattrs=(symbol=star color=red size=10 px);
   scatter x=Longitude_NE y=Latitude_NE / transparency=1;
run;
title;

proc export 
  data=tps.hazdriving_10percent
  dbms=xlsx 
  outfile="/home/u42959472/Capstone/hazdriving_10percent.xlsx" 
  replace;
run;
