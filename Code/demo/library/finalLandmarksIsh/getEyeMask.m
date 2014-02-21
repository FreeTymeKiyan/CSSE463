function finalMask = getEyeMask(eye)

% %[means, eyes] = kmean(eyes, 5);
[smoothEye, edgeMask] = smoothAndFindEdges(eye);
imtool(smoothEyes)
% imtool(edgeMask);

% se = strel(ones(5, 15));
% dilatedEdgeMask = imdilate(edgeMask, se);
% % imtool(dilatedLeftMask);
% 
% [cc, nComponents] = bwlabel(dilatedEdgeMask);
% 
% biggestComponentSize = 0;
% for index = 1:nComponents
%     mySize = sum(sum(cc == index));
%     if (mySize > biggestComponentSize)
%         biggestComponentSize = mySize;
%         biggestComponentIndex = index;
%     end
% end

% finalMask = (cc == biggestComponentIndex) & edgeMask;
finalMask = edgeMask;
end