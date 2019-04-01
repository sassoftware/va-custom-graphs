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

libname in '<-location of source data->;
/*Total each day's number of observations */
proc sql;
create table Source_data as select
FL_Date, Count(1) as Total_Flights 
from in.flight_data group by FL_Date;
quit;

/*Add needed columns*/
data Add_Columns;
set Source_data;
/* get the current week of the year */
Week = week(FL_Date,'U');
/* get the next week of the year */
Next_Week = week(FL_Date,'U')+1;
/* get the day of the week */
weekday = FL_Date;
format weekday weekdate9.;
/* get the Year*/
Year = FL_Date;
format Year Year4.;
/* format the FL_Date to day of year */
format FL_Date day.;
/* rename FL_Date to Day */
rename FL_Date = Day;
run;

/*sort the data*/
proc sort data=Add_Columns out=sorted;
by year day;
run;

/*Create ranks*/
proc rank data=sorted descending out=ranks groups=5;
   by year;
   var Total_Flights;
run;

/*add ranks back to original data*/
proc sql;
create table December_Travel   as select t1.*, 
put(t2.Total_Flights+1,z1.) as Rank 
from Add_Columns as t1 left join ranks as t2 on (t1.day=t2.day);
quit;