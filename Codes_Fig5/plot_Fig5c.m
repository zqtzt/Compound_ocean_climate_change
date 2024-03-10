%%%%%%%%%%  bar of the High Sea emergence percentge (Fig.5c)
clear
clc

%% load data
%%%%%  load single emergence of temperature in the High Sea
load ./Input_data/T_ToE_HighSea_percentage_year_CI_upper20010002000.mat *median *25 *975 lat lon
%%%%%  single emergence of salinity in the High Sea
load ./Input_data/S_ToE_HighSea_percentage_year_CI_upper20010002000.mat *median *25 *975 lat lon
%%%%%%  single emergencce of DO in the High Sea
load ./Input_data/DO_ToE_HighSea_percentage_year_CI_upper20010002000.mat *median *25 *975
%%% single emergence of pH (value extracted from Fig. 1a)
ph_ToE_percentage_surface_median=99.99/100;
ph_ToE_percentage_surface_975=100/100;
ph_ToE_percentage_surface_25=99.90/100;

%order: T-S-DO-pH 
single_surface_ToE_median=[T_ToE_percentage_surface_median(2021),S_ToE_percentage_surface_median(2021),NaN,ph_ToE_percentage_surface_median];
single_surface_ToE_975=[T_ToE_percentage_surface_975(2021),S_ToE_percentage_surface_975(2021),NaN,ph_ToE_percentage_surface_975];
single_surface_ToE_25=[T_ToE_percentage_surface_25(2021),S_ToE_percentage_surface_25(2021),NaN,ph_ToE_percentage_surface_25];

single_upper200_ToE_median=[T_ToE_percentage_upper200_median(2021),S_ToE_percentage_upper200_median(2021),DO_ToE_percentage_upper200_median(2021),NaN];
single_upper200_ToE_975=[T_ToE_percentage_upper200_975(2021),S_ToE_percentage_upper200_975(2021),DO_ToE_percentage_upper200_975(2021),NaN];
single_upper200_ToE_25=[T_ToE_percentage_upper200_25(2021),S_ToE_percentage_upper200_25(2021),DO_ToE_percentage_upper200_25(2021),NaN];

single_upper200_1000_ToE_median=[T_ToE_percentage_upper200_1000_median(2021),S_ToE_percentage_upper200_1000_median(2021),DO_ToE_percentage_upper200_1000_median(2021),NaN];
single_upper200_1000_ToE_975=[T_ToE_percentage_upper200_1000_975(2021),S_ToE_percentage_upper200_1000_975(2021),DO_ToE_percentage_upper200_1000_975(2021),NaN];
single_upper200_1000_ToE_25=[T_ToE_percentage_upper200_1000_25(2021),S_ToE_percentage_upper200_1000_25(2021),DO_ToE_percentage_upper200_1000_25(2021),NaN];

clear T_ToE_percentage* S_ToE_percentage* DO_ToE_percentage* ph_ToE_percentage*

% load data of double emergence of T+S
load ./Input_data/percentage_year_HighSea_T_S_overlap_surface.mat
T_S_ToE_percentage_surface_25(isnan(T_S_ToE_percentage_surface_25))=0;
T_S_ToE_percentage_surface_975(isnan(T_S_ToE_percentage_surface_975))=0;
T_S_ToE_percentage_surface_median(isnan(T_S_ToE_percentage_surface_median))=0;

%%% add the 'uncertainty due to decadal variability in the quantification of the signal' error to the double emergence
load ./Input_data/ToE_diff_percentage_year_T_S_overlap_surface.mat *lower *upper
T_S_ToE_diff_area_surface_lower(isnan(T_S_ToE_diff_area_surface_lower))=0;
T_S_ToE_diff_area_surface_upper(isnan(T_S_ToE_diff_area_surface_upper))=0;
T_S_ToE_percentage_surface_25=T_S_ToE_percentage_surface_25-T_S_ToE_diff_area_surface_lower;
T_S_ToE_percentage_surface_975=T_S_ToE_percentage_surface_975+T_S_ToE_diff_area_surface_upper;
clear T_S_ToE_diff_area_surface_upper T_S_ToE_diff_area_surface_lower

