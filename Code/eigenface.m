imagesPath = pwd;
imagesPath = strcat(imagesPath, '\db');

IMROWS = 115;
IMCOLS = 82;

NUM_IMAGES = 400;

F = zeros(IMROWS * IMCOLS, NUM_IMAGES);

% Bored, Angry, Smile, sUrprised
suffix = 'basu';
for personNumber = 1 : 10
    for emotionNumber = 1 : 4
        filename = sprintf('%s\\image%d%c.jpg', ...
            imagesPath, personNumber, suffix(emotionNumber));
        img = imread(filename);
        F(:, (personNumber - 1) * 4 + emotionNumber) = img(:);
    end
end

avg = mean(F, 2);
avg = repmat(avg, 1, 400);

N = F - avg;
C = N * N';

[eigenvectorMatrix,~] = eigs(C,3);

showEigenimages(eigenvectorMatrix, IMROWS, IMCOLS);

% [c1 c2 c3; c1 c2 c3; ...]
projections = (eigenvectorMatrix' * imageMatrix)';
% 0:3 == basu
classVector = mod(1:NUM_IMAGES, 4);

% unhappy
classVector(classVector ~= 2) = -1;
% happy
classVector(classVector == 2) = 1;

net = trainSVM(projections, classVector);