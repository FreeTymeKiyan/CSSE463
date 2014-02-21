%% improve eigen mouth with window approach
imagesPath = pwd;
imagesPath = strcat(imagesPath, '/mouths');

D = dir(imagesPath);

IMROWS = 31;
IMCOLS = 54;

WINDOW_ROWS = 27;

NUM_IMAGES = (size(D, 1) - 3) / 2;
FACTOR = IMROWS - WINDOW_ROWS + 1;

F = zeros(WINDOW_ROWS * IMCOLS, NUM_IMAGES * FACTOR);
classVector = zeros(NUM_IMAGES * FACTOR, 1);

% Angry, Smile
i = 1;
files = D(4:end);
for index = 1 : length(files);
        file = files(index);
        filename = file.name;
        if filename(end - 4) == 'a' 
            img = imread(strcat('./mouths/', filename));
            for j = 1 : FACTOR
                classVector(i) = -1;
                temp = img(j:WINDOW_ROWS + j - 1, :);
                F(:, i) = temp(:);
                i = i + 1;
            end
        elseif filename(end - 4) == 's'
            img = imread(strcat('./mouths/', filename));
            for j = 1 : FACTOR
                classVector(i) = 1;
                temp = img(j:WINDOW_ROWS + j - 1, :);
                F(:, i) = temp(:);
                i = i + 1;
            end
        end
end

FTest = F(:, end / 2 + 1 : end);
FTrain = F(:, 1 : end / 2);

avg = mean(FTrain, 2);
avg = repmat(avg, 1, size(FTrain, 2));

N = FTrain - avg;
C = N * N';

[eigenvectorMatrix,~] = eigs(C,10);

% showEigenimages(eigenvectorMatrix, IMROWS, IMCOLS);

% [c1 c2 c3; c1 c2 c3; ...]
projections = (eigenvectorMatrix' * FTrain)';
% 0:3 == basu
% classVector = mod(1 : NUM_IMAGES, 4)';
% 
% % unhappy
% classVector(classVector ~= 2) = -1;
% % happy
% classVector(classVector == 2) = 1;

net = trainSVM(projections, classVector(1: end / 2));

testProjections = (eigenvectorMatrix' * FTest)';
[testOutput, distances] = svmfwd(net, testProjections);
idealOutput = classVector(end / 2 + 1:end);

accuracy = 0;
for i = 1 : size(testOutput, 1) 
    if idealOutput(i) == testOutput(i)
        accuracy = accuracy + 1;
    end 
end
accuracy = accuracy / size(testOutput, 1)
