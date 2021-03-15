function f = FindRu0(Bi,n)
% This function is used to find the roots coincide with the boundary condition
    myBC = @(x) (Bi+n).*besselj(n+0.5,x)-x.*besselj(n+1.5,x);
    x0 = linspace(0,3000,3001);
    x0(1) = 0.2;                            % For some special case with low Bi and n=0.
    x0 = [0,x0];
    Roots = zeros(size(x0));
    %options = optimset('TolX',10^(-23));                    % Set tolerance.
    for ind=n+1:1:3000
        Roots(ind) = fzero(myBC,x0(ind));
    end
    Roots_unique = unique(Roots);
    Roots_unique = Roots_unique(diff(Roots_unique)>0.00001);
    while Roots_unique(2)<x0(n+1)
        Roots_unique(2)=[];
    end
    
    f = Roots_unique;
end