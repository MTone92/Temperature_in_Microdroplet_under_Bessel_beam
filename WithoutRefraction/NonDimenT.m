function f = NonDimenT(N,M,Bi,Ru,gBar,r,mu,t,pls,slop)
% This function is used to calculate the Non-dimensional temperature
% for Triangular pulse.
    
    T = zeros(size(r));         % Initiate T;
    for n_ind = 1:1:N
        n = n_ind-1;
        s = 0;
        parfor m_ind = 2:1:M
            s = s + besselj(n+0.5,Ru(n_ind,m_ind).*r).*r.^(-0.5)./besselj(n+0.5,Ru(n_ind,m_ind)).^2 ...
            ./((Bi-0.5).^2+Ru(n_ind,m_ind).^2-(n+0.5).^2)...
            .*gBar(n_ind,m_ind).*slop./Ru(n_ind,m_ind).^2 ...
            .*(exp(-Ru(n_ind,m_ind).^2.*t) + exp(-Ru(n_ind,m_ind).^2.*(t-pls)) - 2*exp(-Ru(n_ind,m_ind).^2.*(t-pls/2)));
        end
        T = T + (2*n+1).*legendreP(n,mu).*s;
    end
    f = T;
end