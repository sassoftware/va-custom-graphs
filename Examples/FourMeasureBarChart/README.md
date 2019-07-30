Visualizing multiple metrics on the same graph is something of great value. There are many ways to see how one measure relates to another in SAS Visual Analytics’ stock graph objects. Examples of two measures on the same chart include the “Dual Axis Bar Chart,” “Dual Axis Line Chart,” and “Dual Axis Bar-Line Chart” objects. An example of having three measures on one plot is the very popular “Bubble Plot.” 

While these are all great examples, there are times when the report designer needs to “up the ante” and create a graph object that displays four measures simultaneously. This task can be difficult, because it is not easy to include this many measures while not confusing the report consumer.

Fortunately, there’s a great example of how to achieve this using PROC SGPLOT. As part of the SAS Visual Analytics Community custom graph sharing initiative I’ll tell you about how to create this graph in this [post](https://communities.sas.com/t5/SAS-Communities-Library/How-to-place-4-measures-on-the-same-SAS-Visual-Analytics-graph/ta-p/226336). 

![](./FourMeasuresBarChart_SC.png)

Data obtained from this [support.sas.com example](http://support.sas.com/kb/35/051.html) and processed with SAS Visual Analytics 8.3.1.

This branch contains the needed resources to recreate this custom graph including:
* The code to which creates the final cancer data set - FourMeasuresBarChart_ETL.sas
* A JSON file containing the completed custom graph - FourMeasureBarChart_CG.json
* A JSON file containing the completed report - FourMeasureBarChart.json
