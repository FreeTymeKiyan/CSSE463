function [ img ] = colorFinder( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    H = fspecial('average', [3 3]);
    img = imfilter(img, H);
    img = imfilter(img, H);
    img = imfilter(img, H);
    H = padarray(2,[2 2]) - fspecial('gaussian', [5 5],2);
    img = imfilter(img, H);
    
    imtool(img);
    img = rgb2hsv(img);
    imtool(img);
    mask = ones(size(img, 1), size(img, 2));
    img = find( ...
        img(:,:,1) < 0.05 &... 
        img(:,:,2) > 0.80 & ...
        img(:,:,3) < 0.5 );

    mask(img) = 0;
    mask = ~mask;
    
    imtool(mask);
    
    se = strel('diamond',2);
    erodedImg = imerode(mask,se);
    erodedImg = imdilate(erodedImg,se);
    erodedImg = imdilate(erodedImg,se);
    erodedImg = imdilate(erodedImg,se);
    
    img = erodedImg;
end

