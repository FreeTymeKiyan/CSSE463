function face = getFace(img);
reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};
if( ~checkToolboxes(reqToolboxes) )
 error('detectFaceParts requires: Computer Vision System Toolbox and Image Processing Toolbox. Please install these toolboxes.');
end

% img = imread('/lena.png');
detector = buildDetector();
[bbox bbimg faces bbfaces] = detectFaceParts(detector,img,2);

%bbox(:, 1: 4) is bounding box for face
%       bbox(:, 5: 8) is bounding box for left eye
%       bbox(:, 9:12) is bounding box for right eye
%       bbox(:,13:16) is bounding box for mouth
%       bbox(:,17:20) is bounding box for nose

% figure;imshow(bbimg);
x1 = bbox(:,1);
x2 = bbox(:,1)+bbox(:,3);
y1 = bbox(:,2);
y2 = bbox(:,2)+bbox(:,4);
face = img(y1:y2,x1:x2,:);
imtool(face);
% mouth = getMouth(img, bbox);
% eyes = getEyes(img, bbox);
% imtool(mouth);
% imtool(eyes);

%end
% figure;imshow(bbimg);
% for i=1:size(bbfaces,1)
%  figure;imshow(bbfaces{i});
% end