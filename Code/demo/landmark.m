function [P, img] = landmark(img, detector)
    reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};
    if( ~checkToolboxes(reqToolboxes) )
        error('detectFaceParts requires: Computer Vision System Toolbox and Image Processing Toolbox. Please install these toolboxes.');
    end
    
    [bbox, ~, ~, ~] = detectFaceParts(detector,img,2);

    mouth = getMouth(img, bbox);
    widthMargin = 0.2;
    heightMargin = 0.3;
    [leftEye, rightEye] = getEyes(img, bbox, widthMargin, heightMargin);

    leftMask = edges(leftEye, 0, 'canny');
    rightMask = edges(rightEye, 0, 'canny');
    
    P = [];
    [P, test] = setLandmarks(P, leftMask, img, bbox(1,5)+bbox(1,7)*widthMargin, bbox(1,6)+bbox(1,8)*heightMargin);
    [P, test] = setLandmarks(P, rightMask, test, bbox(1,9)+bbox(1,11)*widthMargin, bbox(1,10)+bbox(1,12)*heightMargin);

    mouthSmoothing = 4;
    mouth = smoothFilter(mouth, 'average', [4 4], mouthSmoothing);
    
    mask = edges(mouth, mouthSmoothing, 'canny');
    
    [P, test] = setLandmarks(P, mask, test, bbox(1,13), bbox(1,14));
    
    P(1, :) = P(1, :) ./ bbox(1, 3);
    P(2, :) = P(2, :) ./ bbox(1, 4);
    img = test;
end