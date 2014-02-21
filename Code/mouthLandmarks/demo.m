imtool close all;
reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};
if( ~checkToolboxes(reqToolboxes) )
 error('detectFaceParts requires: Computer Vision System Toolbox and Image Processing Toolbox. Please install these toolboxes.');
end

img = imread('C:\Users\sohlbehd\Desktop\test.jpeg');
%img = imread('C:\Users\sohlbehd\Desktop\test\2.jpg');
detector = buildDetector();
[bbox bbimg faces bbfaces] = detectFaceParts(detector,img,2);

%bbox(:, 1: 4) is bounding box for face
%       bbox(:, 5: 8) is bounding box for left eye
%       bbox(:, 9:12) is bounding box for right eye
%       bbox(:,13:16) is bounding box for mouth
%       bbox(:,17:20) is bounding box for nose
% 
% figure;imshow(bbimg);
mouth = getMouth(img, bbox);
%eyes = getEyes(img, bbox);
% imtool(mouth);
mouth = smoothFilter(mouth, 'average', [4 4], 1);
%imtool(mouth);

% kmean(mouth, 10);
mask = edges(mouth);
%colorFinder(mouth);

test = setLandmarks(mask, img, bbox(:,13), bbox(:,14));
imtool(test);