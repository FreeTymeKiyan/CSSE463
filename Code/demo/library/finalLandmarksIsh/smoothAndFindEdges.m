function [smoothImg, edgeMask] = smoothAndFindEdges(img)

    noEdges = true;
    smoothingFactor = 0;
    while (noEdges && smoothingFactor >= 0)
        smoothImg = smoothFilter(img, 'average', [4 4], smoothingFactor);
        edgeMask = edges(smoothImg, smoothingFactor, 'canny');
        noEdges = (all(all(~edgeMask)));
        smoothingFactor = smoothingFactor - 1;
    end
end