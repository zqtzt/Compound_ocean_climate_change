%%%%  Used to generate the Fig.1d (ocean areas as a fucntion of depth for individual and compound emergences)
clear
clc

load('./ToE_data/S_ToE_percentage_depth.mat') %sainityy
load('./ToE_data/T_ToE_percentage_depth.mat')  %temp
load('./ToE_data/DO_ToE_percentage_depth.mat') %Dissolved oxygen
depth_std_79=depth_std(1:79);

load('./ToE_data/percentage_depth_T_S_DO.mat')
load('./ToE_data/percentage_depth_T_S.mat')
load('./ToE_data/percentage_depth_T_DO.mat')

% set NaN value to zero
S_ToE_percentage_25(isnan(S_ToE_percentage_25))=0;
S_ToE_percentage_975(isnan(S_ToE_percentage_975))=0;
S_ToE_percentage_median(isnan(S_ToE_percentage_median))=0;
T_ToE_percentage_median(isnan(T_ToE_percentage_median))=0;
T_ToE_percentage_975(isnan(T_ToE_percentage_975))=0;
T_ToE_percentage_25(isnan(T_ToE_percentage_25))=0;
T_S_percentage_median(isnan(T_S_percentage_median))=0;
T_S_percentage_975(isnan(T_S_percentage_975))=0;
T_S_percentage_25(isnan(T_S_percentage_25))=0;
T_S_DO_percentage_median(isnan(T_S_DO_percentage_median))=0;
T_S_DO_percentage_975(isnan(T_S_DO_percentage_975))=0;
T_S_DO_percentage_25(isnan(T_S_DO_percentage_25))=0;
T_DO_percentage_median(isnan(T_DO_percentage_median))=0;
T_DO_percentage_975(isnan(T_DO_percentage_975))=0;
T_DO_percentage_25(isnan(T_DO_percentage_25))=0;
DO_ToE_percentage_median(isnan(DO_ToE_percentage_median))=0;
DO_ToE_percentage_975(isnan(DO_ToE_percentage_975))=0;
DO_ToE_percentage_25(isnan(DO_ToE_percentage_25))=0;


%% create Fig.1d
figure()
hold on
x=depth_std';
y1=T_ToE_percentage_median*100;
y2=T_ToE_percentage_975*100;
y3=T_ToE_percentage_25*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.89,0.47,0.40],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.3)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.89,0.47,0.40],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.3)
plot(depth_std,y1,'-','LineWidth',1.5,'Color',[0.89,0.47,0.40])

y1=S_ToE_percentage_median*100;
y2=S_ToE_percentage_975*100;
y3=S_ToE_percentage_25*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],'blue','HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.2)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],'blue','HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.2)
plot(depth_std,y1,'-','LineWidth',1.5,'Color',[0.31,0.31,0.85])

x=depth_std_79';
y1=DO_ToE_percentage_median*100;
y2=DO_ToE_percentage_975*100;
y3=DO_ToE_percentage_25*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.86,0.17,0.86],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.3)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.86,0.17,0.86],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.3)
plot(depth_std_79,y1,'-','LineWidth',1.5,'Color',[0.86,0.17,0.86])

x=depth_std';
y1=T_S_percentage_median*100;
y2=T_S_percentage_975*100;
y3=T_S_percentage_25*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.55,0.45,0.69],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.6)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.55,0.45,0.69],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.6)
plot(depth_std,y1,'-','LineWidth',2,'Color',[0.55,0.45,0.69])

y1=T_DO_percentage_median*100;
y2=T_DO_percentage_975*100;
y3=T_DO_percentage_25*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.47,0.67,0.19],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.5)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.47,0.67,0.19],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.5)
plot(depth_std,y1,'-','LineWidth',2,'Color',[0.47,0.67,0.19])

y1=T_S_DO_percentage_median*100;
y2=T_S_DO_percentage_975*100;
y3=T_S_DO_percentage_25*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],'black','HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.6)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],'black','HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.6)
plot(depth_std,y1,'-','LineWidth',2.5,'Color','black')

xlabel('Depth (m)')
ylabel('Ocean area (%)');
title('Global percentage of emergence')
legend('Temperature','Salinity','Dissolved Oxygen','Double CIDs(T&S)','Double CIDs(T&DO)','Triple CIDs(T&S&DO)')
plot_setting(1)
view(90,90)
xlim([0 1000]) %0-1000m


saveas(gcf,'./Fig1d.pdf')