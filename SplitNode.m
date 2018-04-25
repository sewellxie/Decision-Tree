function [featureSelected, childNodeSamples, leaf, valueOfFeature] = SplitNode(samplesUnderThisNode,  threshold)
% SplitNode: split samples in current node
% samplesUnderThisNode: matrix of N*(m+1), [labels(N*1),features(N*m)]
% N: the number of samples
% m: the number of features
% threshold: determine when to stop growing the tree
% featureSelected: return the feature that has maximum information gain
% childNodeSamples: return child node samples, cell data of length k (the number of classes)
% leaf: to judge if the current node is a leaf node
labels = unique(samplesUnderThisNode(:, 1));
leaf = 0;
if length(labels) == 1 || length(samplesUnderThisNode(1, :)) == 1
    leaf = 1;
    featureSelected = 0;
    childNodeSamples{1} = samplesUnderThisNode;
    valueOfFeature{1}=0;
    return
end
[featureSelected, childNodeSamples, maxDelta, valueOfFeature] = SelectFeature(samplesUnderThisNode);
if maxDelta < threshold || length(childNodeSamples)==1
    leaf = 1;
    return
end

end