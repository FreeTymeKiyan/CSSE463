function showEigenimages(eigenvectorMatrix, imrows, imcols)
% showEigenImages Converts an eigenvector matrix to a series of images
%   showEigenImages(eigenvectorMatrix, imrows, imcols)

    for col = 1:size(eigenvectorMatrix, 2)
        eigenImage = reshape(normalize2uint8(eigenvectorMatrix(:,col)),imrows,imcols);
        imtool(eigenImage);
    end
end