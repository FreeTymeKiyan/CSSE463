clear all;
imtool close all;
imagesPath = pwd;
imagesPath = strcat(imagesPath, '\db\smilesAndNeutral');
dirList = dir(imagesPath);

IMHEIGHT = 115;
IMWIDTH = 82;
IMSIZE = IMHEIGHT*IMWIDTH;
NUM_IMAGES = 10;

images = zeros(IMHEIGHT, IMWIDTH, 3, NUM_IMAGES);
images = uint8(images);
landmarkMatrix = zeros(4, 4, NUM_IMAGES);

for i = 3:size(dirList)
      img = imread([imagesPath '\' dirList(i).name]);
      img = repmat(img, [1,1,3]);
      images(:,:,:,i-2) = uint8(img);
      figure; imshow(img);
      %zoom(2);
      [x,y] = ginput(4);
      close;
      images(:,:,:,i-2) = paintLandmarks(img, x, y);
end


% for i = 1:10
%     image = uint8(images(:,:,i));
%     % median filter
%     %image = medfilt2(image);
%     BW3 = edge(image,'prewitt');
%     imtool((BW3));
% end
% imtool(uint8(image));
% BW1 = edge(image,'sobel');
% BW2 = edge(image,'canny');
% BW3 = edge(image,'prewitt');
% BW4 = edge(image,'log');
% imtool((BW1));
% imtool((BW2));
% imtool((BW3));
% imtool((BW4));

