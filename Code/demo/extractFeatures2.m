clc;
clear all;
imtool close all;

addpath('./library/finalLandmarksIsh');
HEIGHT = 576;
WIDTH = 720;

d = dir('./database/surprise&normal/');
M = zeros(12, 1);
index = 1;
detector = buildDetector();

stdP = [];

for i = 4 : size(d, 1)
    subFolder = [pwd '/database/surprise&normal/' d(i, 1).name];
    subD = dir(subFolder);
    for j = 4 : size(subD, 1)
        fileName = subD(j, 1).name;
        if ~isempty(strfind(fileName, 'std')) % std image
            stdImg = imread([subFolder '/' fileName]);
            [stdP, ~] = landmark(stdImg, detector);
        end
    end
    if isempty(stdP)
        continue;
    end
    for j = 4 : size(subD, 1)
        fileName = subD(j, 1).name;
        if ~isempty(strfind(fileName, 'su')) % emotion img
            emoImg = imread([subFolder '/' fileName]);
            [emoP, ~] = landmark(emoImg, detector);
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