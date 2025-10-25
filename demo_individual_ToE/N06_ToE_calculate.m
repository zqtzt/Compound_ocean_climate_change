%%%%%%%%%calculate ToE
clear
clc

load('./Input_data/T_global_avg_baseline1960_1989.mat')
xt=linspace(1960,2024,769);
xt(end)=[];
T_global_level_smooth=NaN(768,41);
for k=1:41
    T_global_level_smooth(:,k)=smooth(xt,T_global_level(:,k),25*12,'lowess',2);
end
%% ToE for each standard depth levels
load('./Input_data/local_signal_noise_regress_level.mat')

ToE_warming=NaN(360,180,41);
ToE_cooling=NaN(360,180,41);

for k=1:41
    k
    global_level_anomaly_monthly_smooth=squeeze(T_global_level_smooth(:,k));
    for i=1:360
        i;
        for j=1:180
            signal_div_noise_2023=signal(i,j,k)./noise(i,j,k);
            if(abs(signal_div_noise_2023)<1 || isnan(signal_div_noise_2023))
                %case without any emergence until 2021
                continue
            end
            for year=2022:-1:1960 
                avg_signal=nanmean(global_level_anomaly_monthly_smooth((year-1960)*12+1:(year+1-1960)*12));
                local_signal=avg_signal * aerfa_regress(i,j,k);
                local_noise=noise(i,j,k);  %1 std
                signal_div_noise=local_signal./local_noise;
                if(signal_div_noise<1 && signal_div_noise>=0)
                    ToE_warming(i,j,k)=year+1;
                    break
                elseif(signal_div_noise>-1 && signal_div_noise<0)
                    ToE_cooling(i,j,k)=year+1;
                    break
                end
            end
        end
    end
end

save ./ToE_data/ToE_data_level.mat ToE_warming ToE_cooling lat lon depth_std

%% ToE for upper200(epipelagic zone) and upper200-1000m (mesopelagic zone)
clear
clc
lon=1:360;
lat=-89.5:89.5;
load('./Input_data/T_global_avg_baseline1960_1989.mat')
load('./Input_data/singal_noise_upper2001000.mat')
ToE_warming_upper200=NaN(360,180);
ToE_cooling_upper200=NaN(360,180);
ToE_warming_upper200_1000=NaN(360,180);
ToE_cooling_upper200_1000=NaN(360,180);

xt=linspace(1960,2024,769);
xt(end)=[];
T_global_upper200_smooth=smooth(xt,T_global_upper200,25*12,'lowess',2);
T_global_upper200_1000_smooth=smooth(xt,T_global_upper200_1000,25*12,'lowess',2);

for i=1:360
    i
    for j=1:180
        signal_div_noise_2023=singal_ratio_noise_200(i,j);
        if(abs(signal_div_noise_2023)<1 || isnan(signal_div_noise_2023))
            %%no emergence before 2022 --> pass
            continue
        end
        for year=2022:-1:1961 
            avg_signal=nanmean(T_global_upper200_smooth((year-1960)*12+1:(year+1-1960)*12));
            local_signal=avg_signal * aerfa_regress_200(i,j);
            local_noise=noise_200(i,j);  %1 std
            %below is |SNR|>1
            signal_div_noise=local_signal./local_noise;
            if(signal_div_noise<1 && signal_div_noise>=0)
                ToE_warming_upper200(i,j)=year+1;
                break
            elseif(signal_div_noise>-1 && signal_div_noise<0)
                ToE_cooling_upper200(i,j)=year+1;
                break
            end
            if(year==1961 && signal_div_noise>=1)
                ToE_warming_upper200(i,j)=1960;
            elseif(year==1961 && signal_div_noise<=-1)
                ToE_cooling_upper200(i,j)=1960;
            end
        end
    end
end

