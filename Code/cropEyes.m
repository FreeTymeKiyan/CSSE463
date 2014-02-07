imagesPath = pwd;
imagesPath = strcat(imagesPath, '/db');
D = dir(imagesPath);

for i = 4 : size(D, 1)
        filename = D(i).name;
        img = imread([imagesPath '/' filename]);
        imgCropped = crop(img, 20, 50);
        imwrite(imgCropped, strcat('./eyes/', filename));
end
% imtool(imgCropped);