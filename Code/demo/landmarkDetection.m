function P = landmarkDetection(img, detector, model)
    
    [bbox, ~, ~, ~] = detectFaceParts(detector, img, 2);
    bbox = bbox(:, 1 : 4);
    boxWidth = bbox(3);
    boxHeight = bbox(4);
    bbox(3) = bbox(1) + bbox(3);
    bbox(4) = bbox(2) + bbox(4);
    
    grayImg = rgb2gray(img);
   
    P1 = flandmark_detector(grayImg, int32(bbox(1, :)),  model);
    
    if ~any(any(P1))
        P = [];
    else
        P = zeros(2, 8);
        P(1, :) = P1(1, :) / boxHeight;
        P(2, :) = P1(2, :) / boxWidth;
    end
end

