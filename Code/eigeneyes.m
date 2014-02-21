addpath('./svm');
imagesPath = pwd;
subfolder = '/eyes/';

imagesPath = strcat(imagesPath, subfolder);

D = dir(imagesPath);

IMROWS = 31;
IMCOLS = 82;
NUM_WINDOWS = 5;

% ceil since OSX has one more default file than Wndows
NUM_IMAGES = ceil((size(D, 1) - 3) / 2) * NUM_WINDOWS;

F = zeros((IMROWS - NUM_WINDOWS + 1) * IMCOLS, NUM_IMAGES);
classVector = zeros(NUM_IMAGES, 1);

% Bored, Angry, Smile, sUrprised
i = 1;
files = D(4 : end);
for index = 1:length(files);
        file = files(index);
        filename = file.name;
        
        % ...X.jpg
        if filename(end - 4) == 'a' 
            class = -1;
        elseif filename(end - 4) == 's'
            class = 1;
        else
            continue;
        end
        
        img = imread(strcat(imagesPath, filename));
        classVector(i: i + NUM_WINDOWS) = class;
        
        for windowNumber = 1:NUM_WINDOWS
            % (i - 1) * NUM_WINDOWS = 0, 5, 10, 15, ...
            fIndex = (i - 1) * NUM_WINDOWS + windowNumber;
            nthWindow = img(windowNumber:end - NUM_WINDOWS + windowNumber, :);
            
            F(:, fIndex) = nthWindow(:);
        end
        
        i = i + 1;
end

FTest = F(:, 51 : end);
FTrain = F(:, 1 : 50);

avg = mean(FTrain, 2);
avg = repmat(avg, 1, 50);

N = FTrain - avg;
C = N * N';

[eigenvectorMatrix,~] = eigs(C,10);
% eigenvectorMatrix = eigs(C,10);
% showEigenimages(eigenvectorMatrix, IMROWS, IMCOLS);

% [c1 c2 c3; c1 c2 c3; ...]
projections = (eigenvectorMatrix' * FTrain)';

net = trainSVM(projections, classVector(1:50));

testProjections = (eigenvectorMatrix' * FTest)';
[testOutput, distances] = svmfwd(net, testProjections);
idealOutput = classVector(51 : end);