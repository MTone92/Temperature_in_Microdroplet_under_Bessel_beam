function f = NonDimenT(N,M,Bi,Ru,gBar,r,mu,t,tau)
% This function is used to calculate the Non-dimensional temperature.
    
    T = zeros(size(r));         % Initiate T;
    for n_ind = 1:1:N
        n = n_ind-1;
        s = 0;
        parfor m_ind = 2:1:M
            if m_ind~=1
                s = s + gBar(n_ind,m_ind)./besselj(n+0.5,Ru(n_ind,m_ind)).^2 ...
                .*besselj(n+0.5,Ru(n_ind,m_ind).*r).*r.^(-0.5)...
                ./((Bi-0.5).^2+Ru(n_ind,m_ind).^2-(n+0.5).^2)...
                .*(1-exp(-Ru(n_ind,m_ind).^2.*(t-tau)));
            else
                s = s + 2.*r.^n.*gamma(n+1.5)./Ru(n_ind,m_ind).^(n+0.5)...
                ./((Bi-0.5).^2+Ru(n_ind,m_ind).^2-(n+0.5).^2)...
                .*gBar(n_ind,m_ind).*(1-exp(-Ru(n_ind,m_ind).^2.*(t-tau)));
            end
        end
        T = T + (2*n+1).*legendreP(n,mu).*s;
    end
    f = T;
end