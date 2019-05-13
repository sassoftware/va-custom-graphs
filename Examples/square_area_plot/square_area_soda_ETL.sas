/******************************************************************************\
* Copyright 2019 SAS Institute Inc.
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

libname src '<- location of source data ->';

/* create "Tall" data */
proc sql;
create table males as select
state,
"Males" as Gender length = 7,
(soda_percent_male/100) as Values
from src.drinking_soda;
quit;
proc sql;
create table females as select
state,
"Females" as Gender length = 7,
(soda_percent_female/100) as Values
from src.drinking_soda;
quit;

data soda_percentages;
set males females;
run;


/* Join data to data square_area_graph template */

data soda_percentages_JP;
set soda_percentages;
Join = "join";
run;
proc sql;
create table joined as select
t2.state, t2.gender, t2.values, 
t1.upper_bound, t1.template_column_start, t1.template_column_end, t1.template_row, label_location
from src.SQG_template as t1
left join soda_percentages_JP as t2
on (t1.Join=t2.Join);
run;

/* creat colored sections */
data soda_square_area_graph;
set joined;
if values le upper_bound  then colored_block_start =.;
else colored_block_start = template_column_start;
if values le upper_bound then colored_block_end =.;
else colored_block_end = template_column_end;
label = put(Values,percent8.1);
if colored_block_start = . then color = 0;
else if Gender = "Males" then color = 1;
else color = 2; 
run;

