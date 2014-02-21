imtool close all;
clear all;
reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};
if( ~checkToolboxes(reqToolboxes) )
 error('detectFaceParts requires: Computer Vision System Toolbox and Image Processing Toolbox. Please install these toolboxes.');
end

img = imread('40-1m.jpg');
%  img = imread('C:\Users\sohlbehd\Desktop\test2.jpeg');
%  img = imread('C:\Users\sohlbehd\Desktop\test\6.jpg');
detector = buildDetector();
[bbox bbimg faces bbfaces] = detectFaceParts(detector,img,2);

mouth = getMouth(img, bbox);
widthMargin = 0.2;
heightMargin = 0.3;
[leftEye, rightEye] = getEyes(img, bbox, widthMargin, heightMargin);

imtool(leftEye);
imtool(rightEye);
leftMask = edges(leftEye, 0, 'canny');
rightMask = edges(rightEye, 0, 'canny');
imtool(leftMask);
imtool(rightMask);

test = setLandmarks(leftMask, img, bbox(:,5)+bbox(:,7)*widthMargin, bbox(:,6)+bbox(:,8)*heightMargin);
test = setLandmarks(rightMask, test, bbox(:,9)+bbox(:,11)*widthMargin, bbox(:,10)+bbox(:,12)*heightMargin);

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