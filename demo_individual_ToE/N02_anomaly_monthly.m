%%%% calculate anamoly field relative to 1960-1979 baseline
clear
clc

%%%%% This is the path to storage the IAPv3 1-degree grid datasets from 1960 to 2021 in monthly netCDF format
%%% You can download this dataset at http://www.ocean.iap.ac.cn
path='D:\QC_OHC_uncertainty\OHC_cal_QCpapers\CAS_v1_temp_monthly_netCDF_CODCQC_XBTMBTBOTcor_20221229\';

depth_std=ncread([path,'CAS_v1_2000m_year_1960_month_01.nc'],'depth_std');
lat=ncread([path,'CAS_v1_2000m_year_1960_month_01.nc'],'lat');
lon=ncread([path,'CAS_v1_2000m_year_1960_month_01.nc'],'lon');

for month=1:12
    month
    eval(['load ./clim_1960_1979/CAS_1960_1979_clim_month',num2str(month),'.mat temp_clim_monthly'])
    
    for year=1960:2021
        filename=[path,'CAS_v1_2000m_year_',num2str(year),'_month_',num2str(month,'%02d'),'.nc'];
        temp=ncread(filename,'temp');
        
        temp_anomaly=temp-temp_clim_monthly;
        filename=['./temp_anomaly_monthly_1960_1979/CAS_2000m_year_',num2str(year),'_month_',num2str(month,'%02d'),'.mat'];
        eval(['save ',filename,' temp_anomaly lat lon depth_std'])
        clear temp
    end
end

%%  put anomaly data into a 'large' array 360*180*41*744;
clear

xt=linspace(1960,2022,745);
xt(end)=[];
temp_anomaly_all=single(NaN(360,180,41,744));

m=1;
for year=1960:2021
    year
    for month=1:12
        filename=['./temp_anomaly_monthly_1960_1979/CAS_2000m_year_',num2str(year),'_month_',num2str(month,'%02d'),'.mat'];
        load(filename)
        temp_anomaly=permute(temp_anomaly,[2,3,1]);
        
        temp_anomaly_all(:,:,:,m)=single(temp_anomaly);
        
        m=m+1;
        clear temp_anomaly
    end
end

save temp_monthly_anomaly_data_baseline1960_1979.mat temp_anomaly_all lon lat depth_std xt -v7.3

%% calculate depth average 0 0-200m 200-1000m
clear

%%%%% This is the path to storage the IAPv3 1-degree grid datasets from 1960 to 2021 in monthly netCDF format
path='D:\QC_OHC_uncertainty\OHC_cal_QCpapers\CAS_v1_temp_monthly_netCDF_CODCQC_XBTMBTBOTcor_20221229\';
depth_std=ncread([path,'CAS_v1_2000m_year_1960_month_01.nc'],'depth_std');

xt=linspace(1960,2021,745);
xt(end)=[];
T_upper200_monthly_anomaly=single(NaN(360,180,744));
T_upper200_1000_monthly_anomaly=single(NaN(360,180,744));

m=1;
for year=1960:2021
    year
    for month=1:12
        month
        filename=['./temp_anomaly_monthly_1960_1979/CAS_2000m_year_',num2str(year),'_month_',num2str(month,'%02d'),'.mat'];
        load(filename)
        temp_anomaly=permute(temp_anomaly,[2,3,1]);
        
        parfor i=1:360
            for j=1:180
                temp_level=temp_anomaly(i,j,:);
                if(all(isnan(temp_level)))
                    continue
                end
                T_upper200_monthly_anomaly(i,j,m)=depth_avg_grid(temp_level,depth_std,1,17);
                T_upper200_1000_monthly_anomaly(i,j,m)=depth_avg_grid(temp_level,depth_std,17,32);
            end
        end
        clear temp_anomaly
        
        m=m+1;
    end
end
save temp_monthly_anomaly_upper20010002000_baseline1960_1979.mat T_upper2000_monthly_anomaly T_upper200_monthly_anomaly T_upper200_1000_monthly_anomaly lon lat xt depth_std
