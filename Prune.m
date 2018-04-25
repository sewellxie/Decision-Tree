function treePruned = Prune(tree, crossValidSamples)

treePruned = tree;

featureNum = tree.featureNum;
leftPoints = (crossValidSamples(:, featureNum+1) == tree.leftsplit);
rightPoints = (crossValidSamples(:, featureNum+1) == tree.rightsplit);
leftData = crossValidSamples(leftPoints, :);
rightData = crossValidSamples(rightPoints, :);
labels = crossValidSamples(:, 1);
labelsLeft = leftData(:, 1);
labelsRight = rightData(:, 1);

if ~tree.left.leaf && ~isempty(leftData)
    treePruned.left = Prune(tree.left, leftData);
end

if ~tree.right.leaf && ~isempty(rightData)
    treePruned.right = Prune(tree.right, rightData);
end

if tree.left.leaf && tree.right.leaf
    preciseMerge = sum(labels==tree.label)/length(labels);
    preciseOri = (sum(labelsLeft==tree.left.label)+...
                  sum(labelsRight==tree.right.label))/length(labels);
    if preciseMerge > preciseOri
        treePruned.leaf = 1;
        treePruned.left = 'null';
        treePruned.right = 'null';
        treePruned.leftsplit = 'null';
        treePruned.rightsplit = 'null';
    end
end

end