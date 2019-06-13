Visualizing where specific data points are located within a data range can be challenging task.  Fortunately, we can build a custom graph to do this!  The graph below has vertical lines which display the data ranges (minimum and maximum) of nonresidential building fire damage by year.  It also has specific data points and labels for damage caused by heating, cooking and natural fires:

![](./Display_Values_in_a_Range.png)

Using this graph, it’s very easy to see not only where these data points are located within their respective data ranges, but also what their individual values are.

Data btained from this [Curriculum Pathways Data Depot resource](https://www.curriculumpathways.com/portal/#!/info/2600?id=3001&keyword=fire&sourceid=1164) and processed with SAS Visual Analytics 8.3.1.

This branch contains the needed resources to recreate this custom graph including:
* The code to which creates the final DisplayValueInRange data set - Display_Values_in_a_Range_ETL.sas
* A simulated data that can be used as the report's data source  - displayvalueinrange.sas7bdat
* A JSON file containing the custom graph - Display_Values_in_a_Range_CG.json
* A JSON file containing the completed report - Display_Values_in_a_Range.json
