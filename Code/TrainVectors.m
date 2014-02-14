happyFeatures = load('happyFeatures.mat');
happyFeatures = happyFeatures.featureMatrix;
happyFeatures = reshape(happyFeatures, 8, 89);
happyFeatures = happyFeatures';

notHappyFeatures = load('notHappyFeatures.mat');
notHappyFeatures = notHappyFeatures.features;
notHappyFeatures = reshape(notHappyFeatures, 8, 89);
notHappyFeatures = notHappyFeatures';

trainSet = cat(1, happyFeatures(1:60, :), notHappyFeatures(1:60, :));
testSet = cat(1, happyFeatures(61:89, :), notHappyFeatures(61:89, :));

y = ones(60, 1);
y(61 : 120) = -ones(60, 1);

net = trainSVM(trainSet, y);

idealOutput = ones(29, 1);
idealOutput(30 : 58) = -ones(29, 1);

[testOutput, distances] = svmfwd(net, testSet);

accuracy = 0;
for i = 1 : 58 
    if idealOutput(i) == testOutput(i)
        accuracy = accuracy + 1;
    end 
end
accuracy = accuracy / size(testSet, 1)