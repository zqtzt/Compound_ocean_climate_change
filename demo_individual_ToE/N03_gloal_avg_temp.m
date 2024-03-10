%%% calculate global average time series
clear
clc

path='./temp_anomaly_monthly_1960_1979/';

files=dir(path);
files([files.isdir])=[];

T_global_upper200=NaN(length(files),1);
T_global_upper200_1000=NaN(length(files),1);
T_global_upper200_2000=NaN(length(files),1);
T_global_upper300=NaN(length(files),1);
T_global_upper700=NaN(length(files),1);
T_global_upper2000=NaN(length(files),1);
T_global_level=NaN(length(files),41);
for m=1:length(files)
    m
    x=load([path,files(m).name]);
    
    lat=x.lat;
    lon=x.lon;
    depth_std=x.depth_std;
    temp_anomaly=x.temp_anomaly;
    
    temp_anomaly=permute(temp_anomaly,[2,3,1]);
    
    %%% mask polar region
    temp_anomaly(1:360,[1:20,159:180],1:41)=NaN;
    
    T_global_upper200(m)=global_weight_ave_all_levels(temp_anomaly,lat,lon,depth_std,1,17);
    T_global_upper200_1000(m)=global_weight_ave_all_levels(temp_anomaly,lat,lon,depth_std,17,32);
  
    for k=1:41
        T_global_level(m,k)=global_weight_ave_level(temp_anomaly(:,:,k),lat,lon);
    end

end
xt=linspace(1960,2022,745);
xt(end)=[];
T_global_SST_smooth=smooth(xt,T_global_level(:,1),25*12,'lowess',2);
T_global_upper200_1000_smooth=smooth(xt,T_global_upper200_1000,25*12,'lowess',2);
T_global_upper200_smooth=smooth(xt,T_global_upper200,25*12,'lowess',2);

save T_global_avg_baseline1960_1979.mat T_global_upper200 T_global_upper200_1000 T_global_level xt


%% each level
xt=linspace(1960,2022,745);
xt(end)=[];
for k=1:41
    T_global_level_smooth(:,k)=smooth(xt,T_global_level(:,k),25*12,'lowess',2);
end

for k=1:41
    k
    figure()
    hold on
    plot(xt,T_global_level(:,k),'-','Color',[0.4,0.64,0.8],'LineWidth',1.5);
    plot(xt,T_global_level_smooth(:,k),'-','Color',[0.4,0.60,0.8],'LineWidth',2.5,'HandleVisibility','off');
    xlabel('Year')
    ylabel('Temperature anomaly (^oC)')
    title(['Global average temperature ',num2str(depth_std(k)),'m'])
    plot_setting(1)
    xlim([1960 2021])
    saveas(gcf,['./pics/level_timeseries/global_SC_',num2str(depth_std(k)),'m_baseline1960_1979.png'])
end