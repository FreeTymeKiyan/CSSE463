addpath('./library/mex');
addpath('./library/finalLandmarksIsh');

d = dir('./testImgs/happy/');
M = zeros(16, 1);
index = 1;
detector = buildDetector();
model = flandmark_load_model('./library/mex/flandmark_model.dat');

stdP = [];

for i = 3 : 2 : size(d, 1) - 1
    fileName1 = [pwd '/testImgs/happy/' d(i, 1).name];
    stdImg = imread(fileName1);
    stdP = landmarkDetection(stdImg, detector, model);
    if isempty(stdP)
        continue;
    end
    fileName2 = [pwd '/testImgs/happy/' d(i + 1, 1).name];
    emoImg = imread(fileName2);
    emoP = landmarkDetection(emoImg, detector, model);
    if isempty(emoP)
        continue;
    end
    motionVec = emoP - stdP;
    M(:, index) = motionVec(:);
    index = index + 1;
end

happy = 0;
surprise = 0;
neutral = 0;
for i = 1 : size(M, 2)
    result = nearestMean2(M(:, i));
    if result == 1
        happy = happy + 1;
    elseif result == 2
        surprise = surprise + 1;
    else 
        neutral = neutral + 1;
    end
end

happy / size(M, 2)