% This Program is used to compute the Temp with different Cpm;
load('Ag20_Refraction_r50_Cp_P30_pulse170_f30kHz_N201M200.mat');

delete(gcp('nocreate'))
parpool(31);

Cp = 3408;                  % Isobaric Heat Capacity of Suspension.
Latent = 2264705;           % Latent Heat of water @ 100C.
Cpm = Cp + Latent/dT;       % Modified Heat Capacity.
alpha = alpha*Cp/Cpm;       % Modified Thermal diffusivity of Suspension.
t_ref = r_0^2/alpha;        % Reference time (for eliminating thermal diffusivity in PDE).

pls = pl./t_ref;            % Non-dimensional pulse length.
slop = 2/pls;               % Non-dimensional slop of the pulse profile.

N = 101;
M = 100;

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
save('Ag20_Refraction_r50_Cpm_P30_pulse170_f30kHz_N201M200.mat');