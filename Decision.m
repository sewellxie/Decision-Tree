function labels = Decision(tree, XToBePredicted)
% tree: a structure variable
% XToBePredicted: N*(m+1) array
% name: cell data containing feature's name
% tree = struct('leaf', false, 'left', 'null', 'right', 'null', 'label', 'null', ...
%    'precise', 'null', 'name', 'null', 'leftsplit', 'null', 'rightsplit', 'null');
[N,mplusone] = size(XToBePredicted);
m = mplusone-1;
labels = zeros(N,1);
for i=1:N
    tmpTree = tree;
    while ~(tmpTree.leaf)
%         featureNum = IndexFeature(tmpTree.name, name);
        featureNum = tmpTree.featureNum;
        if XToBePredicted(i, featureNum+1) == tmpTree.leftsplit
            tmpTree = tmpTree.left;
        elseif XToBePredicted(i, featureNum+1) == tmpTree.rightsplit
            tmpTree = tmpTree.right;
        end
    end
    labels(i) = tmpTree.label;
end
end

% function featureNum = IndexFeature(attrName, name)
% for i=1:length(name)
%     if strcmpi(attrName, name{i})
%         featureNum = i;
%         return
%     end
% end
% end