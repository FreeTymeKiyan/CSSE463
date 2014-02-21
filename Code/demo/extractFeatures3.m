HEIGHT = 360;
WIDTH = 260;

d = dir('./database/happy&normal');
picNum = size(d, 1) - 3;
M = zeros(3 * WIDTH * HEIGHT, picNum);

detector = buildDetector();

index = 1;
for i = 1 : size(d, 1)
    fileName = d(i, 1).name;
    if strcmp(fileName(end), 'g')
        img = imread([pwd '/database/happy&normal/' fileName]);
        M(:, index) = img(:);
        index = index + 1;
    end
end

X = zeros(12, 200);
index = 1;
for i = 1 : 2 : size(M, 2) - 1
    if index == 10
        keyboard
    end
    
    stdImg = uint8(reshape(M(:, i), 360, 260, 3));
    emotionImg = uint8(reshape(M(:, i + 1), 360, 260, 3));
   
    [P1, ~] = landmark(stdImg, detector);   
    [P2, ~] = landmark(emotionImg, detector);
    
    if ~any(any(P1)) || ~any(any(P2))
        continue;
    end
    
    diff = P2 - P1;
    X(:, index) = diff(:);
    index = index + 1;
end