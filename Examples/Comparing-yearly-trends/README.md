This Visual Analytics Custom Graph compares the United States cumulative precipitation for last year against the total (so far) for this year.  Notice how I was able to get the dynamic reference line to be a dashed line.  This helps the report consumer know that this is only a reference line and not a line representing actual data.

![](./trend_comparison.png)

Get the details on the graph's source data and how to re-create this chart in this SAS Communities Library [article](https://communities.sas.com/t5/SAS-Communities-Library/3-steps-to-build-a-trend-comparison-line-plot-in-SAS-Visual/ta-p/533266).

This branch contains the needed resources to recreate this custom graph including:
* A simulated data set precipitation  - simulated_precip_data.sas7bdat
* The code to which creates the final report_ready data set - Trend_Comparison_Plot.sas
* The completed output data set (sourced from the simulated dataset) - report_ready.sas7bdat
* A JSON file containing the completed report - Trend_Comparison_Plot.json