load ./Input_data/percentage_year_HighSea_T_DO_overlap_upper2001000.mat *upper200_975 *upper200_25 *upper200_median lat lon *upper200_1000*
load ./Input_data/percentage_year_HighSea_T_S_overlap_upper2001000.mat *upper200_975 *upper200_25 *upper200_median *upper200_1000*

%%% add the 'uncertainty due to decadal variability in the quantification of the signal' error to the double emergence
load ./Input_data/ToE_diff_percentage_year_T_S_overlap_upper2001000.mat *lower *upper
T_S_ToE_percentage_upper200_25=T_S_ToE_percentage_upper200_25-T_S_ToE_diff_area_upper200_lower;
T_S_ToE_percentage_upper200_975=T_S_ToE_percentage_upper200_975+T_S_ToE_diff_area_upper200_upper;
clear T_S_ToE_diff_area_upper200_lower T_S_ToE_diff_area_upper200_upper
load ./Input_data/ToE_diff_percentage_year_T_DO_overlap_upper2001000.mat *lower *upper
T_DO_ToE_percentage_upper200_25=T_DO_ToE_percentage_upper200_25-T_DO_ToE_diff_area_upper200_lower;
T_DO_ToE_percentage_upper200_975=T_DO_ToE_percentage_upper200_975+T_DO_ToE_diff_area_upper200_upper;
clear T_DO_ToE_diff_area_upper200_lower T_DO_ToE_diff_area_upper200_upper

% double emergence:  T+S and T+DO
double_surface_ToE_median=[T_S_ToE_percentage_surface_median(2021),NaN];
double_surface_ToE_975=[T_S_ToE_percentage_surface_975(2021),NaN];
double_surface_ToE_25=[T_S_ToE_percentage_surface_25(2021),NaN];
double_upper200_ToE_median=[T_S_ToE_percentage_upper200_median(2021),T_DO_ToE_percentage_upper200_median(2021)];
double_upper200_ToE_975=[T_S_ToE_percentage_upper200_975(2021),T_DO_ToE_percentage_upper200_975(2021)];
double_upper200_ToE_25=[T_S_ToE_percentage_upper200_25(2021),T_DO_ToE_percentage_upper200_25(2021)];
double_upper200_1000_ToE_median=[T_S_ToE_percentage_upper200_1000_median(2021),T_DO_ToE_percentage_upper200_1000_median(2021)];
double_upper200_1000_ToE_975=[T_S_ToE_percentage_upper200_1000_975(2021),T_DO_ToE_percentage_upper200_1000_975(2021)];
double_upper200_1000_ToE_25=[T_S_ToE_percentage_upper200_1000_25(2021),T_DO_ToE_percentage_upper200_1000_25(2021)];
clear T_S_ToE_* T_DO_ToE_*

%%% load data of triple emergence T+S+DO
load ./Input_data/percentage_year_HighSea_T_S_DO_overlap_upper200.mat *upper200_975 *upper200_25 *upper200_median
load ./Input_data/ToE_diff_percentage_year_T_S_DO_overlap_upper2001000.mat *lower *upper
T_S_DO_ToE_percentage_upper200_25=T_S_DO_ToE_percentage_upper200_25-T_S_DO_ToE_diff_area_upper200_lower;
T_S_DO_ToE_percentage_upper200_975=T_S_DO_ToE_percentage_upper200_975+T_S_DO_ToE_diff_area_upper200_upper;
clear T_S_DO_ToE_diff_area_upper200_lower T_S_DO_ToE_diff_area_upper200_upper

