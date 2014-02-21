function mask = mouthMask( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    img = rgb2hsv(img);
    hsv2rgb(img);
end

