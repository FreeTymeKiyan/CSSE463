function net = trainSVM(featureMatrix, trainingVector)
    
    KERNEL_FUNC = 'rbf';
    KERNEL_PARAM = 1;
    
    nFeatures = size(featureMatrix, 1);
    
    net = svm(nFeatures, KERNEL_FUNC, KERNEL_PARAM);
    net = svmtrain(net, featureMatrix, trainingVector);
end