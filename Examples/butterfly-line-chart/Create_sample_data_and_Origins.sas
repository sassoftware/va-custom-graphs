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
*
* Input: simulated SAS Dataset
*
* Output: The output SAS Dataset flight_delays sourced from the simulated 
* input dataset.
* 
\******************************************************************************/

/* simulate some data */

data source_data;
  input Year $ Hour_of_Day Arrival_Delays Departure_Delays;
datalines;
2014 0 15 9
2014 1 22 12	
2014 2 30 17
2014 3 35 23
2014 4 31 20
2014 5 14 12
2014 6 5 5
2014 7 12 10
2014 8 20 22
2014 9 25 30
2014 10 33 38
2014 11 41 45
2014 12 55 61
2014 13 68 73
2014 14 78 81
2014 15 90 99
2014 16 111 122
2014 17 127 141
2014 18 135 150
2014 19 120 135
2014 20 99 110
2014 21 66 71
2014 22 41 55
2014 23 22 31
2015 0 16 12
2015 1 26 15	
2015 2 35 22
2015 3 41 30
2015 4 40 28
2015 5 25 15
2015 6 9 12
2015 7 14 19
2015 8 25 31
2015 9 31 36
2015 10 29 41
2015 11 48 51
2015 12 63 67
2015 13 72 78
2015 14 84 85
2015 15 95 110
2015 16 122 131
2015 17 135 148
2015 18 133 159
2015 19 125 141
2015 20 103 119
2015 21 71 86
2015 22 49 65
2015 23 21 30
;
run;

proc sort data=source_data; 
by Year Hour_of_Day;
run;

/* Create the Origin Values */
data create_origins;
  set source_data;
  by year;
  Hour_of_Day_Origin=lag(Hour_of_Day);
  if first.year then Hour_of_Day_Origin=.;
  
  Arrival_Delays_Origin=lag(Arrival_Delays);
  if first.year then Arrival_Delays_Origin=.;
  
  Departure_Delays_Origin=lag(Departure_Delays);
  if first.year then Departure_Delays_Origin=.;
run;

/* do some formatting */
proc sql;
create table flight_delays as select
Year,
Hour_of_Day_Origin label="Hour of Day Origin",
Hour_of_Day label="Hour of Day",
Arrival_Delays_Origin label="Delayed Arrivals Origin" format=comma8.0,
Arrival_Delays label="Delayed Arrivals" format=comma8.0,
Departure_Delays_Origin label="Delayed Departures  Origin" format=comma8.0,
Departure_Delays label="Delayed Departures" format=comma8.0
from create_origins
where Hour_of_Day_Origin ne .;
quit;

