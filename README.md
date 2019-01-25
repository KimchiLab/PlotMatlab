# PlotMatlab
Various plotting functions/scripts for Matlab

## Major functions:  
### ExportIll.m
Function to export the active figure (gcf) as a postscript file, which is easier to edit in Illustrator than some other options. In newer versions of Matlab this will also make a .pdf file. Can also make a .png file

### PlotTableGroupBar.m  
Function to plot bar graphs of grouped values from a table, along with data labels for each point. Download all functions in this directory to run it. Sample code:  
tbl = readtable('SampleData.csv');  
vals = PlotTableGroupBar(tbl, 'Value', 'Major', 'Minor', [], 'ID', []);  
![alt text](sample.png?raw=true "Title")
