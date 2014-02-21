imtool close all;
reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};
if( ~checkToolboxes(reqToolboxes) )
 error('detectFaceParts requires: Computer Vision System Toolbox and Image Processing Toolbox. Please install these toolboxes.');
end

% img = imread('C:\Users\sohlbehd\Desktop\CSSE463\Project\CSSE463\Code\Demo\demoImgs\surprise4.jpg');
img = imread('C:\Users\sohlbehd\Desktop\test.jpeg');
% img = imread('C:\Users\sohlbehd\Desktop\test\2.jpg');
detector = buildDetector();
[bbox bbimg faces bbfaces] = detectFaceParts(detector,img,2);
% imshow(img)
%bbox(:, 1: 4) is bounding box for face
%       bbox(:, 5: 8) is bounding box for left eye
%       bbox(:, 9:12) is bounding box for right eye
%       bbox(:,13:16) is bounding box for mouth
%       bbox(:,17:20) is bounding box for nose
% 
% figure;imshow(bbimg);
% imtool(bbimg);
mouth = getMouth(img, bbox);
widthMargin = 0.2;
heightMargin = 0.3;
[leftEye, rightEye] = getEyes(img, bbox, widthMargin, heightMargin);

% imtool(leftEye);
% imtool(rightEye);
finalLeftMask = getEyeMask(leftEye);
imtool(finalLeftMask);
test = setLandmarks(finalLeftMask, img, ...
    bbox(:,5) + widthMargin * bbox(:,7), bbox(:,6) + heightMargin * bbox(:,8));

finalRightMask = getEyeMask(rightEye);
imtool(finalRightMask);
test = setLandmarks(finalRightMask, test, ...
    bbox(:,9) + widthMargin * bbox(:,11), bbox(:,10) + heightMargin * bbox(:,12));

% imtool(mouth);
mouthSmoothing = 4;
mouth = smoothFilter(mouth, 'average', [4 4], mouthSmoothing);
%imtool(mouth);

%imtool(mouth);
%[means, mouth] = kmean(mouth, 10);
imtool(mouth);
mask = edges(mouth, mouthSmoothing, 'canny');
%colorFinder(mouth);
imtool(mask);

test = setLandmarks(mask, test, bbox(:,13), bbox(:,14));
imtool(test);