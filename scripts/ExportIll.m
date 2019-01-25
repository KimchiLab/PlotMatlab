% ExportIll.m
% Eyal Kimchi, uploaded 2019
% Function to try to streamline export of Matlab figures to Illustrator (not perfect)
% Saves an .ps postscript file/vector art for opening in illustrator
% Also exports .png files for preview.
% And .pdf file in newer versions of Matlab: seem to work better than older versions
% 
% More info:
% http://neuropsyence.blogspot.com/2007/12/making-figures-matlab-to-illustrator.html
%
% Some prior references: (some no longer active)
% https://www.mathworks.com/matlabcentral/fileexchange/23629-export_fig
% https://www.mathworks.com/matlabcentral/fileexchange/7401-scalable-vector-graphics-svg-export-of-figures
% http://www.mathworks.com/support/solutions/data/1-1B33H.html?solution=1-1B33H
% http://www.mathworks.com/support/solutions/data/1-19LQF.html?solution=1-19LQF
% http://www.sccn.ucsd.edu/eeglab/printfig.html

function ExportIll(save_name, paper_size)

if nargin < 2
    paper_size = [11 8.5];
    if nargin < 1
        % If no save_name is passed in, then use a temporary directory/file
        % This may cause an error if it does not exist
        if exist('C:\temp', 'dir')
            save_name = 'C:\temp\temp';
        else
            fprintf('Please input a save file name or change default save dir in code\n');
            return;
        end
    end
end

% If a single number is given for paper_size, then scale a standard paper by this
if numel(paper_size) == 1
    if 0.1 < scale && scale < 10
        paper_size = [11 8.5] * paper_size;
    else
        fprintf('Scaling factor of %d too extreme\n', paper_size);
        return;
    end
end

warning('off', 'MATLAB:print:DeprecatedOptionAdobecset');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', paper_size);
set(gcf, 'PaperPosition', [.25 .25 paper_size-0.5]);

% Some features below only work in earlier versions of Matlab
[str_ver, str_date] = version;
vec_date = datevec(str_date);
if vec_date(1) <= 2013
    print('-dpsc2', '-noui', '-adobecset', '-painters', [save_name '.ps']);
elseif vec_date(1) <= 2016
    set(gcf, 'PaperOrientation', 'landscape');
    print('-dpsc2', '-noui', '-painters', [save_name '.ps']);
else
    set(gcf,'PaperPositionMode','manual'); % Better for R2017a+?
    orient(gcf,'landscape'); % works better in R12017a than properties above
    print('-dpsc2', '-noui', '-painters', '-fillpage', [save_name '.ps']);
    print('-dpdf', '-noui', '-painters', [save_name '.pdf']);
end

print('-dpng', '-noui', '-painters', [save_name '.png']);

% If no filename was given, then "run" the temp file: will open whatever program is associated with ps files
if nargin < 1
    eval(['!' save_name '.ps']);
end

