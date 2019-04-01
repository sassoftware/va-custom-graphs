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

proc sql;
create table cars_by_make as select
make,
avg(MPG_City) as MPG_City format=comma8.0,
avg(MPG_Highway) as MPG_Highway format=comma8.0,
1 as Bubble1_Size,
1 as Bubble2_Size
from sashelp.cars
where Origin = "Europe"
group by Make;
quit;
