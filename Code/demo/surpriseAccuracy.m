addpath('./library/mex');
addpath('./library/faceDetector');

d = dir('./testImgs/surprise/');
M = zeros(16, 1);
index = 1;
detector = buildDetector();
model = flandmark_load_model('./library/mex/flandmark_model.dat');

stdP = [];

for i = 4 : size(d, 1)
    subFolder = [pwd '/testImgs/surprise/' d(i, 1).name];
    subD = dir(subFolder);
    for j = 4 : size(subD, 1)
        fileName = subD(j, 1).name;
        if ~isempty(strfind(fileName, 'std')) % std image
            stdImg = imread([subFolder '/' fileName]);
            stdP = landmarkDetection(stdImg, detector, model);
        end
    end
    if isempty(stdP)
        continue;
    end
    for j = 4 : size(subD, 1)
        fileName = subD(j, 1).name;
        if ~isempty(strfind(fileName, 'su')) % emotion img
            emoImg = imread([subFolder '/' fileName]);
            emoP = landmarkDetection(emoImg, detector, model);
            if isempty(emoP)
                continue;
            else
                motionVec = emoP - stdP;
                M(:, index) = motionVec(:);
                index = index + 1;
            end
        end
    end
end

accuracy = 0;
for i = 1 : size(M, 2)
    result = nearestMean2(M(:, i));
    if result == 3
        accuracy = accuracy + 1;
    end
end

accuracy / size(M, 2)