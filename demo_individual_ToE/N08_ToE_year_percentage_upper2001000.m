%%%%%%%% global percentage of temperautre emergence as a function of year
clear
clc

load global_grid_area.mat global_area
load ./Input_data/singal_noise_upper2001000.mat signal_200 signal_200_1000

%%%% mask polar region
signal_200(1:360,[1:20,159:180])=NaN;
signal_200_1000(1:360,[1:20,159:180])=NaN;
signal_2000(1:360,[1:20,159:180])=NaN;

%upper200 (epipelagic zone)
load('./ToE_data/ToE_data_upper2001000.mat')
area_copy=global_area;
area_copy(isnan(signal_200))=NaN;
total_area=sum(sum(area_copy,'omitnan'),'omitnan');
for year=1960:2023
    warming_level=ToE_warming_upper200;
    cooling_level=ToE_cooling_upper200;
    %%%算个数
    warming_index=warming_level==year;
    area_copy1=area_copy;
    area_copy1(~warming_index)=NaN;
    ToE_area_warming=sum(sum(area_copy1,'omitnan'),'omitnan');

    cooling_index=cooling_level==year;
    area_copy2=area_copy;
    area_copy2(~cooling_index)=NaN;
    ToE_area_cooling=sum(sum(area_copy2,'omitnan'),'omitnan');

    ToE_area=ToE_area_warming+ToE_area_cooling;
    ToE_percentage_level(year)=ToE_area/total_area;
end
T_ToE_percentage_upper200=cumsum(ToE_percentage_level(:)); %cumulative sum
clear ToE_percentage_level


%upper200_1000 (mesopelagic zone)
area_copy=global_area;
area_copy(isnan(signal_200_1000))=NaN;
total_area=sum(sum(area_copy,'omitnan'),'omitnan');
for year=1960:2023
    warming_level=ToE_warming_upper200_1000;
    cooling_level=ToE_cooling_upper200_1000;
    %%%算个数
    warming_index=warming_level==year;
    area_copy1=area_copy;
    area_copy1(~warming_index)=NaN;
    ToE_area_warming=sum(sum(area_copy1,'omitnan'),'omitnan');

    cooling_index=cooling_level==year;
    area_copy2=area_copy;
    area_copy2(~cooling_index)=NaN;
    ToE_area_cooling=sum(sum(area_copy2,'omitnan'),'omitnan');

    ToE_area=ToE_area_warming+ToE_area_cooling;
    ToE_percentage_level(year)=ToE_area/total_area;
end
T_ToE_percentage_upper200_1000=cumsum(ToE_percentage_level(:));
clear ToE_percentage_level

save ./ToE_data/T_ToE_percentage_year_upper2001000.mat T_ToE_percentage_upper200 T_ToE_percentage_upper200_1000
%%
figure()
hold on
plot(1960:2023,T_ToE_percentage_upper200(1960:2023)*100,'-','LineWidth',2)
plot(1960:2023,T_ToE_percentage_upper200_1000(1960:2023)*100,'-','LineWidth',2)
ylabel('Ocean area (%)')
xlabel('Year');
title('Global percentage of emergence')
legend('0-200m','200-1000m')
plot_setting(1)
xlim([1980 2023])
saveas(gcf,'./Ocean_coverage_year_200_1000_temperature.png')