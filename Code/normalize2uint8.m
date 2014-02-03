function vector = normalize2uint8( vector)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    maxVal = max(vector);
    minVal = min(vector);
    vector = vector - minVal;
    vector = vector/maxVal;
    vector = vector*255;

end

