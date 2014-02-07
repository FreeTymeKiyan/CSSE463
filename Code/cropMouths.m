imagesPath = pwd;
imagesPath = strcat(imagesPath, '/db');
D = dir(imagesPath);

for i = 4 : size(D, 1)
        filename = D(i).name;
        img = imread([imagesPath '/' filename]);
        imgCropped = crop(img, 70, 100, 12, 65);
        imwrite(imgCropped, strcat('./mouths/', filename));
end