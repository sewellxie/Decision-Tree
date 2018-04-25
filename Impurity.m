function entropy = Impurity(samples)
% Impurity: calculate entropy for a certain samples
% samples: matrix of N*(m+1), [labels(N*1),features(N*m)]
% N: the number of samples
% m: the number of features
labels = samples(:,1);
class = unique(labels);
numsamples = length(labels);
p = ones(1, length(labels));
entropy = 0;
for i=1:length(class)
    p(i) = length(find(labels == class(i)))/numsamples;
    if p(i) ~= 0
        entropy = entropy-p(i)*log2(p(i));
    end        
end
end