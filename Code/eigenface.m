imagesPath = pwd;
imagesPath = strcat(imagesPath, '\db');

IMSIZE = 82*115;
NUM_IMAGES = 400;

F = zeros(IMSIZE, NUM_IMAGES);

a='basu';
for i = 1 : 10
    for t = 1 : 4
        filename = sprintf('%s\\image%d%c.jpg', imagesPath, i, a(t));
        img = imread(filename);
        F(:, (i - 1) * 4 + t) = img(:);
    end
end

avg = mean(F, 2);
avg = repmat(avg, 1, 400);

N = F - avg;

C = N * transpose(N);

[V,D] = eigs(C,3);

eigen1 = reshape(normalize2uint8(V(:,1)),115,82);
eigen2 = reshape(normalize2uint8(V(:,2)),115,82);
eigen3 = reshape(normalize2uint8(V(:,3)),115,82);

imtool(uint8(eigen1));
imtool(uint8(eigen2));
imtool(uint8(eigen3));
