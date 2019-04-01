/******************************************************************************\
* Copyright 2018 SAS Institute Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
* https://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* Author: Michael Drutar
\******************************************************************************/

libname src '<-location of source data->';

/*Make Year, date and season columns*/ 
data create_vars; 
set src.source_precip_data; 
year = put(year(date),best4.); 
day = put(date-intnx('year',date,0),z2.); 
if year = year(today()) then Season = "This Year"; 
else Season = "Last Year";
/*Get just the first quarter*/ 
where date-intnx('year',date,0) le 89; 
run; 
/*Create running total*/ 
data running_total; 
set create_vars; 
by year; 
if first.year 
then Running_total=0; 
Running_total + Precip; 
run;
proc sql; 
create table Last_year 
as select *, 
max(Running_total) as Last_Years_total 
from running_total where Season = "Last Year"; 
quit; 

/* create label for Max Value from last year */ 
data Last_year; 
set Last_year; 
by season; 
if first.Season then Last_Year_Total_label = "Total Last Year: " || compress(put(Last_Years_total,comma8.2)); 
run; 

/* Create values for the "Current Bubble" */ 
data This_year; 
set running_total; 
by Season; 
if last.season then Bubble_Value = Running_total; 
if last.season then Bubble_Label = "Current Total: " || Compress(put(Running_total,comma8.2)); 
if last.season then Bubble_Color = "Current Value"; where Season = "This Year"; run; 

/* Join together Last_Year and This_Year data */ 

proc sql; create table report_ready 
as select t1.Day label="Day of Year", 
t1.Running_total as Last_Year format=comma8.2, 
t1.Last_Years_total format=comma8.2, 
t1.Last_Year_Total_label, 
t2.Running_total as This_year format=comma8.2, 
t2.Bubble_Value as Bubble_Value, 
t2.Bubble_Label, 
t2.Bubble_Color, . 
as series_plot_value 
from Last_Year as t1 
full join This_year as t2 
on (t1.Day = t2.Day); 
quit;

