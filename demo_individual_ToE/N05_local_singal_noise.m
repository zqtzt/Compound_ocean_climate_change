%%%%%%%%%%%% local singal and noise in each 1-degree box at each standard depth level following Hawkins et al., 2020
clear
clc

load temp_monthly_anomaly_data_baseline1960_1989.mat
load global_SN_level.mat
size(temp_anomaly_all)

aerfa_regress=NaN(360,180,41);
signal=NaN(360,180,41);
noise=NaN(360,180,41);
for k=1:41
    k
    for i=1:360
        i;
        for j=1:180
            temp_monthly=squeeze(temp_anomaly_all(i,j,k,:));
            if(all(isnan(temp_monthly)))
                continue
            end
            
            y_local=temp_monthly;
            y_global=T_global_level_smooth(:,k);
            
            [b_regress,bint,~,~,stats2] = regress(y_local,[ones(length(y_global),1),y_global]);
            aerfa_regress(i,j,k)=b_regress(2);
            if(abs(aerfa_regress(i,j,k) - 0) <= 1e-8)
                aerfa_regress(i,j,k)=NaN;
                signal(i,j,k)=NaN;
                noise(i,j,k)=NaN;
                continue
            end
            
            local_signal=global_T_signal_level(k) * b_regress(2);
            signal(i,j,k)=local_signal;
            local_noise= nanstd(y_local-y_global*b_regress(2));
            noise(i,j,k)=local_noise;
        end
    end
    
end

signal_noise_level=signal./noise;

save ./ToE_data/local_signal_noise_regress_level.mat signal noise lon lat aerfa_regress depth_std signal_noise_level


%% local singal and noise for global epipelagic and mesopelagic zone following the methods of Hawkins et al., 2020
clear
clc

load global_SN_level.mat
load temp_monthly_anomaly_upper20010002000_baseline1960_1989.mat

aerfa_regress_200=NaN(360,180);
signal_200=NaN(360,180);
noise_200=NaN(360,180);

aerfa_regress_200_1000=NaN(360,180);
signal_200_1000=NaN(360,180);
noise_200_1000=NaN(360,180);

xt=linspace(1960,2024,769);
xt(end)=[];
T_global_upper200_smooth=smooth(xt,T_global_upper200,25*12,'lowess',2);
avg_2021=nanmean(T_global_upper200_smooth((2023-1960)*12+1:(2024-1960)*12));  %2021年全球上层700米信号
global_T_signal_upper200=avg_2021;

T_global_upper2000_smooth=smooth(xt,T_global_upper2000,25*12,'lowess',2);
avg_2021=nanmean(T_global_upper2000_smooth((2023-1960)*12+1:(2024-1960)*12));  %2021年全球上层700米信号
global_T_signal_upper2000=avg_2021;

T_global_upper200_1000_smooth=smooth(xt,T_global_upper200_1000,25*12,'lowess',2);
avg_2021=nanmean(T_global_upper200_1000_smooth((2023-1960)*12+1:(2024-1960)*12));  %2021年全球上层700米信号
global_T_signal_upper200_1000=avg_2021;

%%%%%%%%upper200-1000m (mesopelagic zone)
for i=1:360
    i
    for j=1:180
        temp_monthly=squeeze(T_upper200_1000_monthly_anomaly(i,j,:));
        if(all(isnan(temp_monthly)))
            continue
        end
        
        y_local=temp_monthly;
        y_global=T_global_upper200_1000_smooth;
        
        [b_regress,bint,~,~,stats2] = regress(y_local,[ones(length(y_global),1),y_global]);
        aerfa_regress_200_1000(i,j)=b_regress(2);
        if(abs(aerfa_regress_200_1000(i,j) - 0) <= 1e-8)
            aerfa_regress_200_1000(i,j)=NaN;
            signal_200_1000(i,j)=NaN;
            noise_200_1000(i,j)=NaN;
            continue
        end
        
        local_signal=global_T_signal_upper200_1000 * b_regress(2);
        signal_200_1000(i,j)=local_signal;
        local_noise= nanstd(y_local-y_global*b_regress(2));
        noise_200_1000(i,j)=local_noise;
    end
end
singal_ratio_noise_200_1000=signal_200_1000./noise_200_1000;

%%%%%%%%upper200m (epipelagic zone)
for i=1:360
    i
    for j=1:180
        temp_monthly=squeeze(T_upper200_monthly_anomaly(i,j,:));
        if(all(isnan(temp_monthly)))
            continue
        end
        
        y_local=temp_monthly;
        y_global=T_global_upper200_smooth;
        
        [b_regress,bint,~,~,stats2] = regress(y_local,[ones(length(y_global),1),y_global]);
        aerfa_regress_200(i,j)=b_regress(2);
        if(abs(aerfa_regress_200(i,j) - 0) <= 1e-8)
            aerfa_regress_200(i,j)=NaN;
            signal_200(i,j)=NaN;
            noise_200(i,j)=NaN;
            continue
        end
        
        local_signal=global_T_signal_upper200 * b_regress(2);
        signal_200(i,j)=local_signal;
        local_noise= nanstd(y_local-y_global*b_regress(2));
        noise_200(i,j)=local_noise;
    end
end
singal_ratio_noise_200=signal_200./noise_200;

save ./ToE_data/singal_noise_upper2001000.mat signal_200 noise_200 singal_ratio_noise_200 signal_200_1000 noise_200_1000 singal_ratio_noise_200_1000 xt aerfa_regress_200 aerfa_regress_200_1000

%figure
% plot_lat_lon(lon,lat,signal_200,'signal\_200')
% plot_lat_lon(lon,lat,noise_200,'noise_200')
% plot_lat_lon(lon,lat,singal_ratio_noise_200,'S.N\_200')