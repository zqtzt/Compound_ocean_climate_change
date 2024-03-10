%%%%  Used to generate the Fig.1a surface (T,S,T+S,pH)
clear
clc

%%%% load data for individual CIDs emergence and its 95% confidence level
load('./ToE_data/T_ToE_percentage_year_CI_levels.mat')
T_ToE_percentage_surface_median=T_ToE_percentage_level_median(1,:);
T_ToE_percentage_surface_975=T_ToE_percentage_level_975(1,:);
T_ToE_percentage_surface_25=T_ToE_percentage_level_25(1,:);
clear T_ToE_percentage_level_25 T_ToE_percentage_level_975 T_ToE_percentage_level_median T_ToE_percentage_level

load ./ToE_data/S_ToE_percentage_year_CI_levels.mat
S_ToE_percentage_surface_25=S_ToE_percentage_level_25(1,:);
S_ToE_percentage_surface_975=S_ToE_percentage_level_975(1,:);
S_ToE_percentage_surface_median=S_ToE_percentage_level_median(1,:);
clear S_ToE_percentage_level_975 S_ToE_percentage_level_25 S_ToE_percentage_level_median S_ToE_percentage_level

%pH
load('./ToE_data/CMEMS_ph_ToE_percentage_year.mat')
ph_ToE_percentage_lower=ph_ToE_percentage_lower';
ph_ToE_percentage_upper=ph_ToE_percentage_upper';
ph_ToE_percentage_mean=ph_ToE_percentage_mean';

ph_ToE_percentage_mean(ph_ToE_percentage_mean>=1)=1;
ph_ToE_percentage_upper(ph_ToE_percentage_upper>=1)=1;
ph_ToE_percentage_lower(ph_ToE_percentage_lower>=1)=1;

% double T+S
%%%% load the double emergence (Temp & Salinity) and its 95% confidence level
load ./ToE_data/percentage_year_T_S_overlap_surface.mat
S_ToE_percentage_surface_975(isnan(S_ToE_percentage_surface_975))=0;
S_ToE_percentage_surface_25(isnan(S_ToE_percentage_surface_25))=0;
T_ToE_percentage_surface_median(isnan(T_ToE_percentage_surface_median))=0;
T_ToE_percentage_surface_975(isnan(T_ToE_percentage_surface_975))=0;
T_ToE_percentage_surface_25(isnan(T_ToE_percentage_surface_25))=0;
T_S_ToE_percentage_surface_25(isnan(T_S_ToE_percentage_surface_25))=0;
T_S_ToE_percentage_surface_975(isnan(T_S_ToE_percentage_surface_975))=0;
T_S_ToE_percentage_surface_median(isnan(T_S_ToE_percentage_surface_median))=0;
ph_ToE_percentage_mean(isnan(ph_ToE_percentage_mean))=0;
ph_ToE_percentage_upper(isnan(ph_ToE_percentage_upper))=0;
ph_ToE_percentage_lower(isnan(ph_ToE_percentage_lower))=0;

%%% add the 'uncertainty due to decadal variability in the quantification of the signal' to the double emergence
load ./ToE_data/ToE_diff_percentage_year_T_S_overlap_surface.mat *lower *upper
T_S_ToE_diff_area_surface_lower(isnan(T_S_ToE_diff_area_surface_lower))=0;
T_S_ToE_diff_area_surface_upper(isnan(T_S_ToE_diff_area_surface_upper))=0;
T_S_ToE_percentage_surface_25=T_S_ToE_percentage_surface_25-T_S_ToE_diff_area_surface_lower;
T_S_ToE_percentage_surface_975=T_S_ToE_percentage_surface_975+T_S_ToE_diff_area_surface_upper;


figure()
hold on
x=1960:2021;
y1=T_ToE_percentage_surface_median(1960:2021)*100;
y2=T_ToE_percentage_surface_975(1960:2021)*100;
y3=T_ToE_percentage_surface_25(1960:2021)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.89,0.47,0.40],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.3)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.89,0.47,0.40],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.3)
plot(1960:2021,y1,'-','LineWidth',1.5,'Color',[0.89,0.47,0.40])

y1=S_ToE_percentage_surface_median(1960:2021)*100;
y2=S_ToE_percentage_surface_975(1960:2021)*100;
y3=S_ToE_percentage_surface_25(1960:2021)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],'blue','HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.2)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],'blue','HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.2)
plot(1960:2021,y1,'-','LineWidth',1.5,'Color',[0.31,0.31,0.85])

x=1960:2021;
y1=ph_ToE_percentage_mean(1960:2021)*100;
y2=ph_ToE_percentage_upper(1960:2021)*100;
y3=ph_ToE_percentage_lower(1960:2021)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],'black','HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.2)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],'black','HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.2)
plot(1960:2021,y1,'-','LineWidth',1.5,'Color','black')

x=1960:2021;
y1=T_S_ToE_percentage_surface_median(1960:2021)*100;
y2=T_S_ToE_percentage_surface_975(1960:2021)*100;
y3=T_S_ToE_percentage_surface_25(1960:2021)*100;
hold on
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.51,0.68,0.82],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.5)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.51,0.68,0.82],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.5)
plot(1960:2021,y1,'-','LineWidth',2,'Color',[0.51,0.68,0.82])

ylabel('Ocean area (%)')
xlabel('Year');
title('Global percentage of emergence (Surface)')
legend('Temperature','Salinity','pH','Double CIDs(T&S)')
plot_setting(1)
ylim([0 100.1])
xlim([1980 2021])

saveas(gcf,'./pics/Fig1a.pdf')