for i=1:360
    i
    for j=1:180
        signal_div_noise_2023=singal_ratio_noise_200_1000(i,j);
        if(abs(signal_div_noise_2023)<1 || isnan(signal_div_noise_2023))
            continue
        end
        for year=2022:-1:1961  
            avg_signal=nanmean(T_global_upper200_1000_smooth((year-1960)*12+1:(year+1-1960)*12));
            local_signal=avg_signal * aerfa_regress_200_1000(i,j);
            local_noise=noise_200_1000(i,j);  %1 std
            signal_div_noise=local_signal./local_noise;
            if(signal_div_noise<1 && signal_div_noise>=0)
                ToE_warming_upper200_1000(i,j)=year+1;
                break
            elseif(signal_div_noise>-1 && signal_div_noise<0)
                ToE_cooling_upper200_1000(i,j)=year+1;
                break
            end
        end
    end
end

save ./ToE_data/ToE_data_upper2001000.mat ToE_warming_upper200 ToE_cooling_upper200 ToE_warming_upper200_1000 ToE_cooling_upper200_1000 lat lon

%%  plot 200-1000m ToE map (should be runned with m_map package; https://www.eoas.ubc.ca/~rich/map.html)

load ./functions/mycolor_England_1.mat
mycolor_cool=mycolor(1:9,:);
mycolor_hot=mycolor(11:end,:);
mycolor_hot=flipud(mycolor_hot);

gcf=figure();
set (gcf,'Position',[488,131.4,987.4,630.6])
ax1=axes;
hold on
m_proj('robinson','lon',[0 360],'lat',[-90 90]);
m_line([0,360],[0,0],'LineWidth',1,'LineStyle','--','Color','black');
m_grid('gridcolor',0.95*[207 207 207]/255,'ytick',[-90:30:90],'xtick',[0:60:360],...
    'fontsize',20 ,'box','on','color','black', 'linewidth',1.5);
m_coast('patch',[192 192 192]/255,'edgecolor',[0.15 0.15 0.15]);  
h1=m_pcolor(lon,lat,ToE_cooling_upper200_1000');
cb1=colorbar;
colormap(mycolor_cool)
caxis([1985 2025])
set(cb1,'TickLabels',{'1985','1990','1995','2000','2005','2010','2015','2020','2023'})
set(cb1,'location','SouthOutside')
set(cb1,'fontsize',20)
cbarrow('left')
freezeColors
h2=m_pcolor(lon,lat,ToE_warming_upper200_1000');
cb2=colorbar;
colormap(mycolor_hot)
caxis([1985 2025])
set(cb2,'TickLabels',{'1985','1990','1995','2000','2005','2010','2015','2020','2023'})
title('ToE of temperature (200-1000m)','FontSize',20,'Fontname','Arial','FontWeight','bold')
 %%% This is also the result of Extended Data Fig.6c (without 95% CI estimation)
saveas(gcf,['./Temperature_ToE_upper200_1000m.png']) 
%% plot 0-200m ToE map (should be runned with m_map package; https://www.eoas.ubc.ca/~rich/map.html)
gcf=figure();
set(gcf,'Position',[488,131.4,987.4,630.6])
ax1=axes;
hold on
m_proj('robinson','lon',[0 360],'lat',[-90 90]);
m_line([0,360],[0,0],'LineWidth',1,'LineStyle','--','Color','black');
m_grid('gridcolor',0.95*[207 207 207]/255,'ytick',[-90:30:90],'xtick',[0:60:360],...
    'fontsize',20 ,'box','on','color','black', 'linewidth',1.5);
m_coast('patch',[192 192 192]/255,'edgecolor',[0.15 0.15 0.15]);  
h1=m_pcolor(lon,lat,ToE_cooling_upper200');
cb1=colorbar;
colormap(mycolor_cool)
caxis([1985 2025])
set(cb1,'TickLabels',{'1985','1990','1995','2000','2005','2010','2015','2020','2023'})
set(cb1,'location','SouthOutside')
set(cb1,'fontsize',20)
cbarrow('left')
freezeColors
h2=m_pcolor(lon,lat,ToE_warming_upper200');
cb2=colorbar;
colormap(mycolor_hot)
caxis([1985 2025])
set(cb2,'TickLabels',{'1985','1990','1995','2000','2005','2010','2015','2020','2023'})
title('ToE of temperature (0-200m)','FontSize',20,'Fontname','Arial','FontWeight','bold')
 %%% This is also the result of Extended Data Fig.6b (without 95% CI estimation)
saveas(gcf,['./Temperature_ToE_upper200m.png'])
