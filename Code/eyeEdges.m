clear all;
imtool close all;
imagesPath = pwd;
imagesPath = strcat(imagesPath, '/db/angry');
dirList = dir(imagesPath);

IMHEIGHT = 115;
IMWIDTH = 82;
NUM_IMAGES = size(dirList);

images = zeros(IMHEIGHT*2, IMWIDTH*2, 3, NUM_IMAGES);
images = uint8(images);
landmarkMatrix = zeros(4, 2, NUM_IMAGES);

for i = 3:NUM_IMAGES + 2
      img = imread([imagesPath '/' dirList(i).name]);
      img = repmat(img, [1,1,3]);
      img = imresize(img, 2);
      figure (1), imshow(img);
      hFig = figure(1); 
      set(gcf,'PaperPositionMode','auto')
      set(hFig, 'Position', [0 0 8*IMWIDTH 8*IMHEIGHT])
      zoom on;
      % zoom(2);     
      % first point left, clock-wise
      [x,y] = ginput(4);
      close;
      landmarkMatrix(:,:,i-2) = [x,y];
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

