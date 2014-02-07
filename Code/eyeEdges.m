clear all;
imtool close all;
imagesPath = pwd;
imagesPath = strcat(imagesPath, '/db');

IMSIZE = 82*115;
NUM_IMAGES = 400;
images = zeros(115, 82, 400);

a='basu';
for i = 1 : 20
    for t = 1 : 4
        if i == 18 || i == 24||i == 25||i == 28
           
        else
           filename = sprintf('%s/image%d%c.jpg', imagesPath, i, a(t));
           img = imread(filename);
           images(:,:,(i - 1) * 4 + t) = img; 
        end       
    end
end
for i = 1:10
    image = uint8(images(:,:,i));
    % median filter
    %image = medfilt2(image);
    BW3 = edge(image,'prewitt');
    imtool((BW3));
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

