function [group_a, hash_a, num_a] = TableFieldToGroups(tbl, field_a)

if isempty(field_a)
    group_a = ones(size(tbl, 1), 1);
    hash_a = ones(size(group_a));
    num_a = 1;
else
    [group_a, ~, hash_a] = unique(tbl(:, field_a));

    if ~iscell(table2array(group_a))
        group_a = double(table2array(group_a));
    elseif isstable(group_a)
        group_a = table2array(group_a);
    end
    num_a = max(hash_a);
end
