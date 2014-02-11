function net = trainSVM(featureMatrix, trainingVector)
    
    KERNEL_FUNC = 'rbf';
    KERNEL_PARAM = 150000;
    
    nFeatures = size(featureMatrix, 2);
    
%     net = svm(nFeatures, KERNEL_FUNC, KERNEL_PARAM);
    net = svm(nFeatures, KERNEL_FUNC, [KERNEL_PARAM], 1000);
    net = svmtrain(net, featureMatrix, trainingVector);
end