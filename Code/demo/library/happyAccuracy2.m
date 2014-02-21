addpath('./library/finalLandmarksIsh');

d = dir('./testImgs/happy/');
M = zeros(12, 1);
index = 1;
detector = buildDetector();

stdP = [];

for i = 4 : 2 : size(d, 1) - 1
    fileName1 = [pwd '/testImgs/happy/' d(i, 1).name];
    stdImg = imread(fileName1);
    stdP = landmark(stdImg, detector);
    if isempty(stdP)
        continue;
    end
    fileName2 = [pwd '/testImgs/happy/' d(i + 1, 1).name];
    emoImg = imread(fileName2);
    emoP = landmark(emoImg, detector);
    if isempty(emoP)
        continue;
    end
    motionVec = emoP - stdP;
    M(:, index) = motionVec(:);
    index = index + 1;
end

accuracy = 0;
for i = 1 : size(M, 2)
    result = nearestMean3(M(:, i));
    if result == 1
        accuracy = accuracy + 1;
    end
end

accuracy / size(M, 2)