load ./Input_data/percentage_year_HighSea_T_S_DO_overlap_200_1000.mat *upper200_1000_975 *upper200_1000_25 *upper200_1000_median
load ./Input_data/ToE_diff_percentage_year_T_S_DO_overlap_upper2001000.mat *lower *upper
T_S_DO_ToE_percentage_upper200_1000_25=T_S_DO_ToE_percentage_upper200_1000_25-T_S_DO_ToE_diff_area_upper200_1000_lower;
T_S_DO_ToE_percentage_upper200_1000_975=T_S_DO_ToE_percentage_upper200_1000_975+T_S_DO_ToE_diff_area_upper200_1000_upper;
clear T_S_DO_ToE_diff_area_upper200_1000_lower T_S_DO_ToE_diff_area_upper200_1000_upper

%% figure 5c
%%%1-4: T-S-DO-PH  5:6: T+S - T+DO
name={'T','S','DO','pH','T&S','T&DO','T&S&DO'};
figure()
hold on
bar(1:4,[single_surface_ToE_median;single_upper200_ToE_median;single_upper200_1000_ToE_median]*100,'LineWidth',1)
bar(5:6,[double_surface_ToE_median;double_upper200_ToE_median;double_upper200_1000_ToE_median]*100,'LineWidth',1.3)
bar(7,[NaN;T_S_DO_ToE_percentage_upper200_median(2021);T_S_DO_ToE_percentage_upper200_1000_median(2021)]*100,'LineWidth',1.5)

errorbar(0.8:3.8,single_surface_ToE_median*100,(single_surface_ToE_median-single_surface_ToE_25)*100,(single_surface_ToE_975-single_surface_ToE_median)*100,"o",'LineWidth',1,'Color','blue')
errorbar(1:4,single_upper200_ToE_median*100,(single_upper200_ToE_median-single_upper200_ToE_25)*100,(single_upper200_ToE_975-single_upper200_ToE_median)*100,"o",'LineWidth',1,'Color','red')
errorbar(1.2:4.2,single_upper200_1000_ToE_median*100,(single_upper200_1000_ToE_median-single_upper200_1000_ToE_25)*100,(single_upper200_1000_ToE_975-single_upper200_1000_ToE_median)*100,"o",'LineWidth',1,'Color',[0.93,0.69,0.13])

errorbar(4.8:5.8,double_surface_ToE_median*100,(double_surface_ToE_median-double_surface_ToE_25)*100,(double_surface_ToE_975-double_surface_ToE_median)*100,"o",'LineWidth',1.3,'Color','blue')
errorbar(5:6,double_upper200_ToE_median*100,(double_upper200_ToE_median-double_upper200_ToE_25)*100,(double_upper200_ToE_975-double_upper200_ToE_median)*100,"o",'LineWidth',1.3,'Color','red')
errorbar(5.2:6.2,double_upper200_1000_ToE_median*100,(double_upper200_1000_ToE_median-double_upper200_1000_ToE_25)*100,(double_upper200_1000_ToE_975-double_upper200_1000_ToE_median)*100,"o",'LineWidth',1.3,'Color',[0.93,0.69,0.13])

errorbar(7,T_S_DO_ToE_percentage_upper200_median(2021)*100,(T_S_DO_ToE_percentage_upper200_median(2021)-T_S_DO_ToE_percentage_upper200_25(2021))*100,(T_S_DO_ToE_percentage_upper200_975(2021)-T_S_DO_ToE_percentage_upper200_median(2021))*100,"o",'LineWidth',1.5,'Color','red')
errorbar(7.2,T_S_DO_ToE_percentage_upper200_1000_median(2021)*100,(T_S_DO_ToE_percentage_upper200_1000_median(2021)-T_S_DO_ToE_percentage_upper200_25(2021))*100,(T_S_DO_ToE_percentage_upper200_1000_975(2021)-T_S_DO_ToE_percentage_upper200_1000_median(2021))*100,"o",'LineWidth',1.5,'Color',[0.93,0.69,0.13])

set(gca,'XTickLabel',name)
ylabel('High Seas Emergence Area Covered (%)')
legend('Surface','Epipelagic Zone','Mesopelagic Zone')
plot_setting(1)

saveas(gcf,'./Fig5c.pdf')
