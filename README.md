# PlotMatlab
Various plotting functions/scripts for Matlab

Major functions:
PlotTableGroupBar.m
![alt text](sample.png?raw=true "Title")

% function vals = PlotTableGroupBar(tbl, field_val, field_major, field_minor, colors, field_text, flag_open)
% 
% Function to plot bar graphs of grouped values from a table, along with data labels for each point
% Eyal Kimchi, 2018
%
% Input arguments:
% tbl = Required: Matlab table that can be imported from an Excel table or CSV file
%     The table should be organized in "long" format with column headings, e.g.
%     TextID, Value, GroupMajor, GroupMinor
%     Each data points should have a separate row entry
% field_val = Required: name of field/column with the numerical values to plot (and take average/mean and standard error)
% field_major = Required: name of categorical field for major/between X separation: can be numeric, will be converted to categories
% field_minor = name of categorical field for minor/within X separation: can be numeric, will be converted to categories
% colors = colors used across different categories
% field_text = name of field to print over each value, e.g. subject names
% flag_open = Whether to use open bars for a specific bars -- depends on knowing how many bars there should be
% 
% Output arguments:
% vals: Cell array of values by each grouping
%
% % Sample code to run from command line with sample dataset
% tbl = readtable('SampleData.csv');
% vals = PlotTableGroupBar(tbl, 'Value', 'Major', 'Minor', [], 'ID', []);

