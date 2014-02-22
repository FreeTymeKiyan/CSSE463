addpath('./library/finalLandmarksIsh');

d = dir('./testImgs/surprise/');
M = zeros(12, 1);
index = 1;

stdP = [];

for i = 3 : size(d, 1)
    subFolder = [pwd '/testImgs/surprise/' d(i, 1).name];
    subD = dir(subFolder);
    for j = 3 : size(subD, 1)
        fileName = subD(j, 1).name;
        if ~isempty(strfind(fileName, 'std')) % std image
            stdImg = imread([subFolder '/' fileName]);
            [stdP, stdImg] = landmark(stdImg, detector);
        end
    end
    if isempty(stdP)
        continue;
    end
%     imtool(stdImg);
    for j = 3 : size(subD, 1)
        fileName = subD(j, 1).name;
        if ~isempty(strfind(fileName, 'su')) % emotion img
            emoImg = imread([subFolder '/' fileName]);
            [emoP, emoImg] = landmark(emoImg, detector);
            if isempty(emoP)
                continue;
            else
%                 imtool(emoImg);
                motionVec = emoP - stdP;
                M(:, index) = motionVec(:);
                index = index + 1;
            end
        end
    end
end


happy = 0;
surprise = 0;
neutral = 0;
for i = 1 : size(M, 2)
    result = nearestMean4(M(:, i));
    if result == 1
        happy = happy + 1;
    elseif result == 2
        surprise = surprise + 1;
    else 
        neutral = neutral + 1;
    end
end

surprise / size(M, 2)