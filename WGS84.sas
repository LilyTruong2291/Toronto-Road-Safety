%let path=/home/u42959472/Capstone;
libname tps "/home/u42959472/Capstone";

/*Access Data  */
proc mapimport datafile="/home/u42959472/Capstone/ADDRESS_POINT_WGS84.shp" out=tps.addresspoint;
	 exclude X Y ;
run;

/*Explore Data  */
proc print data=tps.addresspoint (obs=30);
run;

proc contents data=tps.addresspoint varnum;
run;

proc sort data=tps.addresspoint
	out=tps.addresspoint_nodups
	nodupkey;
	by _all_;
run;

proc freq data=tps.addresspoint_nodups nlevels;
table _char_ /noprint;
table _numeric_ /noprint;
run;

data tps.addresspoint_cleaned;
	set tps.addresspoint_nodups; 
	keep X Y GEO_ID MAINT_STAG ADDRESS FCODE FCODE_DES LONGITUDE LATITUDE OBJECT_ID WARD_NAME ;
run;

/* Analyze Data */
/*Distance between places are less than 0.1 km to the impediments  */
proc sql;
	create table tps.distance_impediments as
		select w.FCODE as ID, w.FCODE_DES as Description, w.X as Lat1, w.Y as Long1, 
			i.Latitude as Lat2, i.Longitude as Long2,
			GEODIST(w.LATITUDE, w.LONGITUDE, i.Latitude, i.Longitude,'K') as distance_impediments
		from tps.addresspoint_cleaned as w, tps.impediments_bin as i 
		where calculated distance_impediments LE 0.1 and i.BIN_impediments=5
		order by distance_impediments;
quit;

proc freq data=tps.distance_impediments nlevels;
	table Description;
run;

/*Distance between Ag_Driving are less than 0.1 km to the hazardous driving  */
proc sql;
	create table tps.ag_hazardriving as
		select k.latitude as lat3, k.longitude as long3, k.ag_driv,
			h.latitude as lat4, h.longitude as long4,
			geodist(k.latitude, k.longitude, h.latitude, h.longitude, 'K') as ag_hazardriving
		from tps.ksi_cleaned as k, tps.hazdriving_10percent as h
		where calculated ag_hazardriving LE 0.1 and k.ag_driv=1
		order by ag_hazardriving;
quit;

/*Distance between Ag_Driving are less than 0.1 km to the Impediments */
proc sql;
	create table tps.ag_impediments as
		select k.latitude as lat3, k.longitude as long3, k.ag_driv,
			i.Latitude as Lat2, i.Longitude as Long2,
			geodist(k.latitude, k.longitude, i.latitude, i.longitude, 'K') as ag_impediments
		from tps.ksi_cleaned as k, tps.impediments_bin as i 
		where calculated ag_impediments LE 0.1 and k.ag_driv=1 and i.BIN_impediments=5
		order by ag_impediments;
quit;

/*Distance between Locations are less than 0.1 km to the ag_impediments */
proc sql;
	create table tps.distance_ag_impediments as
		select w.FCODE as ID, w.FCODE_DES as Description, w.WARD_NAME,
		w.X as Lat1, w.Y as Long1, 
		a.Lat3 as Lat4, a.Long3 as Long4,
		GEODIST(w.LATITUDE, w.LONGITUDE, a.Lat3, a.Long3) as distance_ag_impediments
		from tps.addresspoint_cleaned as w,  tps.ag_impediments as a 
		where calculated distance_ag_impediments LE 0.1 
		order by distance_ag_impediments;
quit;

proc sort data=tps.distance_ag_impediments
	out=tps.distance_ag_impediments_nodups
	nodupkey;
	by _all_;
run;

proc freq data=tps.distance_ag_impediments nlevels;
	table ID;
run;

/*Distance between Locations are less than 0.1 km to the ag_hazdriving */
proc sql;
	create table tps.distance_ag_hazdriving as
		select w.FCODE as ID, w.FCODE_DES as Description, w.WARD_NAME,
		w.X as Lat1, w.Y as Long1, 
		a.Lat3 as Lat4, a.Long3 as Long4,
		GEODIST(w.LATITUDE, w.LONGITUDE, a.Lat3, a.Long3) as distance_ag_hazdriving
		from tps.addresspoint_cleaned as w, tps.ag_hazardriving as a 
		where calculated distance_ag_hazdriving LE 0.1 
		order by distance_ag_hazdriving;
quit;
