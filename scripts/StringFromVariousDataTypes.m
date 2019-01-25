function str_text = StringFromVariousDataTypes(data)

if isnumeric(data)
    str_text = num2str(data);
elseif isstr(data)
    str_text = data;
elseif iscell(data)
    str_text = StringFromVariousDataTypes(data{1});
else
    fprinttf('Unrecognized data type!\n');
end

