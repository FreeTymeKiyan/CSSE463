function [] = happySurprise(name1, name2)

addpath('./library/mex/');
addpath('./library/finalLandmarksIsh/');
% two input images
stdImg = imread(name1);
emotionImg = imread(name2);
% get faces
detector = buildDetector();
[stdBbox, ~, ~, ~] = detectFaceParts(detector, stdImg, 2);
[emotionBbox, ~, ~, ~] = detectFaceParts(detector, emotionImg, 2);
% bbox(:, 1: 4) is bounding box for face
stdBbox = stdBbox(:, 1 : 4);
box1 = stdBbox;
boxWidth = stdBbox(3);
boxHeight = stdBbox(4);
stdBbox(3) = stdBbox(1) + stdBbox(3);
stdBbox(4) = stdBbox(2) + stdBbox(4);

emotionBbox = emotionBbox(:, 1 : 4);
box2 = emotionBbox;
emotionBbox(3) = emotionBbox(1) + emotionBbox(3);
emotionBbox(4) = emotionBbox(2) + emotionBbox(4);
%   label landmarks
stdGray = rgb2gray(stdImg);
emotionGray = rgb2gray(emotionImg);

model = flandmark_load_model('./library/mex/flandmark_model.dat');

% P1 = flandmark_detector(stdGray, int32(stdBbox(1, :)), model);    
% P2 = flandmark_detector(emotionGray, int32(emotionBbox(1, :)), model);

figure(1);
imshow(stdImg, [], 'Border', 'tight'); hold on;
for i = 1 : size(stdBbox, 1)
    P1 = flandmark_detector(stdGray, int32(stdBbox(i, :)),  model);
    % show landmarks 
    comps = ['S0'; 'S1'; 'S2'; 'S3'; 'S4'; 'S5'; 'S6'; 'S7'];
%     plot(P1(1, 1), P1(2, 1), 'bs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
%     text(P1(1, 1)+1, P1(2, 1)+1, comps(1,:), 'color', 'b', 'FontSize', 12);
    plot(P1(1, 2:end - 1), P1(2, 2:end - 1), 'rs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    text(P1(1, 2:end)+1, P1(2, 2:end)+1, comps(2:end,:), 'color', 'r', 'FontSize', 12);
    rectangle('Position', box1, 'LineWidth', 2, 'EdgeColor', 'r');
end

figure(2);
imshow(emotionImg, [], 'Border', 'tight'); hold on;
for j = 1 : size(emotionBbox, 1)
    P2 = flandmark_detector(emotionGray, int32(emotionBbox(j, :)),  model);
    % show landmarks 
    comps = ['S0'; 'S1'; 'S2'; 'S3'; 'S4'; 'S5'; 'S6'; 'S7'];
%     plot(P2(1, 1), P2(2, 1), 'bs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
%     text(P2(1, 1)+1, P2(2, 1)+1, comps(1,:), 'color', 'b', 'FontSize', 12);
    plot(P2(1, 2:end - 1), P2(2, 2:end - 1), 'rs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    text(P2(1, 2:end)+1, P2(2, 2:end)+1, comps(2:end,:), 'color', 'r', 'FontSize', 12);
    rectangle('Position', box1, 'LineWidth', 2, 'EdgeColor', 'r');
end

%   calculate motion vector
motion = (P2 - P1);
%   normalize
motion(1, :) = motion(1, :) ./ boxWidth;
motion(2, :) = motion(2, :) ./ boxHeight;
motion = motion(:);
%   feed it into classifier
result = nearestMean2(motion);
%   output emotion
if result == 1
    fprintf('happy\n');
elseif result == 3
    fprintf('surprise\n');
else 
    fprintf('else\n');
end