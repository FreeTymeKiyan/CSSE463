features = load('happyFeatures.mat');
features = features.featureMatrix;
a = reshape(features, 8, 89);
a = a';
% y = ones(89, 1);
y = ones(50, 1);
y(51 : 89) = -ones(39, 1);

net = trainSVM(a, y);

[testOutput distances] = svmfwd(net, a(1:40, :));