/******************************************************************************\
* Copyright 2021 SAS Institute Inc.
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
* All code must be saved as part of a SAS Viya Job definition.  The job must 
* be executed with the parameter _action=form,execute
*
\******************************************************************************/

/*create the library that contains the 'tallyTemplate.sas7bdat' file*/
libname src '<-location of source data>';

/*get onlt the right fielders*/
/*create one observation per home run*/
/*create runsPlayer variable*/
data baseballData;
set sashelp.baseball;
where Position = "RF";
runsPlayer = compress(put(nHome,z2.)) || " - " || name;
label runsPlayer="Total Runs - Player Name";
do count=1 to nHome;
output;
end;
keep Name nHome count runsPlayer;
run;

/*join baseballData to the tallyTemplate dataset*/
proc sql;
create table baseballTallyChart as select
t1.*, t2.x, t2.xOrig, t2.y, t2.yOrig 
from baseballData as t1
left join src.tallyTemplate as t2 on (t1.count = t2.count)
order by name, count;
quit;

