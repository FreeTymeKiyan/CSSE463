function [ img ] = smoothFilter( img, filter, struct, times )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    H = fspecial(filter, struct);
    imtool(img);
    for i = 1:times
        img = imfilter(img, H);
    end
    imtool(img);

end

