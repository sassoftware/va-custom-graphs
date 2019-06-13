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

/* Reshape data from 'wide' to 'tall' */
/* keep only certain types of fires */
DATA reshape_data ;
  SET src.nonresidential_fire_damage;
	length cause $ 40;
    Cause = "Smoking";  cost = Smoking ; OUTPUT ;
    Cause = "Cooking";  cost = Cooking ; OUTPUT ;
    Cause = "Appliances";  cost = Appliances ; OUTPUT ;
    Cause = "Heating";  cost = Heating ; OUTPUT ;
    Cause = "Playing with Heat Source";  cost = Playing_with_Heat_Source ; OUTPUT ;
    Cause = "Exposure";  cost = Exposure  ; OUTPUT ;
    Cause = "Natural";  cost = Natural  ; OUTPUT ;
keep  Year Cause cost;
run;

/* Add Min and Max Data values */
proc sql;
create table minmax as select
*,
min(cost) as Min,
max(cost) as Max
from reshape_data
group by year;
quit;

/* create format to display values on graph */
/* sourced from Chris Hemedinger's blog post:  */
/* https://blogs.sas.com/content/sasdummy/2014/08/13/social-media-counts-formats/ */
proc format lib=work;
picture social (round)
 1E03-<1000000='000K' (mult=.001  )
 1E06-<1000000000='000.9M' (mult=.00001)
 1E09-<1000000000000='000.9B' (mult=1E-08)
 1E12-<1000000000000000='000.9T' (mult=1E-11);
run;

/* create lables and final variables */
data DisplayValueInRange;
set minmax;
new_label = put(cost,social.);
Label new_label = "Cause Label"
max = "Total Cost";
where year ge 2007;
run;