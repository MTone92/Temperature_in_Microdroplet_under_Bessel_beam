function f = Integralg(kr,c,Ref,gamma,r_0,Ru,n,m)
% This function is used to calculate the integral transfermation of g,
% generation.

    dr = 0.001;                         % 0.001 is accurate enough.
    dmu1 = 0.01;                        % set dmu for different interval.
    dmu2 = 0.005;
    dmu3 = 0.001;
    dmu4 = 10^(-5);
    
    r = (dr/2:dr:1-dr/2);
    mu1 = (-0.5+dmu1/2:dmu1:0.5-dmu1/2);
    mu2 = [(-0.9+dmu2/2:dmu2:-0.5-dmu2/2),(0.5+dmu2/2:dmu2:0.9-dmu2/2)];
    mu3 = [(-0.99+dmu3/2:dmu3:-0.9-dmu3/2),(0.9+dmu3/2:dmu3:0.99-dmu3/2)];
    mu4 = [(-1+dmu4/2:dmu4:-0.99-dmu4/2),(0.99+dmu4/2:dmu4:1-dmu4/2)];
    
    [r1,mu1] = meshgrid(r,mu1);
    [r2,mu2] = meshgrid(r,mu2);
    [r3,mu3] = meshgrid(r,mu3);
    [r4,mu4] = meshgrid(r,mu4);
    
    f1 = r1.^1.5.*besselj(n+0.5,Ru(n+1,m).*r1).*legendreP(n,mu1).*g(kr,c,Ref,gamma,r_0,r1,mu1).*dmu1;
    f2 = r2.^1.5.*besselj(n+0.5,Ru(n+1,m).*r2).*legendreP(n,mu2).*g(kr,c,Ref,gamma,r_0,r2,mu2).*dmu2;
    f3 = r3.^1.5.*besselj(n+0.5,Ru(n+1,m).*r3).*legendreP(n,mu3).*g(kr,c,Ref,gamma,r_0,r3,mu3).*dmu3;
    f4 = r4.^1.5.*besselj(n+0.5,Ru(n+1,m).*r4).*legendreP(n,mu4).*g(kr,c,Ref,gamma,r_0,r4,mu4).*dmu4;
    
    f = ( sum(sum(f1)) + sum(sum(f2)) + sum(sum(f3)) + sum(sum(f4)) ).*dr;
end