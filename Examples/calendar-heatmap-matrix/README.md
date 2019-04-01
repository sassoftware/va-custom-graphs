One of my favorite ways time series data can be visualized is by using a combination of a calendar and a heat map matrix.  The question is, can something like this be built in SAS Visual Analytics?  As it turns out, the answer is yes!  Using a custom graph, I was able to build the report below:

![](./calendar_heatmap_matrix.png)

Get the details on the graph's source data and how to re-create this chart in this SAS Communities Library [article](https://communities.sas.com/t5/SAS-Communities-Library/Three-Steps-to-Building-a-Calendar-Heatmap-Matrix/ta-p/520854).

This directory contains the needed resources to recreate this custom graph including:
* A simulated data set of flights in December from 2015 though 2017 - flight_data.sas7bdat
* The code to which creates the final December_Travel data set - December_Travel_ETL.sas
* The completed output data set - December_Travel.sas7bdat
* A JSON file containing the completed report - December_Travel.json