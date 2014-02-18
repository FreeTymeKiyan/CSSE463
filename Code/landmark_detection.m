clc; 
clearvars; 
close all;

%% Add path
addpath('./mex/');
addpath('./faceDetector/');
addpath('./svm/');

DIR = './db/';
IMGS = dir([DIR '*.jpg']);

% Load flandmark_model into MATLAB memory
model = flandmark_load_model('./mex/flandmark_model.dat');

%% Run detector;
% load image and detected face bbox
I = imread('standard_face.jpg');
% I = imread('happy_face.jpg');
% I = imread('./faceDetector/lena.png');
% I = imread('./faceDetector/test.jpg');
Ibw = rgb2gray(I);
% imtool(Ibw);
% format: top_left_col top_left_row bottom_right_col bottom_right_row)
detector = buildDetector();
[bbox bbimg faces bbfaces] = detectFaceParts(detector, I, 2);
% bbox(:, 1: 4) is bounding box for face
bbox = bbox(:, 1 : 4);
bbox(3) = bbox(1) + bbox(3);
bbox(4) = bbox(2) + bbox(4);
% image output
figure(1);
imshow(I, [], 'Border', 'tight'); hold on;

for i = 1 : size(bbox, 1)
    tic
    P = flandmark_detector(Ibw, int32(bbox(i, :)),  model);
    t1 = toc;
    fprintf('MEX:    Elapsed time %f ms\n', t1*1000);

    % show landmarks 
    comps = ['S0'; 'S1'; 'S2'; 'S3'; 'S4'; 'S5'; 'S6'; 'S7'];
    plot(P(1, 1), P(2, 1), 'bs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
    text(P(1, 1)+1, P(2, 1)+1, comps(1,:), 'color', 'b', 'FontSize', 12);
    plot(P(1, 2:end), P(2, 2:end), 'rs', 'LineWidth', 1, 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    text(P(1, 2:end)+1, P(2, 2:end)+1, comps(2:end,:), 'color', 'r', 'FontSize', 12);
end;

clear mex;