imagesPath = pwd;
imagesPath = strcat(imagesPath, '/mouths');

D = dir(imagesPath);

IMROWS = 31;
IMCOLS = 54;

NUM_IMAGES = (size(D, 1) - 3) / 2;

F = zeros(IMROWS * IMCOLS, NUM_IMAGES);
classVector = zeros(NUM_IMAGES, 1);

% Bored, Angry, Smile, sUrprised
i = 1;
files = D(4:end);
for index = 1:length(files);
        file = files(index);
        filename = file.name;
        if filename(end - 4) == 'a' 
            img = imread(strcat('./mouths/', filename));
            classVector(i) = -1;
            F(:, i) = img(:);
            i = i + 1;
        elseif filename(end - 4) == 's'
            img = imread(strcat('./mouths/', filename));
            classVector(i) = 1;
            F(:, i) = img(:);
            i = i + 1;
        end
end

FTest = F(:, 101 : end);
FTrain = F(:, 1 : 100);

avg = mean(FTrain, 2);
avg = repmat(avg, 1, 100);

N = FTrain - avg;
C = N * N';

[eigenvectorMatrix,~] = eigs(C,10);

showEigenimages(eigenvectorMatrix, IMROWS, IMCOLS);

% [c1 c2 c3; c1 c2 c3; ...]
projections = (eigenvectorMatrix' * FTrain)';
% 0:3 == basu
% classVector = mod(1 : NUM_IMAGES, 4)';
% 
% % unhappy
% classVector(classVector ~= 2) = -1;
% % happy
% classVector(classVector == 2) = 1;

net = trainSVM(projections, classVector(1:100));

testProjections = (eigenvectorMatrix' * FTest)';
testOutput = svmfwd(net, testProjections);
idealOutput = classVector(101:end);

