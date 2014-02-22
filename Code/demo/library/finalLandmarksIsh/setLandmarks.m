function [ P, img ] = setLandmarks(P, mask, img, offsetX, offsetY)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [row, col] = find(mask == 1);
    
    X = col(1) + offsetX;
    Y = row(1) + offsetY;  
    
    img(Y-2:Y+2, X-2:X+2,:) = 0;
    img(Y-2:Y+2, X-2:X+2,1) = 255;
    
%     P(:, end + 1) = [X; Y];
    P(:, end + 1) = [col(1);row(1)];
    
    X = col(size(col,1))+offsetX;
    Y = row(size(row,1))+offsetY;
    
    img(Y-2:Y+2, X-2:X+2,:) = 0;
    img(Y-2:Y+2, X-2:X+2,1) = 255;
    
%     P(:, end + 1) = [X; Y];
    P(:, end + 1) = [col(size(col,1));row(size(row,1))];
end

