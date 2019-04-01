I'm always looking for more unique ways to display US State data in my SAS Visual Analytics reports. Recently, looking at some data which examines deficient bridge surface area within each US state.  Using a custom graph, I was able to build the following visualization of the United States which compares the surface area of deficient vs. non-deficient bridges.

![](./VACustomGraph_MAP.png)

Get the details on the graph's source data and how to re-create this chart in this SAS Communities Library [article](https://communities.sas.com/t5/SAS-Communities-Library/3-steps-to-build-a-US-map-tile-chart-in-SAS-Visual-Analytics/ta-p/539108).

This directory contains the needed resources to recreate this custom graph including:
* The data set template which includes the state tiles in the correct positions  - US_MAP_infographic_data_template.sas7bdat
* The ETL which add the deficient bridge data to the data set template and create the final deficient_bridges_infographic.sas7bdat dataset - deficient_bridge_ETL.sas
* A JSON file containing the custom graph and report - US_MAP_infographic.json
* The theme used to create the large text labels - Big_text_Theme.td
