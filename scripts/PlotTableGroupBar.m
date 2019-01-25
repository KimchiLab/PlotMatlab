function vals = PlotTableGroupBar(tbl, field_val, field_major, field_minor, colors, field_text, flag_open)

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

%% Input Argument checks
if nargin < 7
    flag_open = '';
    if nargin < 6
        field_text = '';
        if nargin < 5
            colors = [];
            if nargin < 4
                field_minor = '';
            end
        end
    end
end


%% Collect/determine values
% Get major group data/categories
[group_major, hash_major, num_major] = TableFieldToGroups(tbl, field_major);
[group_minor, hash_minor, num_minor] = TableFieldToGroups(tbl, field_minor);

% Get data values for each joint cell of cat major and minor
vals = cell(num_minor, num_major);
rows = cell(size(vals));
for i_col = 1:num_major
    for i_sub = 1:num_minor
        mask = hash_major == i_col & hash_minor == i_sub;
        vals{i_sub, i_col} = table2array(tbl(mask, field_val));
        rows{i_sub, i_col} = find(mask);
    end
end

% Check for flag_open: if empty, just plot all bars closed
if isempty(flag_open)
    flag_open = false(size(vals));
end


%% Adjust colors: Major colors in columns, Minor colors in rows
[num_color_row, num_color_col] = size(colors);
if num_color_col ~= num_major
    if num_color_col == 1
        colors = repmat(colors, 1, num_major);
    else
        colors = ColorGradientContrast(num_major);
        colors = mat2cell(colors, ones(size(colors, 1), 1), 3)';
    end
end
[num_color_row, num_color_col] = size(colors);
if num_color_row ~= num_minor
    if num_color_row == 1
        colors = repmat(colors, num_minor, 1);
    else
        colors = repmat(colors{1, :}, num_minor, 1);
    end
end


%% Plot values
font_size = 7;
bar_width = 1/num_minor/3; 
margin_adj = bar_width * 2.3;

x_tick = nan(num_minor, num_major);
x_tick_label = cell(size(x_tick));

hold on;
for i_col = 1:size(vals, 2)
    for i_sub = 1:size(vals, 1)
        temp_vals = vals{i_sub, i_col};

        if ~isempty(field_minor)
            x_tick(i_sub, i_col) = i_col + (i_sub - mean([1, num_minor])) * margin_adj;
            x_tick_label{i_sub, i_col} = sprintf('%s:%s (n=%d)', StringFromVariousDataTypes(group_major(i_col)), StringFromVariousDataTypes(group_minor(i_sub)), numel(temp_vals));
            % x_tick_label{i_sub, i_col} = sprintf('%s=%s %s=%s (n=%d)', field_major, StringFromVariousDataTypes(group_major(i_col)), field_minor, StringFromVariousDataTypes(group_minor(i_sub)), numel(temp_vals)); % Old style including field name
        else
            x_tick(i_sub, i_col) = i_col;
            x_tick_label{i_sub, i_col} = sprintf('%s (n=%d)', StringFromVariousDataTypes(group_major(i_col)), numel(temp_vals));
            % x_tick_label{i_sub, i_col} = sprintf('%s=%s (n=%d)', field_major, StringFromVariousDataTypes(group_major(i_col)), numel(temp_vals)); % Old style including field name
        end
        [h_bar, h_err] = PlotBarMeanStdErr(temp_vals, x_tick(i_sub, i_col), colors{i_sub, i_col}, bar_width);
        
        if flag_open(i_sub, i_col)
            set(h_bar, 'EdgeColor', colors{i_sub, i_col});
            set(h_bar, 'FaceColor', ColorPicker('white'));
            set(h_bar, 'LineWidth', 3);
        end
        
        % Print text for each value, connect across groups? (* possible future modification)
        if ~isempty(field_text)
            for i_val = 1:numel(temp_vals)
                idx_row = rows{i_sub, i_col}(i_val);
                str_text = StringFromVariousDataTypes(tbl{idx_row, field_text});
                h_text = text(x_tick(i_sub, i_col), temp_vals(i_val), str_text);
                set(h_text, 'FontSize', font_size);
                set(h_text, 'HorizontalAlignment', 'center');
                % set(h_text, 'Color', colors{i_a, i_b}); % Print in black text, otherwise will disappear on bar
            end
        end        
    end
end

% Set axes: to limits of text if present. Matlab will not take them into account for auto sizing
if ~isempty(field_text)
    y_lim = max(vertcat(vals{:}));
else
    y_lim = inf;
end
axis([0.5 num_major+0.5 0 y_lim]); % 0.5 since centered around each major group
x_tick = x_tick'; % Flip minor and major for printing
x_tick_label = x_tick_label'; % Flip minor and major for printing

[sort_val, idx_sort] = sort(x_tick(:));
set(gca, 'XTick', sort_val);
set(gca, 'XTickLabel', x_tick_label(idx_sort));
ylabel(sprintf('%s (Mean + StdErr)', field_val));
set(gca, 'TickLabelInterpreter', 'none'); % This makes underscores not print as subscript. 
% Using tex or latex interpreter could have other fun features, including color as below, ?multi line with latex
% \color[rgb]{specifier}: https://www.mathworks.com/help/matlab/ref/matlab.graphics.axis.axes-properties.html#budumk7-TickLabelInterpreter
% However, for multi-line with latex inteprerter this will change the font from san serif to a default serif font, which extends the can of worms a bit
% xtickangle(30);  If too many labels that are too long, then it may be helpful to tilt the labels vs. edit them later in another program to separate into lines (can not do in Matlab)
