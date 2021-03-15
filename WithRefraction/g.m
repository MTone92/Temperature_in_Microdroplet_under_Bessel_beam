function f = g(kr,c,Ref,gamma,r_0,n1,r,mu)
% This function is used to calculate the non-dimensional internal heat
% generation with considering refraction.

r1 = zeros(size(r));
theta1 = zeros(size(mu));
theta = acos(mu);
theta2 = asin(1/n1);

I = numel(r1);
for i = 1:1:I
    if (theta(i)>pi/2) && (r(i)*sin(theta(i)-pi/2+theta2)>1/n1)        % Nonilluminated area
        theta1(i) = 0;
    elseif r(i)*sin(theta(i))> 1*10^(-10)        % Normal area
        myfun = @(ri) cos(theta(i)-ri) + sqrt(n1^2/sin(ri)^2-1)*sin(theta(i)-ri)-1/r(i);
        theta1(i) = fzero(myfun,[1*10^(-10) pi/2]);
        r1(i) = n1*sin(theta(i)-theta1(i))/sin(theta1(i))*r(i);
    else                                        % Include centerline to f expression.
        r1(i) = 1 - (cos(theta(i)./abs(cos(theta(i))))).*r(i);
        theta1(i) = theta(i);
    end
end

    f = sin(theta1).^2./(r.*sin(theta)).^2.*c.*(1-Ref).*exp(-gamma.*r_0.*r1).*besselj(0,kr.*r_0.*sin(theta1)).^2;
    Ind = find(sin(theta)<10^(-10));
    f(Ind) = c.*(1-Ref).*exp(-gamma.*r_0.*r1(Ind)).*besselj(0,kr.*r_0.*sin(theta1(Ind))).^2;
end
