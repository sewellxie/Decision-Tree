clear;clc;
load('Sogou_webpage.mat');
load('featureName.mat');
data = [doclabel, wordMat];
indices = crossvalind('Kfold', data(:, 1), 5);
trainIdc = (indices==1 | indices==2 | indices==3);
crossValidIdc = (indices==4);
testIdc = (indices==5);
trainSamples = data(trainIdc, :);
crossValidSamples = data(crossValidIdc, :);
testSamples = data(testIdc, :);
name = featureName.name;
threshold = 0.1;
tree = GenerateTree(threshold, trainSamples, name);
% clear;clc;
% load('test.mat');
treePruned = Prune(tree, crossValidSamples);
% calculate precise
trainLabels = Decision(treePruned, trainSamples);
crossValidLabels = Decision(treePruned, crossValidSamples);
testLabels = Decision(treePruned, testSamples);
trainPrecise = sum(trainSamples(:, 1)==trainLabels)/length(trainLabels)
crossValidPrecise = sum(crossValidSamples(:, 1)==crossValidLabels)/length(crossValidLabels)
testPrecise = sum(testSamples(:, 1)==testLabels)/length(testLabels)