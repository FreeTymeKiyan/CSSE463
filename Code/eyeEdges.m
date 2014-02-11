clear all;
imtool close all;
imagesPath = pwd;
imagesPath = strcat(imagesPath, '\db');
dirList = dir(imagesPath);

IMHEIGHT = 114;
IMWIDTH = 82;
IMSIZE = IMHEIGHT*IMWIDTH;
NUM_IMAGES = 400;

eyeImages = zeros(IMHEIGHT/2, IMWIDTH, NUM_IMAGES);
mouthImages = zeros(IMHEIGHT/2, IMWIDTH, NUM_IMAGES);

for i = 3:size(dirList)
    img = imread([imagesPath '\' dirList(i).name]);
    eyeImages(:,:,i-2) = img(1:57,:);
    mouthImages(:,:,i-2) = img(58:114,:);
end

for i = 1:30
    image = uint8(mouthImages(:,:,i));
    % median filter
    %image = medfilt2(image);
    imtool((image));
    BW1 = edge(image, 'canny');
    %imtool((BW1));
end
% imtool(uint8(image));
% BW1 = edge(image,'sobel');
% BW2 = edge(image,'canny');
% BW3 = edge(image,'prewitt');
% BW4 = edge(image,'log');
% imtool((BW1));
% imtool((BW2));
% imtool((BW3));
% imtool((BW4));

