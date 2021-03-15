% Main Program to calculate the Temperature distribution inside a droplet
% under Pulsatile Infrared Laser.

delete(gcp('nocreate'))
parpool(31);

% Input parameters:
lambda = 1064*10^(-9);      % Wave length of infrared laser: 1064 nm.
P_avg = 30;                 % Average Power of the laser.
frequency = 30000;          % Laser frequency.
pl = 170*10^(-9);           % Laser pulse length.
P = 2*P_avg/(frequency*pl); % Laser Peak Power.
R = 0.26*10^(-3);           % Radius of the laser spot.
Ref = 0.06;                 % Reflection coefficients.
gamma1 = 10^4;              % Absorbance of the droplet.
r_0 = 50*10^(-6);           % Radius of the droplet.
k = 10;                     % Thermal Conductivity of water @ 25C.
alpha = 2.414*10^(-6);      % Thermal diffusivity of Suspension @ 25C.
h = 90;                     % Convection heat transfer coefficient in air (h = 10~100 or 10~1000).
T_amb = 25;                 % Proposed ambient temperature.
T_sat = 100;                % Proposed saturated temperature under 1 bar.
Cp = 3408;                  % Isobaric Heat Capacity of Suspension (J/kg*K).
Latent = 2264705;           % Latent Heat of water @ 100C (J/kg).
n1 = 1.377;                 % Refractive index for Ag20 Suspension.

% Dependent parameters:
dT = T_sat - T_amb;         % Reference temperature (T* = (T-T_amb)/(T_sat-T_amb)).
kr = 2*pi/lambda;           % Wave factor.
c = P/(besselj(0,kr*R)^2+besselj(1,kr*R)^2)*(gamma1*r_0^2)/(pi*dT*k*R^2);
                            % Non-dimensional laser intensity.
%Cpm = Cp + Latent/dT;       % Modified Heat Capacity.
%alpha = alpha*Cp/Cpm;       % Modified Thermal diffusivity of water.
t_ref = r_0^2/alpha;        % Reference time (for eliminating thermal diffusivity in PDE).
Bi = h*r_0/k;
pls = pl./t_ref;            % Non-dimensional pulse length.
slop = 2/pls;               % Non-dimensional slop of the pulse profile.

% Main Program:
I = 0;                          % Number of terms in i deciding number of pulse.
N = 201;                         % Number of terms in n deciding number of Pn(mu).
M = 200;                         % Number of terms in m deciding number of J(n+0.5,Ru(n,m)).
r = linspace(0,1,101);          % Grid size in r-direction;
theta = linspace(0,pi,101);     % Grid size in theta-direction;
[r,theta] = meshgrid(r,theta);
mu = cos(theta);
mu(51,:) = 0;
[y,x] = pol2cart(theta,r);      % Convert Spherical Coordinates to Cartesian Coordinates,
                                % Notice the switch from [x,y] to [y,x] due
                                % to the different dirction of theta in
                                % Spherical Coordinates and Polar Coordi.
r(:,1) = 0.01*r(:,2);           % Avoid sigularity @ r = 0.

Ru = zeros(N,M);            % Initiate the matrix size of Ru.
for n_ind = 1:1:N           % Find out all roots coincide with BC.
    n = n_ind-1;
    Roots = FindRu0(Bi,n);
    Ru(n_ind,:) = Roots(1:M);
end

%% Calculate gBar:
gBar = zeros(N,M);          % Initiate the integral transformation of g.
for n_ind = 1:1:N
    n = n_ind-1;
    parfor m_ind = 1:1:M
        m = m_ind;
        gBar(n_ind,m_ind) = Integralg(kr,c,Ref,gamma1,r_0,Ru,n1,n,m);
    end
end

%% Calculate Temperature:
tau = [0 1 197 198 394].*pls;               % Proposed laser pattern.
t = [0 10 33 65 98 131 163 195].*pls;          % Temperature interval = 5.55 us.
Temp = zeros([size(r) numel(t)]);           % Initiate Temperature Matrix.
for i = 2:1:numel(t)
    Temp(:,:,i) = NonDimenT(N,M,Bi,Ru,gBar,r,mu,t(i),pls,slop);
end
T2 = Temp(:,:,2);
T3 = Temp(:,:,3);
T4 = Temp(:,:,4);
T5 = Temp(:,:,5);
T6 = Temp(:,:,6);
T7 = Temp(:,:,7);
T8 = Temp(:,:,8);
%% Save the data:
save('Ag20_Refraction_r50_Cp_P30_pulse170_f30kHz_N201M200.mat');