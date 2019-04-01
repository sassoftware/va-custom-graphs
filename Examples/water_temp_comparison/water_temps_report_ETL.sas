libname src 'location of imported data';

data add_month;
set src.water_data_imp;
month = date;
format month monname3.;
run;

/*  */
ods graphics off;
proc univariate data=add_month noprint;
   class month;
   histogram Water_Temp / nrows = 12 outhist=MidPtOut;
run;
proc sql noprint;
select 
max(_COUNT_) into :maxcount 
from MidPtOut;
quit;

/* Calculate medians for each month */
proc sql;
create table get_medians as select 
put(date,monname3.) as monthc,
median(water_temp) as median_water_Temp from add_month 
group by calculated monthc; 
quit;

proc means data=add_month noprint;
class Month;
var Water_Temp;
output out=medians
median=;
run;

data add_label_to_medians;
set medians;
rename Water_temp = _MIDPT_;
Vector_Y = &maxcount;
series_plot_y = 0;
label = put(Water_temp,comma2.0);
/* month = input(monthc,monname3.); */
where _TYPE_ = 1;
drop _TYPE_ _FREQ_;
run;
	
data water_temps_graph;
set MidPtOut add_label_to_medians;
zero = 0;
run;

proc sql;
create table water_temps_report
as select
month label="Month",
_MIDPT_ label="Temperatures",
_count_ label="Temperatures Frequency",
Vector_Y,
series_plot_y,
Label,
zero
from water_temps_graph;
quit;