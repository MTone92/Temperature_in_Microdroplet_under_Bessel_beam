function f = legendreP(n,x)
% This is the legendreP function for cluster use.
    P1 = 1;
    P2 = x;
    
    if n == 0
        f = P1;
    elseif n == 1
        f = P2;
    else
        for i = 2:1:n
            P3 = (2.*i-1)./i.*x.*P2-(i-1)./i.*P1;
            P1 = P2;
            P2 = P3;
        end
        f = P3;
    end
end