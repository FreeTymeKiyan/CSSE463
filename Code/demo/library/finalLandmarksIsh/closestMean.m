function index = closestMean( y1,y2,y3, means )
    % The code below may look stupid but we had issues with double vs.
    % unsigned integers =)
    dmin = Inf;
    for i = 1:size(means)
        x1 = means(i,1);
        x2 = means(i,2);
        x3 = means(i,3);
        a1 = y1-x1;
        b1 = y2-x2;
        c1 = y3-x3;
        d = sqrt(a1^2 + b1^2 + c1^2);
        if d < dmin
            dmin = d;
            imin = i;
        end
    end
    index = imin;
end