function [ horizontalEdges, verticalEdges, sum, magnitude, direction] = sobel( gray )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    sobelX = 1/8*[-1 0 1; -2 0 2; -1 0 1];
    sobelY = 1/8*[1 2 1; 0 0 0; -1 -2 -1];
    
    horizontalEdges = filter2(sobelX, gray);    
    verticalEdges = filter2(sobelY, gray);    
    sum = horizontalEdges + verticalEdges;    
    magnitude = sqrt(horizontalEdges.^2 + verticalEdges.^2);    
    direction = atan2(verticalEdges, horizontalEdges);    
    direction = direction + pi;
    direction = direction .* (255/pi);
    
end

