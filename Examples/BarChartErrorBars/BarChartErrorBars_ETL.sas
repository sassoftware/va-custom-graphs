/******************************************************************************\
* Copyright 2019 SAS Institute Inc.
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

/*This code is based on the ssupport.sas.com example:*/
/*http://support.sas.com/kb/24/871.html*/

%let stat=std;  /* Choose either STD or STDERR. */                                                                             
%let num=1;     /* Choose either, 1, 2, or 3 for the number of standard */                                                              
                /* deviations or standard errors of the mean.           */                                                              
                                                                                                                                        
/* Create a sample data set */                                                                                                          
data a;                                                                                                                                 
   input Test $8. breaks;                                                                                                               
   datalines;                                                                                                                           
Cold      5                                                                                                                             
Cold     12                                                                                                                             
Cold     14                                                                                                                             
Cold     22                                                                                                                             
Cold     52                                                                                                                             
Heat     20                                                                                                                             
Heat     25                                                                                                                             
Heat     10                                                                                                                             
Heat     22                                                                                                                             
Heat     47                                                                                                                             
Gases    12                                                                                                                             
Gases    25                                                                                                                             
Gases    33                                                                                                                             
Gases    48                                                                                                                             
Gases    24                                                                                                                             
Pressure 10                                                                                                                             
Pressure 12                                                                                                                             
Pressure 14                                                                                                                             
Pressure 22                                                                                                                             
Pressure 55                                                                                                                             
X-rays   20                                                                                                                             
X-rays   25                                                                                                                             
X-rays   14                                                                                                                             
X-rays   22                                                                                                                             
X-rays   29                                                                                                                             
Humidity 20                                                                                                                             
Humidity 25                                                                                                                             
Humidity 33                                                                                                                             
Humidity 40                                                                                                                             
Humidity 24                                                                                                                             
;                                                                                                                                       
run;                                                                                                                                    
                                                                                                                                        
/* Sort data by variable Test */                                                                                                        
proc sort data=a;                                                                                                                       
   by test;                                                                                                                             
run;                                                                                                                                    
                                                                                                                                        
/* Create an output data set B using PROC MEANS   */                                                                                    
/* that contains new variables MEAN, STD, STDERR, */                                                                                    
/* MIN, and MAX.                                  */                                                                                    
proc means mean std stderr min max data=a noprint;                                                                                      
   by test;                                                                                                                             
   output out=stats mean=mean std=std stderr=stderr min=min max=max;                                                                        
run; 

data BarChartStandardErrorBars;
set stats;
base = 0;
/* where _type_ = 1; */
drop _type_ _FREQ_;
label type = "Vehicle Type";
LowerBar = mean-(&num*&stat);
UpperBar = mean+(&num*&stat);
barSeperation = &num;
format base mean LowerBar UpperBar Best.;
run;
