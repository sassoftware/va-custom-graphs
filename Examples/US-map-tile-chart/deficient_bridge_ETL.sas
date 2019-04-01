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

libname src '<- location of source data ->';

proc sql;
create table add_data_values as select
t1.*,
t2.Surface_Area_Def_Bridges2015,
t2.Surface_Area_Tot_Bridges2015
from src.US_MAP_infographic_data_template as t1 full join
src.deficient_bridges as t2
on (upcase(t1.statename)=compress(upcase(t2.state),"ABCDEFGHIJKLMNOPQRSTUVWXYZ " ,"kis"))
where t1.row ne "";
quit;

data deficient_bridges_infographic;
set add_data_values;
Surface_Area_Def_pct = Surface_Area_Def_Bridges2015/Surface_Area_Tot_Bridges2015;
Surface_Area_good_pct = (Surface_Area_Tot_Bridges2015-Surface_Area_Def_Bridges2015)/Surface_Area_Tot_Bridges2015;
format Surface_Area_Def_pct Surface_Area_good_pct percent8.2;
schedule_chart1_start = start;
schedule_chart1_finish = (((finish-start)*Surface_Area_good_pct)+start);
schedule_chart2_start = (((finish-start)*Surface_Area_good_pct)+start);
schedule_chart2_finish = finish;
run;
