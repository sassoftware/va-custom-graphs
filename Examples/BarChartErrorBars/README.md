One of the questions my colleagues frequently ask is if SAS Visual Analytics can create visualizations similar to the graphs that they have created using traditional SAS graphing procedures (such as PROC GCHART).  In some cases the graph that they wish to recreate is a relatively a simple plot, but with some statistical window dressing.  Take a look at this [sample](http://support.sas.com/kb/24/871.html) from [support.sas.com](http://support.sas.com).  What a cool looking graph!  It’s a bar chart with error bars and min/max dots annotated on top of it.

Well I have great news!  This is where the [SAS® Graph Builder](https://go.documentation.sas.com/?cdcId=vacdc&cdcVersion=8.3&docsetId=grbldrug&docsetTarget=titlepage.htm&locale=en) really shines!  It allows report developers to combine several different report objects and produce unique graphs suited to their specific reporting needs! These new custom graphs can then be used interactively in SAS Visual Analytics Reports.  

Using the SAS® Graph Builder, I was able to produce the following report:

![](./BarChartWithErrorBars.png)

This graph not only allows us to present the metric’s average value, but we can also display additional statistics of the metric's standard deviation and the min/max values!

Data is obtained from this [support.sas.com sample](http://support.sas.com/kb/24/871.html) and processed with SAS Visual Analytics 8.3.1. 

This branch contains the needed resources to recreate this custom graph including:
* The code to which creates the final report_ready data set - BarChartErrorBars_ETL.sas
* A JSON file containing the custom graph itself - BarChartWithErrorBars_CG.json
* A JSON file containing the completed report - BarChartWithErrorBars.json

