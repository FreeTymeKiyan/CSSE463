function result = nearestMean3(motionVector)
    happy = load('happyFeatures3.mat');
    happy = happy.happy;
    surprise = load('surpriseFeatures3.mat');
    surprise = surprise.surprise;
    mean1 = mean(happy, 2);
    mean2 = zeros(12, 1); 
    mean3 = mean(surprise, 2);
    means = [mean1 mean2 mean3];
%     means = [mean1 mean2];
    
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