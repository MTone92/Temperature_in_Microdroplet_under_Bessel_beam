% This Program is used to plot the figures used in APL Paper.
set(groot,'DefaultAxesFontSize',30,'DefaultTextFontSize',30,...
    'DefaultAxesFontName','Time New Roman','DefaultTextFontName','Times New Roman',...
	'DefaultAxesFontWeight','bold','DefaultTextFontWeight','bold',...
	'DefaultLineLineWidth',3,'DefaultLineMarkerSize',16,...
    'DefaultFigureColor','w')

%% Find out the Temperature in Drop by C:
clear TC;
TC = T4*9.9/30*dT+T_amb-5;
% TC(find(TC>=210)) = 210;
xl = -x(:,end:-1:2);
x = [xl x];
yl = y(:,end:-1:2);
y = [yl y];
TCl = TC(:,end:-1:2);
TC = [TCl TC];
%{
%% Plot the Temperature thermal figure:
figure(1)
z = 0*x;
surf(x,y,z+200);
shading interp;
set(gca,'Box','off');
set(gca,'visible','off');
set(gca,'xtick',[]);
hold on;
%}
%% Plot the cretical temperature line for explosion:
% figure(2)
% boundary = plot([x(:,1);x(:,end)],[y(:,1);y(:,end)]);
boundary = plot(x(:,[1 end]),y(:,[1 end]));
% boundary.LineWidth = [1 1];
% boundary.Color = 'black';
hold on;
%[C,h] = contour(x,y,T2,[0.1 0.2 0.3 0.5 1]);
[C,h] = contour(x,y,TC,[0 210]);
% h.LineColor = [0.9290 0.6940 0.1250];
% h.LineColor = [0.8500 0.3250 0.0980];
h.LineColor = [0.4940 0.1840 0.5560];
% h.LineColor = 'w';
h.LineWidth = 3;
h.ShowText = 'off';
% h.LabelSpacing = 3000;
% clabel(C,h,'fontsize',28);
% clabel(C,h,'FontWeight','bold');
set(gca,'fontsize',30);
set(gca,'Box','off');
set(gca,'visible','off');
set(gca,'xtick',[]);
% xlabel('r*','color','k','fontsize',30);
% ylabel('z*','color','k','fontsize',30);

%% Post Processing
set(gcf, 'Position',  [0, 0, 880, 960]);      % Ensure Sphere Drop
% set(gcf, 'Position',  [100, 100, 460, 430]);
view(-180,-90);
% print('Ag20_Refraction_r50_Cp_P30_pulse170_f30kHz_N201M200_t1.83us(ER).svg','-dsvg');