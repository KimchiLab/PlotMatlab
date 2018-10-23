function err_data = StdErr(data)

std_data = nanstd(data);
num_data = sum(~isnan(data));
err_data = std_data ./ (num_data .^ 0.5);
