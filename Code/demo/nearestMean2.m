function result = nearestMean2(motionVector)
    happy = load('happyFeatures.mat');
    happy = happy.X;
    surprise = load('surpriseFeatures.mat');
    surprise = surprise.M;
    mean1 = mean(happy, 2);
    mean2 = zeros(16, 1); 
    mean3 = mean(surprise, 2);
    means = [mean1 mean2 mean3];
    
    dmin = Inf;
    imin = 1;
    for i = 1 : size(means, 2)
        d = sqrt(sum((motionVector - means(:, i)).^2))
        if d < dmin
            dmin = d;
            imin = i;
        end
    end
    result = imin;
end