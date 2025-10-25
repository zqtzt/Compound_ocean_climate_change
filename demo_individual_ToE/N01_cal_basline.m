%%%%%%%% calculate 1960-1979 climatology (baseline)
clear
clc

%%%%% This is the path to storage the IAPv3 1-degree grid datasets from 1960 to 2021 in monthly netCDF format
%%% You can download this dataset at http://www.ocean.iap.ac.cn/ftp/cheng/CZ16_v3_IAP_Temperature_gridded_1month_netcdf/
path='D:\QC_OHC_uncertainty\OHC_cal_QCpapers\CAS_v1_temp_monthly_netCDF_CODCQC_XBTMBTBOTcor_20221229\';

depth_std=ncread([path,'CAS_v1_2000m_year_1960_month_01.nc'],'depth_std');
lat=ncread([path,'CAS_v1_2000m_year_1960_month_01.nc'],'lat');
lon=ncread([path,'CAS_v1_2000m_year_1960_month_01.nc'],'lon');

mkdir ./clim_1960_1989/
for month=1:12
    month
    m=1;
    temp_all=single(NaN(30,41,360,180));
    for year=1960:1989
        year
        filename=[path,'CAS_v1_2000m_year_',num2str(year),'_month_',num2str(month,'%02d'),'.nc'];
        temp=ncread(filename,'temp');
         
         temp_all(m,:,:,:)=temp;
         m=m+1;
    end
    temp_clim_monthly=squeeze(nanmean(temp_all,1));    
        
    
   eval(['save ./clim_1960_1989/CAS_1960_1989_clim_month',num2str(month),'.mat temp_clim_monthly lat lon depth_std'])  
   clear temp_clim_monthly
end
  