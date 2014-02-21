function eyes = getEyes( img,bbox )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    topLeft = [bbox(:,13) bbox(:,14)];
    topRight = [bbox(:,13)+bbox(:,15) bbox(:,14)];
    bottomLeft = [bbox(:,13) bbox(:,14)+bbox(:,16)];
    bottomRight = [bbox(:,13)+bbox(:,15) bbox(:,14)+bbox(:,16)];
    
   % bbox(:, 5: 8) is bounding box for left eye
   % bbox(:, 9:12) is bounding box for right eye
    
    x1 = bbox(:,5);
    x2 = bbox(:,9)+bbox(:,11);
    
    if bbox(:,6) < bbox(:,10)
        y1 = bbox(:,6);
    else
        y1 = bbox(:,10);
    end
    if (bbox(:,6) + bbox(:,8)) > (bbox(:,10) + bbox(:,12)) 
        y2 = (bbox(:,6) + bbox(:,8));
    else        
        y2 = (bbox(:,10) + bbox(:,12));
    end    
    eyes = img(y1:y2,x1:x2,:);

end

