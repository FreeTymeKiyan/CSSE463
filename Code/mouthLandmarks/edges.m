function [ mask ] = edges( img , k, algorithm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    mouth = rgb2gray(img);
    BW2 = edge(mouth, algorithm);
%     BW2 = edge(mouth, 'canny');
    
    BW2(:, 1:k) = 0;
    BW2(:, size(BW2,2)-k:size(BW2, 2)) = 0;
    BW2(1:k-1, :) = 0;
    BW2(size(BW2,1)-k:size(BW2, 1), :) = 0;
    
    mask = BW2;
%     imtool(BW1);
%     imtool(BW2);
end

