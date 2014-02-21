function mouth = getMouth( img,bbox )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    topLeft = [bbox(:,13) bbox(:,14)];
    topRight = [bbox(:,13)+bbox(:,15) bbox(:,14)];
    bottomLeft = [bbox(:,13) bbox(:,14)+bbox(:,16)];
    bottomRight = [bbox(:,13)+bbox(:,15) bbox(:,14)+bbox(:,16)];
    
    x1 = bbox(:,13);
    x2 = bbox(:,13)+bbox(:,15);
    y1 = bbox(:,14);
    y2 = bbox(:,14)+bbox(:,16);
    
    mouth = img(y1:y2,x1:x2,:);

end

