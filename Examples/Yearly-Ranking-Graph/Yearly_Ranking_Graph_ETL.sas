/*Copyright © 2018, SAS Institute Inc., Cary, NC, USA.  All Rights Reserved.*/
/**/
/*Licensed under the Apache License, Version 2.0 (the "License");*/
/*you may not use this file except in compliance with the License.*/
/*You may obtain a copy of the License at*/
/**/
/*    https://www.apache.org/licenses/LICENSE-2.0*/
/**/
/*Unless required by applicable law or agreed to in writing, software*/
/*distributed under the License is distributed on an "AS IS" BASIS,*/
/*WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*/
/*See the License for the specific language governing permissions and*/
/*limitations under the License.*/

libname src '<- location of your source data ->';
data start;
set src.turkey_production;
run;

/* flip the data */
data append;
append = "append";
run;

%macro turkey(var);

proc sql;
create table src as select
state,
&var as year,
lbs_produced_1000_lbs_&var. as value
from start;
quit;

data pre_append;
set append;
run;

data append;
set pre_append src;
run;

%mend turkey;
%turkey(2012);
%turkey(2010);
%turkey(2008);
%turkey(2006);


data flipped_data;
set append;
where append ne "append";
drop append;
run;

/* create ranks */

proc sort data=flipped_data;
by year;
run;

proc rank data=flipped_data out=ranked ties=low descending;
   by Year;
   var Value;
   ranks Rank_n;
run;

/* add schedule chart columns */

data schedule_chart_prep;
set ranked;
length Rank $ 4;
Rank = put(Rank_n,z2.);
Period_start = input(compress('01jan' || year),date9.);
Period_finish = intnx('Year',Period_start,1,'same');
format Period_start year4.;
format Period_finish year4.;
length rank $ 25;
drop years;
where rank_n le 6;
run;

/* add series plot columns */

data series_plot_prep;
set schedule_chart_prep;
do i=1 to 2;
if i = 1 then seriesx = Period_start;
else if i = 2 then seriesx = Period_finish;
format seriesx year4.;
output;
end;
run;

/* create label data and append to main data */

proc sql;
create table add_labels as select
t1.Rank,
t1.Period_start,
t1.Period_start as Period_finish,
catx(': ',catx(' - ',t1.Rank,t2.statename),put(t1.value,comma9.0)) as label,
t2.statename
from series_plot_prep as t1 
left join maps.us2 as t2 on (t1.state=t2.statecode)
where t1.i = 1;
quit;

data ranks_ready;
set series_plot_prep add_labels;
run;
