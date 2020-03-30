function errorGrad = gradErrorFEM(vh, t, p)
%GRADERRORFEM Summary of this function goes here
%   Detailed explanation goes here

n = length(t(1, :)); 
vt = zeros(1, 3);
err = 0;

for i=1:n
    elem = getTriangle(t, i);
    a = area(elem, p);
    
    p1 = p(:, elem(1));
    p2 = p(:, elem(2));
    p3 = p(:, elem(3));
    
    %analytic gradient
    ut12 = getMiddleValue(p1, p2, @grad);
    ut23 = getMiddleValue(p2, p3, @grad);
    ut13 = getMiddleValue(p1, p3, @grad);
    
    %numeric    
    gr = doGradOnGrid(vh(elem(1)), vh(elem(2)), vh(elem(3)), p, elem);
    
    err = err + a*(len2(gr, ut12) + len2(gr, ut23) + len2(gr, ut13))/3;
end
errorGrad = sqrt(err);
end
