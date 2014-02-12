function [ result ] = transformMatrix( mat )
%TRANSFORMMATRIX Summary of this function goes here
%   Detailed explanation goes here
    length = size(mat, 3);
    result = zeros(4, 2, length / 2);
    for i = 1 : 2 : length
%         result(:, :, (i + 1) / 2) = mat(:, :, i + 1) - mat(:, :, i);
        result(:, :, (i + 1) / 2) = mat(:, :, i) - mat(:, :, i + 1);
    end 
end

