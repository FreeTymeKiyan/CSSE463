function result = nearestMean4(motionVector)
    threshold = 0.2;
    happy = load('happyFeatures4.mat');
    happy = happy.happy;
    surprise = load('surpriseFeatures4.mat');
    surprise = surprise.surprise;
    mean1 = mean(happy, 2);
    mean2 = mean(surprise, 2);
    means = [mean1 mean2];
    
    dmin = Inf;
    imin = 1;
    for i = 1 : size(means, 2)
        d = sqrt(sum((motionVector - means(:, i)).^2))
        if d < dmin
            dmin = d;
            imin = i;
        end
    end
    if dmin > threshold
        imin = 3;
    end
    result = imin;
end