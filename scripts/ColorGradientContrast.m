function colors = ColorGradientContrast(num_colors)
% num_colors = 8;

% % Matlab R2014b: http://www.mathworks.com/help/matlab/graphics_transition/why-are-plot-lines-different-colors.html
% colors = [
%          0    0.4470    0.7410
%     0.8500    0.3250    0.0980
%     0.9290    0.6940    0.1250
%     0.4940    0.1840    0.5560
%     0.4660    0.6740    0.1880
%     0.3010    0.7450    0.9330
%     0.6350    0.0780    0.1840
% ];

% % Reorganized Matlab R2014b order for rainbow like order w/pink as well
% colors = [
%     0.6350    0.0780    0.1840
%     0.8500    0.3250    0.0980
%     [251,154,153]/255;
%     0.9290    0.6940    0.1250
%     0.4660    0.6740    0.1880
%     0.3010    0.7450    0.9330
%          0    0.4470    0.7410
%     0.4940    0.1840    0.5560
% ];

% Reorganized and expanded Matlab R2014b order for rainbow like order w/pink as well
% colors = [
%     0.6350    0.0780    0.1840
%     0.8500    0.3250    0.0980
%     [251,154,153]/255;
%     0.9290    0.6940    0.1250
%     0.4660    0.6740    0.1880
%     0.3010    0.7450    0.9330
%          0    0.4470    0.7410
%     0.4940    0.1840    0.5560
% ];


% Qualitative Colors with Contrast from http://colorbrewer2.org/
colors = [
    166,206,227
    31,120,180
    178,223,138
    51,160,44
    251,154,153
    227,26,28
    253,191,111
    255,127,0
    202,178,214
    106,61,154
    255,255,153
    177,89,40
];
colors = colors/255;

% Rearranged Qualitative Colors with Contrast from http://colorbrewer2.org/
% colors = [
%     177,89,40
%     227,26,28
%     251,154,153
%     255,127,0
%     253,191,111
%     255,255,153
%     178,223,138
%     51,160,44
%     166,206,227
%     31,120,180
%     202,178,214
%     106,61,154
% ];
% colors = colors/255;


% http://colorbrewer2.org/

switch num_colors
    case 1
        colors = colors(10, :);
    case 2
        colors = colors([2 10], :);
    case 3
        colors = colors([2 8 10], :);
    case 4
        colors = colors([2 4 8 10], :);
    case 5
        colors = colors([2 4 8 10 12], :);
    case 6
        colors = colors([1 2 4 8 10 12], :);
    case 7
        colors = colors([1 2 4 6 8 10 12], :);
    case 8
        colors = colors([1 2 3 4 6 8 10 12], :);
    case 9
        colors = colors([1 2 3 4 6 8 9 10 12], :);
    case 10
        colors = colors([1 2 3 4 6 8 9 10 11 12], :);
    case 11
        colors = colors([1 2 3 4 5 6 8 9 10 11 12], :);
    case 12
        colors = colors;
    otherwise% vs. interpolate
        colors = [colors; colors(1:(num_colors - size(colors, 1)), :)];
end

% if num_colors < size(colors, 1)
%     colors = colors(1:num_colors, :);
% elseif num_colors > size(colors, 1)
%     % vs. interpolate
%     colors = [colors; colors(1:(num_colors - size(colors, 1)), :)];
% end

% %% Test look of colors
% temp_colors = nan(size(colors, 1), 1, size(colors, 2));
% for i_ch = 1:size(colors, 2);
%     temp_colors(:,:,i_ch) = colors(:, i_ch);
% end
% image(temp_colors);
% 
