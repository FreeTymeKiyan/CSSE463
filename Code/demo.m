%%  Demo 
clc;
clear all;
close all;

addpath('./mex/');
addpath('./faceDetector/');
addpath('./svm/');
%   two input images
stdImg = imread('standard_face.jpg');
emotionImg = imread('happy_face.jpg');

%   get faces
detector = buildDetector();
[stdBbox, ~, ~, ~] = detectFaceParts(detector, stdImg, 2);
[emotionBbox, ~, ~, ~] = detectFaceParts(detector, emotionImg, 2);
% bbox(:, 1: 4) is bounding box for face
stdBbox = stdBbox(:, 1 : 4);
stdBbox(3) = stdBbox(1) + stdBbox(3);
stdBbox(4) = stdBbox(2) + stdBbox(4);

emotionBbox = emotionBbox(:, 1 : 4);
emotionBbox(3) = emotionBbox(1) + emotionBbox(3);
emotionBbox(4) = emotionBbox(2) + emotionBbox(4);
%   label landmarks
stdGray = rgb2gray(stdImg);
emotionGray = rgb2gray(emotionImg);

model = flandmark_load_model('./mex/flandmark_model.dat');
figure(1);
imshow(stdImg, [], 'Border', 'tight'); hold on;
for i = 1 : size(stdBbox, 1)
    P1 = flandmark_detector(stdGray, int32(stdBbox(i, :)),  model);
    % show landmarks 
    comps = ['S0'; 'S1'; 'S2'; 'S3'; 'S4'; 'S5'; 'S6'; 'S7'];
    plot(P1(1, 1), P1(2, 1), 'bs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
    text(P1(1, 1)+1, P1(2, 1)+1, comps(1,:), 'color', 'b', 'FontSize', 12);
    plot(P1(1, 2:end), P1(2, 2:end), 'rs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    text(P1(1, 2:end)+1, P1(2, 2:end)+1, comps(2:end,:), 'color', 'r', 'FontSize', 12);
end

figure(2);
imshow(emotionImg, [], 'Border', 'tight'); hold on;
for i = 1 : size(emotionBbox, 1)
    P2 = flandmark_detector(emotionGray, int32(emotionBbox(i, :)),  model);
    % show landmarks 
    comps = ['S0'; 'S1'; 'S2'; 'S3'; 'S4'; 'S5'; 'S6'; 'S7'];
    plot(P2(1, 1), P2(2, 1), 'bs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
    text(P2(1, 1)+1, P2(2, 1)+1, comps(1,:), 'color', 'b', 'FontSize', 12);
    plot(P2(1, 2:end), P2(2, 2:end), 'rs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    text(P2(1, 2:end)+1, P2(2, 2:end)+1, comps(2:end,:), 'color', 'r', 'FontSize', 12);
end
%   calculate motion vector
motion = P2 - P1;
%   normalize

%   feed it into classifier

%   output emotion
