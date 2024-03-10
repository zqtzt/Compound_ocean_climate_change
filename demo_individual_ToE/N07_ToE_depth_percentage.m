%%%%%%%% global percentage of temperautre emergence as a function of depth
clear
clc
load('./functions/mask_basin_1_0_360.mat')
load ./functions/global_grid_area.mat global_area
load ./functions/mask_temperature.mat
mask_temperature(1:360,[1:20,159:180],1:41)=NaN; %%%% mask polar region

load('./ToE_data/ToE_data_level.mat')  %You should run N06_ToE_calculate.m to get this file
for k=1:41                 
    %mask bottom depth
    temp_level=squeeze(mask_temperature(:,:,k));
    mask_copy=mask;
    mask_copy(isnan(temp_level))=0;
    
    %global sum areas
    area_copy=global_area;    
    area_copy(mask_copy==0)=NaN;  %0: land
    total_area_level=sum(sum(area_copy,'omitnan'),'omitnan');
     
    warming_level=ToE_warming(:,:,k);
    cooling_level=ToE_cooling(:,:,k);
    
    %%% calculate emergence areas £¨Warming+cooling)
    warming_index=isnan(warming_level);
    area_copy1=global_area;
    area_copy1(warming_index)=NaN;
    ToE_area_warming=sum(sum(area_copy1,'omitnan'),'omitnan');
    
    cooling_index=isnan(cooling_level);
    area_copy2=global_area;
    area_copy2(cooling_index)=NaN;
    ToE_area_cooling=sum(sum(area_copy2,'omitnan'),'omitnan');
    ToE_area=ToE_area_warming+ToE_area_cooling;
    
    T_ToE_percentage(k)=ToE_area/total_area_level;
end

save ./ToE_data/T_ToE_percentage_depth.mat T_ToE_percentage depth_std
%%
figure()
hold on
plot(depth_std,T_ToE_percentage*100,'--','LineWidth',3,'Color',[0.95,0.36,0.22])
legend('Temperature')
xlabel('Depth (m)')
ylabel('Ocean area (%)');
title('Percentage of Emergence');
plot_setting(1);
view(90,90)
% set(gca,'xdir','reverse')
saveas(gcf,'./ToE_depth_percentage_temp.png')

