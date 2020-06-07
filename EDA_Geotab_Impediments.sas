%let path=/home/u42959472/Capstone;
libname tps "/home/u42959472/Capstone";

/*Access Data  */
options validvarname=v7;
proc import datafile="/home/u42959472/Capstone/RoadImpediments_Toronto.csv"
		dbms = csv
		out = tps.impediments
		replace;
		guessingrows=max;
run;


/*Explore Data  */
proc print data=tps.impediments (obs=30);
run;

proc contents data=tps.impediments varnum;
run;

proc sort data=tps.impediments
	out=tps.impediments_nodups
	nodupkey;
	by _all_;
run;
proc freq data=tps.impediments_nodups nlevels;
table _char_ /noprint;
table _numeric_ /noprint;
run;

proc sort data=tps.impediments_nodups;
	by AvgAcceleration ;
run;

data tps.impediments_cleaned;
	set tps.impediments_nodups; 
	Score = AvgAcceleration*PercentOfVehicles;
	drop  State ISO_3166_2 Updatedate Version;
run;

/*Analyze Data */
proc univariate data = tps.impediments_cleaned;
   histogram Score;
run;

/* Put score into bin for 5 */
proc hpbin data=tps.impediments_cleaned numbin=5 pseudo_quantile computequantile;
   input Score;
run;

data tps.impediments_bin;
set tps.impediments_cleaned;
length BIN_impediments 8;
if Score < 0.00492260 then do; BIN_impediments =     1; end; /*25th quantile and below */
else if 0.00492260 <= Score < 0.01843170 then do; BIN_impediments =     2; end; /*25th - 50th quantile */
else if 0.01843170 <= Score < 0.04679904 then do; BIN_impediments =     3; end; /*50th - 99th quantile */
else if 0.046799049 <= Score < 0.263370978 then do; BIN_impediments =     4; end; /*99th quantile and above*/
else if 0.23739755 <= Score then do; BIN_impediments =     5; end;
run;

proc freq data=tps.impediments_bin;
	tables BIN_impediments;
run;

proc univariate data = tps.impediments_bin;
   histogram BIN_impediments / endpoints=(0 to 5 by 0.5);
run;

proc sort data=tps.impediments_bin; 
By descending BIN_impediments;
run;

Title "Impediments";
proc sgmap plotdata=tps.impediments_bin (where=(BIN_impediments=5));
   openstreetmap;
   scatter x=Longitude_SW y=Latitude_SW/ 
   markerattrs=(symbol=circlefilled size=3 pt color=red);
   scatter x=Longitude_NE y=Latitude_NE / transparency=1;
run;
title;

/* goptions device=png border; */
/* goptions xpixels=2100 ypixels=1600; */


/*  */
/* Title "Impediments"; */
/* proc sgmap plotdata=tps.impediments_bin; */
/*    openstreetmap; */
/*    scatter x=Longitude y=Latitude/ COLORRESPONSE = BIN_impediments */
/*    markerattrs=(symbol=circlefilled size=8pt) */
/*    colormodel=(cx4dac26 yellow cxd7191c); */
/*    scatter x=Longitude_NE y=Latitude_NE; */
/*    gradlegend / position=right; */
/* run; */
/* title; */

/* proc export  */
/*   data=tps.impediments_bin */
/*   dbms=xlsx  */
/*   outfile="/home/u42959472/Capstone/impediments.xlsx"  */
/*   replace; */
/* run; */











