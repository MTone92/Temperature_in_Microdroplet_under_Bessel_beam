% This Program is used to plot the figures used in APL Paper.
set(groot,'DefaultAxesFontSize',30,'DefaultTextFontSize',30,...
    'DefaultAxesFontName','Times New Roman','DefaultTextFontName','Times New Roman',...
	'DefaultAxesFontWeight','bold','DefaultTextFontWeight','bold',...
	'DefaultLineLineWidth',5,'DefaultLineMarkerSize',16,...
    'DefaultFigureColor','w','FixedWidthFontName','Times New Roman')

%% Find out maximum Non-dimensional temperature at P = 1W:
load('T183_8Pulses.mat');
lambda = 1064*10^(-9);              % Laser wave length.
kr = 2*pi/lambda;                   % Wave vector.
R = 0.26*10^(-3);                   % Radius of the laser spot.
f = 30000;                          % List of laser repitition rates.
P = 1;                              % List of corresponding laser powers.
I0 = IntensityP(P,f,R,kr);          % Laser peak intensity at P = 1W.

factor = linspace(0,50,51);
I = I0*factor/10^13;
for i = 2:4
    Tmax0 = max(max(T183(:,:,i)));
    Tmax0 = Tmax0/30;
    Tmax = Tmax0*factor*dT+T_amb-5;
    
    plot(I,Tmax);
    hold on;
end
xlim([0 20]);
set(gca,'FontName','Times New Roman');