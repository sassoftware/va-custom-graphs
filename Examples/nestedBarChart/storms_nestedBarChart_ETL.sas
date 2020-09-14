
/******************************************************************************\
* Copyright 2020 SAS Institute Inc.
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

libname src '<-location of source data>';

data storms;
length Event_Type $ 50;
set src.D_2014 src.D_2015 src.D_2016 src.D_2017 src.D_2018;
keep EPISODE_ID BEGIN_DATE_TIME EVENT_TYPE;
run;

proc sql;
create table storms_nestedBarChart as select distinct EPISODE_ID, datepart(BEGIN_DATE_TIME) as Quarter format=QTR6.,
datepart(BEGIN_DATE_TIME) as Year format=year4., propcase(EVENT_TYPE) as Event_Type label="Event Type",
1 as totalEvents label="Total Events" format=comma8.
from storms;
quit;

