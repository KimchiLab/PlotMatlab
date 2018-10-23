# PlotMatlab
Various plotting functions/scripts for Matlab

##Major functions:
###PlotTableGroupBar.m

Function to plot bar graphs of grouped values from a table, along with data labels for each point

Sample code: 

tbl = readtable('SampleData.csv');

vals = PlotTableGroupBar(tbl, 'Value', 'Major', 'Minor', [], 'ID', []);

![alt text](sample.png?raw=true "Title")


