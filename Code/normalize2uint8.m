function vector = normalize2uint8(vector)
%normalize2unit8 Convert a double vector to a uint8 vector ranging 0 to 255
%   vector = normalize2uint8(vector)
    maxVal = max(vector);
    minVal = min(vector);
    vector = vector - minVal;
    vector = vector/maxVal;
    vector = vector*255;
    vector = uint8(vector);
end

