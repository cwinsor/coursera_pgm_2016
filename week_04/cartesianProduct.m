

% cartesian product
% http://stackoverflow.com/questions/4165859/generate-all-possible-combinations-of-the-elements-of-some-vectors-cartesian-pr
% sets = {[1 2], [1 2], [4 5]};
% [x y z] = ndgrid(sets{:});
% cartProd = [x(:) y(:) z(:)];
%
% cartProd =
%     1     1     4
%     2     1     4
%     1     2     4
%     2     2     4
%     1     1     5
%     2     1     5
%     1     2     5
%     2     2     5

function result = cartesianProduct(sets)
    c = cell(1, numel(sets));
    [c{:}] = ndgrid( sets{:} );
    result = cell2mat( cellfun(@(v)v(:), c, 'UniformOutput',false) );
end
