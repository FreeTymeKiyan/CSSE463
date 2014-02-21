function [l, r] = getEyes( img,bbox, widthMargin, heightMargin)
    
    leftWidth = bbox(:,7);
    x1 = bbox(:,5) + leftWidth * widthMargin;
    x2 = bbox(:,5) + leftWidth * (1 - widthMargin);
    
    leftHeight = bbox(:,8);
    y1 = bbox(:,6) + leftHeight * heightMargin;
    y2 = bbox(:,6) + leftHeight * (1 - heightMargin);
    l = img(y1:y2,x1:x2,:);
    
    rightWidth = bbox(:,11);
    x1 = bbox(:,9) + rightWidth * widthMargin;
    x2 = bbox(:,9) + rightWidth * (1 - widthMargin);
    
    rightHeight = bbox(:,12);
    y1 = bbox(:,10) + rightHeight * heightMargin;
    y2 = bbox(:,10) + rightHeight * (1 - heightMargin);
    r = img(y1:y2,x1:x2,:);

end

