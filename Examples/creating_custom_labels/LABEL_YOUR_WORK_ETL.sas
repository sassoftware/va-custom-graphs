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

libname source '<-location of downloaded data->';

/* sort the data */
proc sort data=source.movie_box_office out=sorted;
by released descending domestic;
run;


data labelyourwork;
set sorted;

/* return only movies after 1995 */
where released ge 1995;

/* create the "Label" Column */
if rank le 3 then label=scan(trim(movie),1,':');
else label="";

/* create the "Label" Column */
if rank le 3 then label_val=domestic;
else label_val=.;

/* Create the Years Column */
years = mdy(12,31,released);
format years year2.;

/* Return only the highest grossing film for each year */
by released descending domestic;
if first.released then output;

/* drop unecessary columns */
drop rank released ;
run;