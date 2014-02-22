function [] = swapFeatures(featureMat);
    %% swap feature 1 & 5
    a = featureMat(1:2, :);
    featureMat(1:2, :) = featureMat(9:10, :);
    featureMat(9:10, :) = a;

    %% swap feature 2 & 5
    a = featureMat(3:4, :);
    featureMat(3:4, :) = featureMat(9:10, :);
    featureMat(9:10, :) = a;

    %% swap feature 3 & 5
    a = featureMat(5:6, :);
    featureMat(5:6, :) = featureMat(9:10, :);
    featureMat(9:10, :) = a;

    %% swap feature 4 & 6
    a = featureMat(7:8, :);
    featureMat(7:8, :) = featureMat(11:12, :);
    featureMat(11:12, :) = a;
end