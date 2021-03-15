function f = g(kr,c,Ref,gamma,r_0,r,mu)
% This function is used to calculate the non-dimensional internal heat
% generation.
    d = r_0.*(sqrt(1-r.^2.*(1-mu.^2))-r.*mu);
    f = c.*(1-Ref).*exp(-gamma.*d).*besselj(0,kr.*r_0.*r.*sqrt(1-mu.^2)).^2;
end