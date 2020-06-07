%let path=/home/u42959472/Capstone;
libname tps "/home/u42959472/Capstone";

/*Access Data  */
options validvarname=v7;
proc import datafile="/home/u42959472/Capstone/KSI.csv"
		dbms = csv
		out = tps.ksi
		replace;
		guessingrows=max;
run;

/*Explore Data  */
proc print data= tps.ksi (obs=30);
run;

proc contents data= tps.ksi varnum;
run;

proc sort data=tps.ksi 
	out=tps.ksi_nodups
	nodupkey;
	by _all_;
run;

proc freq data=tps.ksi_nodups nlevels;
table _char_ /noprint;
table _numeric_ /noprint;
run;

proc sort data=tps.ksi_nodups;
	by Year Date Month Var6 Time;
run;

data tps.ksi_cleaned;
	set tps.ksi_nodups;
run;

/* Analyze Data */
title "Number of KSI cases from 2008 to 2018";
proc freq data=tps.ksi_cleaned;
	table Year*Fatal /nocum nopercent plots=freqplot;
run;
title;

title "Number of KSI cases due to aggressive driving";
proc freq data=tps.ksi_cleaned;
	table Year*AG_DRIV /nocum nopercent plots=freqplot;
run;
title;
/* Fatal and Ag_Dri Cases */
%let Year=2018;
Title "Hazardous driving hot spot regions in the City of Toronto in &Year";
proc sgmap plotdata= tps.ksi_cleaned (where=(AG_DRIV=1 and Fatal=1 and Year=&Year));
   openstreetmap;
   scatter x=Longitude y=Latitude/ markerattrs=(symbol=star color=red size=10 px);
run;
title;






