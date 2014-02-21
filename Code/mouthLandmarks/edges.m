function [ mask ] = edges( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    mouth = rgb2gray(img);
%     imtool(mouth);
    BW1 = edge(mouth, 'sobel');
    BW2 = edge(mouth, 'canny');
    imtool(BW1);
%     imtool(BW2);
    
    BW2(:, 1:4) = 0;
    BW2(:, size(BW2,2)-4:size(BW2, 2)) = 0;
    BW2(1:3, :) = 0;
    BW2(size(BW2,1)-4:size(BW2, 1), :) = 0;
    
    mask = BW2;
    imtool(BW2);
end

