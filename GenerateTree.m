function tree = GenerateTree(threshold, samples, name)
% samples: matrix of N*(m+1), [labels(N*1),features(N*m)]
% N: the number of samples
% m: the number of features
% threshold: determine when to stop growing the tree
% name: name of m features
% tree: a structure variable
tree = struct('leaf', false, 'left', 'null', 'right', 'null', 'label', 'null', ...
    'precise', 'null', 'name', 'null', 'featureNum', 'null', 'leftsplit', 'null', 'rightsplit', 'null');
[featureSelected, childNodeSamples, leaf, valueOfFeature] = SplitNode(samples,  threshold);
labelThisNode = mode(samples(:, 1));
preciseThisNode = length(find(samples(:, 1)==labelThisNode))/length(samples(:, 1));
if leaf == 1
    tree.leaf = 1;
    tree.label = labelThisNode;
    tree.precise = preciseThisNode;
    return
end

tree.leaf = 0;
tree.label = labelThisNode;
tree.precise = preciseThisNode;
tree.name = name(featureSelected);
tree.featureNum = featureSelected;
tree.leftsplit = valueOfFeature(1);
tree.rightsplit = valueOfFeature(2);
% for k=1:length(childNodeSamples)
%     childNodeSamples{k}(:, featureSelected+1) = [];
% end
% name(featureSelected) = [];
tree.left = GenerateTree(threshold, childNodeSamples{1}, name);
tree.right = GenerateTree(threshold, childNodeSamples{2}, name);
end