% This Program is used to plot the figures for comparing the temperature
% distribution with or without refraction.
set(groot,'DefaultAxesFontSize',30,'DefaultTextFontSize',30,...
    'DefaultAxesFontName','Times New Roman','DefaultTextFontName','Times New Roman',...
	'DefaultAxesFontWeight','bold','DefaultTextFontWeight','bold',...
	'DefaultLineLineWidth',5,'DefaultLineMarkerSize',16,...
    'DefaultFigureColor','w')

load('Ag20_Refraction_r50_Cp_P30_pulse170_f30kHz_N201M200.mat');
T_refraction = T4*dT + T_amb-5;
load('Ag20_r50_Cp_P30_pulse170_f30kHz_dt_N501M500.mat');
T_norefraction = T4*dT + T_amb-5;

diameter = 100;
T1 = [T_refraction(1,end:-1:1),T_refraction(end,2:end)];
T2 = [T_norefraction(1,end:-1:1),T_norefraction(end,2:end)];
z = linspace(0,diameter,length(T1));

plot(z,T1);
hold on
plot(z,T2);
legend('Axis temperature considering refraction','Axis temperature without refraction');

xlabel('distance to the drop top along centerline, z (\mum)','color','k','fontsize',30);
ylabel('Temperature, T (^\circC)','color','k','fontsize',30);