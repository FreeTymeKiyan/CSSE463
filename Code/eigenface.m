imagesPath = pwd;
imagesPath = strcat(imagesPath, '/db');

IMROWS = 115;
IMCOLS = 82;

NUM_PEOPLE = ;
NUM_EMOTIONS = 2;

F = zeros(IMROWS * IMCOLS, NUM_PEOPLE * NUM_EMOTIONS);

% Bored, Angry, Smile, sUrprised
suffix = 'as';
for personNumber = 1 : NUM_PEOPLE
    for emotionNumber = 1 : NUM_EMOTIONS
        filename = sprintf('%s/image%d%c.jpg', ...
            imagesPath, personNumber, suffix(emotionNumber));
        img = imread(filename);
        F(:, (personNumber - 1) * NUM_EMOTIONS + emotionNumber) = img(:);
    end
end

avg = mean(F, 2);
avg = repmat(avg, 1, NUM_PEOPLE * NUM_EMOTIONS);

N = F - avg;
C = N * N';

[eigenvectorMatrix,~] = eigs(C,3);

% showEigenimages(eigenvectorMatrix, IMROWS, IMCOLS);

% [c1 c2 c3; c1 c2 c3; ...]
projections = (eigenvectorMatrix' * F)';
% 0:3 == basu
classVector = mod(1:(NUM_PEOPLE*NUM_EMOTIONS), 4)';

% unhappy
classVector(classVector ~= 2) = -1;
% happy
classVector(classVector == 2) = 1;

net = trainSVM(projections, classVector);