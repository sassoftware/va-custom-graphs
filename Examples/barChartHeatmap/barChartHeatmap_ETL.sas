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

data addColumns;
set sashelp.snacks;
start = Weekday(Date);
finish=start+1;
Weekday = left(put(Date,downame3.));
Month = left(put(Date,monname.));
WHERE Product in ('Carmelized popcorn','Cheddar cheese popcorn','Multigrain chips',
                  'Saltine crackers','WOW cheese puffs');
run;

proc sql;
create table totalSold as select 
"Heatmap" as Category length=40, Product, Month, Weekday, start, finish, 
sum(QtySold) as TotalSales format=dollar10.0
from addColumns
group by Category, Product, Month, Weekday, start, finish ;
quit;

proc sql;
create table totalSoldMonthly as select 
"Month" as Category length=40, Product, Month, Weekday, start, finish,
TotalSales, sum(TotalSales) as TotalSalesMonthly label="Total Sales by Month" format=dollar10.0
from totalSold
group by Category, Product, Month ;
quit;

proc sql;
create table totalSoldWeekday as select 
"Weekday" as Category length=40, Product, Month, Weekday, start, finish,
TotalSales, sum(TotalSales) as TotalSalesWeekday  label="Total Sales by Weekday" format=dollar10.0
from totalSold
group by Category, Product, Weekday ;
quit;

proc rank data=totalSold out=HeatmapRanks ties=low groups=5;
   by product;
   var TotalSales;
   ranks TotalSalesRankHeatmap;
run;

proc rank data=totalSoldMonthly out=MonthlyRanks ties=low groups=12;
   by product;
   var TotalSalesMonthly;
   ranks TotalSalesRankMonthly;
run;

proc rank data=totalSoldWeekday out=WeekdayRanks ties=low groups=7;
   by product;
   var TotalSalesWeekday;
   ranks TotalSalesRankWeekday;
run;

data barChartHeatmap;
set HeatmapRanks MonthlyRanks WeekdayRanks;
if Category = "Heatmap" then heatMapGroup = trim(Category) || "-" || compress(TotalSalesRankHeatmap);
label TotalSalesRankMonthly = "Month Sales Rank"
TotalSalesRankWeekday = "Weekday Sales Rank";
if TotalSales = 0 then start=.;
else start=start;
drop Category TotalSalesRankHeatmap;
run;
