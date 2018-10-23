function [h_bar, h_err] = PlotBarMeanStdErr(data, x_coord, color, bar_width)

if isempty(data)
    h_bar = NaN;
    h_err = NaN;
    return;
elseif nargin < 4
    bar_width = 0.25;
    if nargin < 3
        color = ColorPicker('darkgray');
    end
end

hold on;
err_width = 0.2 * bar_width;

temp_color = color;
light_color = ColorLighten(color);
mean_val = nanmean(data);
err_data = StdErr(data);

for i_bar = 1:numel(mean_val)
    h_bar = patch([x_coord(i_bar)-bar_width, x_coord(i_bar)-bar_width, x_coord(i_bar)+bar_width, x_coord(i_bar)+bar_width], [0 mean_val(i_bar), mean_val(i_bar), 0], temp_color);
    set(h_bar, 'EdgeColor', 'none');
    h_err = patch([x_coord(i_bar)-err_width, x_coord(i_bar)-err_width, x_coord(i_bar)+err_width, x_coord(i_bar)+err_width], [mean_val(i_bar)-err_data(i_bar), mean_val(i_bar)+err_data(i_bar), mean_val(i_bar)+err_data(i_bar), mean_val(i_bar)-err_data(i_bar)], light_color);
    set(h_err, 'EdgeColor', 'none');
end

set(gca, 'Box', 'off');

y_max = max(data(:))*1.1;
if isnan(y_max) || y_max <= 0
    y_max = 1;
end
axis([x_coord(1)-0.5 x_coord(end)+0.5 0 y_max]);

% hold on;
% err_width = 0.2 * bar_width;
% 
% temp_color = color;
% light_color = ColorLighten(color);
% mean_val = nanmean(data);
% std_data = nanstd(data);
% err_data = std_data ./ (sum(~isnan(data)).^ 0.5);
% per25 = mean_val - err_data;
% per75 = mean_val + err_data;
% 
% % sum_val = nanmedian(data);
% h_bar = patch([x_coord-bar_width, x_coord-bar_width, x_coord+bar_width, x_coord+bar_width], [0 mean_val, mean_val, 0], temp_color);
% set(h_bar, 'EdgeColor', 'none');
% h_err = patch([x_coord-err_width, x_coord-err_width, x_coord+err_width, x_coord+err_width], [per25, per75, per75, per25], light_color);
% set(h_err, 'EdgeColor', 'none');
% 
% set(gca, 'Box', 'off');
% 
% max_data = max([data(:); eps]);
% axis([x_coord-0.5 x_coord+0.5 0 max_data*1.1]);
% 
% 
% % function PlotBarMeanStdErr(data, x_coords, color, bar_width)
% % 
% % if nargin < 4
% %     bar_width = 0.25;
% %     if nargin < 3
% %         color = ColorPicker('blue');
% %         if nargin < 2
% %             x_coords = 1:size(data,2);
% %         end
% %     end
% % end
% % 
% % hold on;
% % err_width = 0.2 * bar_width;
% % 
% % temp_color = color;
% % light_color = ColorLighten(color);
% % mean_val = nanmean(data);
% % std_data = std(data);
% % err_data = std_data ./ (sum(~isnan(data)).^ 0.5);
% % 
% % % sum_val = nanmedian(data);
% % for i_x = 1:size(data,2)
% %     h = patch([x_coords(i_x)-bar_width, x_coords(i_x)-bar_width, x_coords(i_x)+bar_width, x_coords(i_x)+bar_width], [0 mean_val(i_x), mean_val(i_x), 0], temp_color);
% %     set(h, 'EdgeColor', 'none');
% %     h = patch([x_coords(i_x)-err_width, x_coords(i_x)-err_width, x_coords(i_x)+err_width, x_coords(i_x)+err_width], [mean_val(i_x)-err_data(i_x), mean_val(i_x)+err_data(i_x), mean_val(i_x)+err_data(i_x), mean_val(i_x)-err_data(i_x)], light_color);
% %     set(h, 'EdgeColor', 'none');
% % end
% % 
% % set(gca, 'Box', 'off');
% % 
% % axis([min(x_coords)-0.5 max(x_coords)+0.5 0 max(mean_val(:) + err_data(:))*1.1]);
