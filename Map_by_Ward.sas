/* Import shapefile of Canadian FSA codes */
proc mapimport datafile="/home/u42959472/Capstone/lfsa000b16a_e.shp"  /* Insert folder path */
            out=tproj;
run;

/* Change projection if map is distorted */
/*
proc gproject data=TEMPT out=tproj degrees eastlong;
id CFSAUID PRNAME;
run;
*/

data tproj2;
   set tproj;
   first=substr(cfsauid,1,1);
run;

/* Graphics options to be used for all maps */
goptions reset=all ftext='calibri' htext=2 gunit=pct;
ods graphics / MAXOBS=4913051;

/* Create choropleth map of Ontario */
title "Province of Ontario by FSA (2016)";
proc gmap data=tproj map=tproj2;
    WHERE PRNAME=:'Ontario';
    id CFSAUID PRNAME;
    choro segment / nolegend levels=1 coutline=white;
run;
quit;

/* Create choropleth map of Toronto */
title "City of Toronto by FSA (2016)";
proc gmap data=tproj2 map=tproj2;
   WHERE first='M';
   id CFSAUID PRNAME;
   choro segment / nolegend levels=1 coutline=white;
run;
quit;

proc import datafile = '/home/u42959472/Capstone/ward_accidents.xlsx'
DBMS = xlsx OUT =ward_map replace;
quit;

/* Choropleth map of Toronto: adding colors to number of accidents */
title "Number of Accidents By Ward";
/* footnote "*Population densities are clearly made up"; */
proc gmap data=work.ward_map map=tproj2;
/*    WHERE first='M'; */
   id CFSAUID PRNAME;
   choro Accident /  cdefault=yellow levels=5 /*creates 10 bins for the gradient of the map and legend*/ coutline=gainsboro ;
run;
quit;

proc import datafile = '/home/u42959472/Capstone/ward_fatalites.xlsx'
DBMS = xlsx OUT =ward_fatalities replace;
quit;

/* Choropleth map of Toronto: adding colors to number of accidents */
title "Number of Fatalities By Ward";
/* footnote "*Population densities are clearly made up"; */
proc gmap data=work.ward_fatalities map=tproj2;
/*    WHERE first='M'; */
   id CFSAUID PRNAME;
   choro Fatalities /  cdefault=yellow levels=5 /*creates 10 bins for the gradient of the map and legend*/ coutline=gainsboro;
run;
quit;

proc import datafile = '/home/u42959472/Capstone/fatalities.xlsx'
DBMS = xlsx OUT =fatalities replace;
quit;

proc gmap data=fatalities map=tproj2;
/*    WHERE first='M'; */
   id CFSAUID PRNAME;
   choro Fatalities /  cdefault=yellow levels=5 /*creates 10 bins for the gradient of the map and legend*/ coutline=gainsboro;
run;
quit;

