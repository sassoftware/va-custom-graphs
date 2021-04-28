  
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
*
\******************************************************************************/

/*summarize the data by country, year and month*/
proc sql;
create table sums as select 
Country, Year, Month,sum(actual) as MonthlySales format=dollar18.0
from sashelp.prdsale
group by Country, Year, Month;
quit;

/*create a YTD variable*/
data sums2;
set sums;
   by Country year month;
   if first.Country or first.Year then SalesYTD=0;
   SalesYTD + MonthlySales;
   format SalesYTD dollar18.0;
run;

/*separate out the monthly and YTD Data*/
data Monthly;
set sums2;
length Months $9;
Months = put(Month,MONNAME3.);
drop SalesYTD;
run;

data YTD;
set sums2;
length Months $9;
Months = put(Month,MONNAME3.) || " - YTD";
drop MonthlySales;
run;

/*append the monthly and YTD data together*/
data dynamicTotalWaterfall;
set YTD Monthly;
run;
