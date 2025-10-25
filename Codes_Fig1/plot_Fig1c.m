%%%%  Used to generate the Fig.1c (T,S, DO, T+S, T+DO, T+S+DO)
clear
clc

% load data for individual and double CIDs emergence and its 95% confidence level
load ./ToE_data/S_ToE_percentage_year_CI_upper200_1000.mat *upper200_1000_975 *upper200_1000_25 *upper200_1000_median
S_ToE_percentage_upper200_1000_25=S_ToE_percentage_upper200_1000_25(1:2023);
S_ToE_percentage_upper200_1000_975=S_ToE_percentage_upper200_1000_975(1:2023);
S_ToE_percentage_upper200_1000_median=S_ToE_percentage_upper200_1000_median(1:2023);
load ./ToE_data/T_ToE_percentage_year_CI_upper200_1000.mat *upper200_1000_975 *upper200_1000_25 *upper200_1000_median
load ./ToE_data/DO_ToE_percentage_year_CI_upper200_1000.mat *upper200_1000_975 *upper200_1000_25 *upper200_1000_median
load ./ToE_data/percentage_year_T_DO_overlap_upper2001000.mat *upper200_1000_975 *upper200_1000_25 *upper200_1000_median lat lon
load ./ToE_data/percentage_year_T_S_overlap_upper2001000.mat *upper200_1000_975 *upper200_1000_25 *upper200_1000_median
load ./ToE_data/percentage_year_T_S_DO_overlap_200_1000.mat *upper200_1000_975 *upper200_1000_25 *upper200_1000_median

%%%% set NaN value to zero
S_ToE_percentage_upper200_1000_25(isnan(S_ToE_percentage_upper200_1000_25))=0;
S_ToE_percentage_upper200_1000_975(isnan(S_ToE_percentage_upper200_1000_975))=0;
S_ToE_percentage_upper200_1000_median(isnan(S_ToE_percentage_upper200_1000_median))=0;
T_ToE_percentage_upper200_1000_median(isnan(T_ToE_percentage_upper200_1000_median))=0;
T_ToE_percentage_upper200_1000_975(isnan(T_ToE_percentage_upper200_1000_975))=0;
T_ToE_percentage_upper200_1000_25(isnan(T_ToE_percentage_upper200_1000_25))=0;
T_S_ToE_percentage_upper200_1000_median(isnan(T_S_ToE_percentage_upper200_1000_median))=0;
T_S_ToE_percentage_upper200_1000_975(isnan(T_S_ToE_percentage_upper200_1000_975))=0;
T_S_ToE_percentage_upper200_1000_25(isnan(T_S_ToE_percentage_upper200_1000_25))=0;
T_S_DO_ToE_percentage_upper200_1000_median(isnan(T_S_DO_ToE_percentage_upper200_1000_median))=0;
T_S_DO_ToE_percentage_upper200_1000_975(isnan(T_S_DO_ToE_percentage_upper200_1000_975))=0;
T_S_DO_ToE_percentage_upper200_1000_25(isnan(T_S_DO_ToE_percentage_upper200_1000_25))=0;
T_DO_ToE_percentage_upper200_1000_median(isnan(T_DO_ToE_percentage_upper200_1000_median))=0;
T_DO_ToE_percentage_upper200_1000_975(isnan(T_DO_ToE_percentage_upper200_1000_975))=0;
T_DO_ToE_percentage_upper200_1000_25(isnan(T_DO_ToE_percentage_upper200_1000_25))=0;
DO_ToE_percentage_upper200_1000_median(isnan(DO_ToE_percentage_upper200_1000_median))=0;
DO_ToE_percentage_upper200_1000_975(isnan(DO_ToE_percentage_upper200_1000_975))=0;
DO_ToE_percentage_upper200_1000_25(isnan(DO_ToE_percentage_upper200_1000_25))=0;

