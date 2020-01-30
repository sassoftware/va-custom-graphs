
libname src '<-location of source data>';

proc sql;
create table dailyAVGTemps as select
Date, avg(Air_Temp) as avg_air_temp format=best4.0 from src.airtemps
group by Date;
quit;

%let baseline = 65;

data formatData;
set dailyAVGTemps;
tempDiff = (round(avg_air_temp - &baseline));
DayOfYear = Date - intnx('year',Date,0)+1;
run;

proc sql;
create table joinToTemplate as select
t1.*, t2.*
from formatData as t1
left join src.CircleTemplate as t2
on (t1.dayofyear = t2.dayofyear) and (put(t1.tempDiff,best3.0) = put(t2.tempDiff,best3.0));
quit;

data AirTempCircleData;
set joinToTemplate;
if substr(put(date,date9.),1,5) = "01JAN" then LabelX = 0;
else if substr(put(date,date9.),1,5) = "01APR"  then LabelX = x_base+(x_base*.20);
else if substr(put(date,date9.),1,5) = "01JUL"  then LabelX = 0;
else if substr(put(date,date9.),1,5) = "01OCT" then LabelX = x_base+(x_base*.25);

if substr(put(date,date9.),1,5) = "01JAN" then LabelXOrigin = 0;
else if substr(put(date,date9.),1,5) = "01APR"  then LabelXOrigin = x_base;
else if substr(put(date,date9.),1,5) = "01JUL"  then LabelXOrigin =  0;
else if substr(put(date,date9.),1,5) = "01OCT" then LabelXOrigin = x_base;

if substr(put(date,date9.),1,5) = "01JAN" then LabelYOrigin = y_base;
else if substr(put(date,date9.),1,5) = "01APR" then LabelYOrigin = 0;
else if substr(put(date,date9.),1,5) = "01JUL" then LabelYOrigin = y_base;
else if substr(put(date,date9.),1,5) = "01OCT" then LabelYOrigin = 0;

if substr(put(date,date9.),1,5) = "01JAN" then LabelY = y_base+(y_base*.20);
else if substr(put(date,date9.),1,5) = "01APR" then LabelY = 0;
else if substr(put(date,date9.),1,5) = "01JUL" then LabelY = y+(y*.15);
else if substr(put(date,date9.),1,5) = "01OCT" then LabelY = 0;

if substr(put(date,date9.),1,5) = "01JAN" then Label = "Jan";
else if substr(put(date,date9.),1,5) = "01APR" then Label = "Apr";
else if substr(put(date,date9.),1,5) = "01JUL" then Label = "Jul";
else if substr(put(date,date9.),1,5) = "01OCT" then Label = "Oct";

XscatterLabel = LabelX;
YscatterLabel = LabelY;

length color $ 10;
if avg_air_temp gt &baseline then color = "Above";
else if avg_air_temp lt &baseline then color = "Below";
else color = "Equal";

baselineTemp = &baseline;

run;