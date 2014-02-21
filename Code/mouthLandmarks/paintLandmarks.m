function [ colorImg ] = paintLandmarks( img, x, y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    for i = 1:size(x,1)
        yP = uint8(y(i));
        xP = uint8(x(i));
        img(yP-2:yP+2, xP-2:xP+2,:) = 0;
        img(yP-2:yP+2, xP-2:xP+2,1) = 255;
    end
    colorImg = img;
end