%%% add the 'uncertainty due to baseline choice and decadal variability in the quantification of the signal' to the double and triple emergence
load ./ToE_data/ToE_diff_percentage_year_T_S_overlap_upper2001000.mat *lower *upper
T_S_ToE_diff_area_upper200_1000_lower(2023)=T_S_ToE_diff_area_upper200_1000_lower(2022);
T_S_ToE_diff_area_upper200_1000_upper(2023)=T_S_ToE_diff_area_upper200_1000_upper(2022);
T_S_ToE_diff_area_upper200_1000_lower(isnan(T_S_ToE_diff_area_upper200_1000_lower))=0;
T_S_ToE_diff_area_upper200_1000_upper(isnan(T_S_ToE_diff_area_upper200_1000_upper))=0;
T_S_ToE_percentage_upper200_1000_25=T_S_ToE_percentage_upper200_1000_25-T_S_ToE_diff_area_upper200_1000_lower;
T_S_ToE_percentage_upper200_1000_975=T_S_ToE_percentage_upper200_1000_975+T_S_ToE_diff_area_upper200_1000_upper;
load ./ToE_data/ToE_diff_percentage_year_T_DO_overlap_upper2001000.mat *lower *upper
T_DO_ToE_diff_area_upper200_1000_lower(2023)=T_DO_ToE_diff_area_upper200_1000_lower(2022);
T_DO_ToE_diff_area_upper200_1000_upper(2023)=T_DO_ToE_diff_area_upper200_1000_upper(2022);
T_DO_ToE_diff_area_upper200_1000_lower(isnan(T_DO_ToE_diff_area_upper200_1000_lower))=0;
T_DO_ToE_diff_area_upper200_1000_upper(isnan(T_DO_ToE_diff_area_upper200_1000_upper))=0;
T_DO_ToE_percentage_upper200_1000_25=T_DO_ToE_percentage_upper200_1000_25-T_DO_ToE_diff_area_upper200_1000_lower;
T_DO_ToE_percentage_upper200_1000_975=T_DO_ToE_percentage_upper200_1000_975+T_DO_ToE_diff_area_upper200_1000_upper;
load ./ToE_data/ToE_diff_percentage_year_T_S_DO_overlap_upper2001000.mat *lower *upper
T_S_DO_ToE_diff_area_upper200_1000_lower(2023)=T_S_DO_ToE_diff_area_upper200_1000_lower(2022);
T_S_DO_ToE_diff_area_upper200_1000_upper(2023)=T_S_DO_ToE_diff_area_upper200_1000_upper(2022);
T_S_DO_ToE_diff_area_upper200_1000_lower(isnan(T_S_DO_ToE_diff_area_upper200_1000_lower))=0;
T_S_DO_ToE_diff_area_upper200_1000_upper(isnan(T_S_DO_ToE_diff_area_upper200_1000_upper))=0;
T_S_DO_ToE_percentage_upper200_1000_25=T_S_DO_ToE_percentage_upper200_1000_25-T_S_DO_ToE_diff_area_upper200_1000_lower;
T_S_DO_ToE_percentage_upper200_1000_975=T_S_DO_ToE_percentage_upper200_1000_975+T_S_DO_ToE_diff_area_upper200_1000_upper;

figure()
hold on
x=1960:2023;
y1=T_ToE_percentage_upper200_1000_median(1960:2023)*100;
y2=T_ToE_percentage_upper200_1000_975(1960:2023)*100;
y3=T_ToE_percentage_upper200_1000_25(1960:2023)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.89,0.47,0.40],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.3)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.89,0.47,0.40],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.3)
plot(1960:2023,y1,'-','LineWidth',1.5,'Color',[0.89,0.47,0.40])

y1=S_ToE_percentage_upper200_1000_median(1960:2023)*100;
y2=S_ToE_percentage_upper200_1000_975(1960:2023)*100;
y3=S_ToE_percentage_upper200_1000_25(1960:2023)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],'blue','HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.2)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],'blue','HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.2)
plot(1960:2023,y1,'-','LineWidth',1.5,'Color',[0.31,0.31,0.85])

y1=DO_ToE_percentage_upper200_1000_median(1960:2023)*100;
y2=DO_ToE_percentage_upper200_1000_975(1960:2023)*100;
y3=DO_ToE_percentage_upper200_1000_25(1960:2023)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[219,43,219]./255,'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.3)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[219,43,219]./255,'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.3)
plot(1960:2023,y1,'-','LineWidth',1.5,'Color',[219,43,219]./255)

y1=T_DO_ToE_percentage_upper200_1000_median(1960:2023)*100;
y2=T_DO_ToE_percentage_upper200_1000_975(1960:2023)*100;
y3=T_DO_ToE_percentage_upper200_1000_25(1960:2023)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[0.47,0.67,0.19],'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.7)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[0.47,0.67,0.19],'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.7)
plot(1960:2023,y1,'-','LineWidth',4,'Color',[0.56,0.87,0.13])

y1=T_S_ToE_percentage_upper200_1000_median(1960:2023)*100;
y2=T_S_ToE_percentage_upper200_1000_975(1960:2023)*100;
y3=T_S_ToE_percentage_upper200_1000_25(1960:2023)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],[130,173,209]./255 ,'HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.7)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],[130,173,209]./255 ,'HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.7)
plot(1960:2023,y1,'-','LineWidth',4,'Color',[82,108,227]./255)

y1=T_S_DO_ToE_percentage_upper200_1000_median(1960:2023)*100;
y2=T_S_DO_ToE_percentage_upper200_1000_975(1960:2023)*100;
y3=T_S_DO_ToE_percentage_upper200_1000_25(1960:2023)*100;
h1=fill([x,fliplr(x)],[y2,fliplr(y1)],'black','HandleVisibility','off');
set(h1,'edgealpha',0,'facealpha',0.6)
h2=fill([x,fliplr(x)],[y1,fliplr(y3)],'black','HandleVisibility','off');
set(h2,'edgealpha',0,'facealpha',0.6)
plot(1960:2023,y1,'-','LineWidth',3,'Color','black')

ylabel('Ocean area (%)')
xlabel('Year');
title('Global percentage of emergence (Mesopelagic zone)')
legend('Temperature','Salinity','Dissolved Oxygen','Double CIDs(T&DO)','Double CIDs(T&S)','Triple CIDs(T&S&DO)')
plot_setting(1)
xlim([1980 2023])
ylim([0 100])

saveas(gcf,'./pics/Fig1c.pdf')