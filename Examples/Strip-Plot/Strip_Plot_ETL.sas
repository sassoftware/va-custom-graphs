libname src '<-location of imported data->';
data src;
set src.simulated_water_temps;
run;


data addcols;
set src;
month_num = put(month(date),z2.);
month = date;
format month monname3.;
Jitter=rannor(0)/100;
zero = 0;
run;

proc sql;
create table waterTempStripPlot as select Month label="Month",
water_Temp label="Water Temp",  Jitter, zero, min(water_Temp) as min, 
max(water_Temp) as max, median(water_Temp) as Median label="Median"
from addcols group by month_num;
quit;
