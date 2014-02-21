clear all;
imtool close all;
img = imread('images.jpg');
%img = imresize(img, [120 160]);
imtool(img);
k = 7;
means = uint8(floor(255*rand(k,3))); 

cluster_number = zeros(size(img,1), size(img,2));
for h = 1:10
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            r = double(img(i,j,1));
            g = double(img(i,j,2));
            b = double(img(i,j,3));
            cluster_number(i,j) = closestMean(r,g,b, double(means));
        end
    end

    for i = 1:k
        rBand = img(:,:,1);
        gBand = img(:,:,2);
        bBand = img(:,:,3);
        means(i,1) = mean(rBand(find(cluster_number == i)));
        means(i,2) = mean(gBand(find(cluster_number == i)));
        means(i,3) = mean(bBand(find(cluster_number == i)));
    end
end

for i = 1:size(img,1)
    for j = 1:size(img,2)
        img(i,j,1) = means(cluster_number(i,j),1);
        img(i,j,2) = means(cluster_number(i,j),2);
        img(i,j,3) = means(cluster_number(i,j),3);
    end
end

imtool(img);