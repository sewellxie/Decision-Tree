function [featureSelected, childNodeSamples, maxDeltaEntropy, valueOfFeature] = SelectFeature(samplesUnderThisNode)
% SelectFeature: select feature for split in current node
% samplesUnderThisNode: matrix of N*(m+1), [labels(N*1),features(N*m)]
% N: the number of samples
% m: the number of features
% featureSelected: return the feature that has maximum information gain
% childNodeSamples: return child node samples, cell data of length k (the number of classes)
labels = samplesUnderThisNode(:, 1);
features = samplesUnderThisNode(:, 2:end);
lensamples = length(labels);
featureSelected = 1;maxDeltaEntropy = 0;valueOfFeature = [];childNodeSamples{1} = samplesUnderThisNode;
infoGainRate = 0;
numfeature = length(features(1, :));
entropybf = Impurity(samplesUnderThisNode);
% entropysplited = ones(numfeature, 1);
for j=1:numfeature
    splitedSamples = {};
    fte = features(:, j);
    valfte = unique(fte);
    entropysplited = 0;
    splitInfoA = 0;
    for k=1:length(valfte)
        index = find(fte==valfte(k));
        if ~isempty(index)
            lensptsamples = length(index);
            splitSamples{k} = samplesUnderThisNode(index, :);
            entropysplited = entropysplited+lensptsamples/lensamples*Impurity(splitSamples{k});
            splitInfoA = splitInfoA-lensptsamples/lensamples*log2(lensptsamples/lensamples);
        end
    end
    if splitInfoA ~= 0
        infoGainRate = (entropybf-entropysplited)/splitInfoA;
    end
    if infoGainRate > maxDeltaEntropy
        featureSelected = j;
        childNodeSamples = splitSamples;
        maxDeltaEntropy = infoGainRate;
        valueOfFeature = valfte;
    end
end
end