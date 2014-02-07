function F = crop( img, top, bottom, left, right )
%crop.m crop a region from an image
%   Author Yang Liu
%   img:    the img matrix needs to be cropped
%   top:    the top boundary
%   bottom: the bottom boundary
%   left:   the left boundary
%   right:  the right boundary
    if nargin < 3
        error('at least three inputs are required');
    end
    if nargin < 5
        left = 1;
        right = size(img, 2);
    end
    if top <= bottom && left <= right
        F = img(top : bottom, left : right);
    else 
        error('invalid region')
    end
end