function net = trainSVM(featureMatrix, trainingVector)
    
    KERNEL_FUNC = 'rbf';
    KERNEL_PARAM = 75000;
    
    nFeatures = size(featureMatrix, 2);
    
%     net = svm(nFeatures, KERNEL_FUNC, KERNEL_PARAM);
    net = svm(nFeatures, KERNEL_FUNC, [KERNEL_PARAM], 900);
    net = svmtrain(net, featureMatrix, trainingVector);
end