#!/usr/bin/env python
# coding: utf-8

# In[10]:


'''
    This is the demo to create the figure for the compound CID dataset
    The code is used to reproduce the Fig.3 in the Tan et al., 2025(NCC)
    Here, we use the 2023 data (ToE_compound_2023.nc) as an example. But you can change the loop to run other year data.
    Three blocks are provided: Block #1 is the epipelagic zone, Block #2 is the plot in the mesopelagic zone, and Block #3 is the plot at the sea surface
    Creator: Zhetao Tan (LMD/ENS)
    Email: zhetao.tan@lmd.ipsl.fr or tanzhetao19@mails.ucas.ac.cn
    Python pacakages cartopy, matplotlib, xarray, numpy, seaborn are necessary
'''

import numpy as np
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from cartopy.mpl.ticker import LongitudeFormatter, LatitudeFormatter
import matplotlib.pyplot as plt
from cartopy.util import add_cyclic_point
import seaborn as sns
import cartopy
import matplotlib
from cartopy.util import add_cyclic_point
import xarray as xr

def central_transform(data2D):
    data2D_new=np.full((360,180),np.nan)
    data2D_new[180:361,:]=data2D[20:200,:]
    data2D_new[0:160,:]=data2D[200:360,:]
    data2D_new[160:180,:]=data2D[0:20,:]
    return data2D_new

def reduced_dimension(variable_2D_lon_lat,times=4):
    signal_divide_noise1_reduced = variable_2D_lon_lat.copy()
    for i in range(360):
        for j in range(180):
            if i % times != 0 or j % times != 0:
                signal_divide_noise1_reduced[i, j] = np.nan
    return signal_divide_noise1_reduced


######### create customize colorbars  tiaosepan
white=(1,1,1)
reds=sns.color_palette('Reds',6)
reds=[white,reds[0],reds[2]]
new_reds=matplotlib.colors.ListedColormap(reds,name='new_reds')  #only T 

whites=sns.color_palette('binary',6)
whites=[white,whites[1],whites[3]]
new_whites=matplotlib.colors.ListedColormap(whites,name='new_whites')  # only S 

purples=sns.color_palette('Purples_r',16)
purples=[white,purples[6],purples[0]]  
new_purples=matplotlib.colors.ListedColormap(purples,name='new_purples')  #### only DO 

oranges=sns.color_palette('YlOrBr',8)
oranges=[white,oranges[3],oranges[5]]
new_oranges=matplotlib.colors.ListedColormap(oranges,name='new_oranges')  #T+S  oranges

dark_green=sns.color_palette('YlGn_r',12)
dark_greens=[white,dark_green[3],dark_green[0]]  
new_dark_greens=matplotlib.colors.ListedColormap(dark_greens,name='new_dark_greens')  #T+S+DO  dark green

light_green=sns.color_palette('YlGn_r',12)
light_green=[white,light_green[8],light_green[6]]  
new_light_greens=matplotlib.colors.ListedColormap(light_green,name='new_light_greens')  #T+DO  light green


#### epipelagic zone (0-200m)
for year_investigate in range(2010,2024):
    print(year_investigate)

    ### load data from netCDF file, here is the example for epipelagic zone (0-200m)
    filename='../IAP_CompoundCID_dataset/ToE_compound_'+str(year_investigate)+'.nc'
    ds_raw = xr.open_dataset(filename)
    
    Exposure_level_epipelagic = ds_raw["Exposure_level_epipelagic"].values.transpose()                   
    lon=ds_raw['lon'].values
    lat=ds_raw['lat'].values
    Exposure_type_epipelagic=ds_raw["Exposure_type_epipelagic"].values.transpose()


    exposure_T_flag=np.copy(Exposure_level_epipelagic)
    exposure_T_flag[np.where(Exposure_type_epipelagic!=1)]=np.nan
    exposure_S_flag=np.copy(Exposure_level_epipelagic)
    exposure_S_flag[np.where(Exposure_type_epipelagic!=2)]=np.nan
    exposure_DO_flag=np.copy(Exposure_level_epipelagic)
    exposure_DO_flag[np.where(Exposure_type_epipelagic!=3)]=np.nan
    exposure_T_S_flag=np.copy(Exposure_level_epipelagic)
    exposure_T_S_flag[np.where(Exposure_type_epipelagic!=4)]=np.nan
    exposure_T_DO_flag=np.copy(Exposure_level_epipelagic)
    exposure_T_DO_flag[np.where(Exposure_type_epipelagic!=5)]=np.nan
    exposure_T_S_DO_flag=np.copy(Exposure_level_epipelagic)
    exposure_T_S_DO_flag[np.where(Exposure_type_epipelagic!=6)]=np.nan
    
    #### transform the data projection central longitude
    exposure_T_flag=central_transform(exposure_T_flag)
    exposure_S_flag=central_transform(exposure_S_flag)
    exposure_DO_flag=central_transform(exposure_DO_flag)
    exposure_T_S_flag=central_transform(exposure_T_S_flag)
    exposure_T_DO_flag=central_transform(exposure_T_DO_flag)
    exposure_T_S_DO_flag=central_transform(exposure_T_S_DO_flag)
                    
    exposure_T_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_flag),np.transpose(lon))
    exposure_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_S_flag),np.transpose(lon))
    exposure_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_DO_flag),np.transpose(lon))
    exposure_T_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_S_flag),np.transpose(lon))
    exposure_T_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_DO_flag),np.transpose(lon))
    exposure_T_S_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_S_DO_flag),np.transpose(lon))

    ###### epipelagic zone
    lon2d,lat2d=np.meshgrid(cycle_lon,lat)
    
    fig=plt.figure(figsize=(15, 23))
    plt.rcParams['font.size'] = '12'  #set global fonts
    
    box=[-180,180,-90,90]  
    scale='50m'
    xstep,ystep=30,30
    proj=ccrs.PlateCarree(central_longitude=200)
    # proj=ccrs.Robinson()
    ax2=plt.axes(projection=proj)   #create projection
    ax2.plot([-180,180],[0,0],'--',linewidth=0.6,transform=proj,color='black')
    ax2.add_feature(cfeature.LAND, facecolor='0.9') #fill land colour
    # ax2.stock_img()  
    # ax2.coastlines(scale,linewidth=0.6)  # add coastlines
    ax2.set_xticks(np.arange(box[0], box[1] + xstep, xstep), crs=proj)
    ax2.set_yticks(np.arange(box[2], box[3] + ystep, xstep), crs=proj)
    lon_formatter = LongitudeFormatter(zero_direction_label=False)  
    lat_formatter = LatitudeFormatter()
    ax2.xaxis.set_major_formatter(lon_formatter)  # format latitude and longitude
    ax2.yaxis.set_major_formatter(lat_formatter)  # format latitude and longitude
    ax2.set_extent([-180,180,-80,80],crs=proj)
    
    #### plot contour lines
    interval=np.array([0,1,2,3])  
    cb1=ax2.contourf(lon2d,lat2d,(exposure_T_flag),interval,cmap=new_whites,alpha=0.90,extend='both',transform=proj)   
    if year_investigate in [2018]: #to aviod the plotting bugs of cartopy
        cb2=ax2.contourf(lon2d,lat2d,(exposure_S_flag),interval,cmap=new_whites,alpha=0.90,extend='both',transform=proj,corner_mask=False)
    else:
        cb2=ax2.contourf(lon2d,lat2d,(exposure_S_flag),interval,cmap=new_whites,alpha=0.90,extend='both',transform=proj)
    if year_investigate in [2010,2011,2015,2016,2017]:  #to aviod the plotting bugs of cartopy
        cb3=ax2.contourf(lon2d,lat2d,(exposure_DO_flag),interval,cmap=new_whites,alpha=0.9,extend='both',transform=proj,corner_mask=False)
    else:
        cb3=ax2.contourf(lon2d,lat2d,(exposure_DO_flag),interval,cmap=new_whites,alpha=0.9,extend='both',transform=proj)   
    cb4=ax2.contourf(lon2d,lat2d,(exposure_T_S_flag),interval,cmap=new_dark_greens,alpha=0.8,extend='both',transform=proj)  
    cb5=ax2.contourf(lon2d,lat2d,(exposure_T_DO_flag),interval,cmap=new_dark_greens,alpha=0.8,extend='both',transform=proj)
    cb6=ax2.contourf(lon2d,lat2d,exposure_T_S_DO_flag,interval,cmap=new_purples,alpha=0.80,extend='both',transform=proj)   
    
    #### set colorbar (if you don't need the colorbar, just annotate this section)
    cbar1=fig.colorbar(cb1,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar2=fig.colorbar(cb2,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar3=fig.colorbar(cb3,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar4=fig.colorbar(cb4,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar5=fig.colorbar(cb5,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar6=fig.colorbar(cb6,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar1.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar2.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar3.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar4.set_label('Double CIDs', size=12, fontweight='bold', color='k',loc='right')
    cbar5.set_label('Double CIDs', size=12, fontweight='bold', color='k',loc='right')
    cbar6.set_label('Triple CIDs', size=12, fontweight='bold', color='k',loc='right')
    
    plt.title('Exposure of compound CIDs emergence (epipelagic zone): '+str(year_investigate),fontdict={'weight':'bold','size':25})
    fig.tight_layout()
    
    ### save figures
    # plt.savefig('./epipelagic/Exposure_epipelagic_T_S_DO_'+str(year_investigate)+'.png', dpi=750, bbox_inches='tight')
    # plt.savefig('./epipelagic/Exposure_epipelagic_T_S_DO_'+str(year_investigate)+'.pdf', dpi=750, bbox_inches='tight')
    
    plt.show()


#### mesopelagic zone (200-1000m)
for year_investigate in range(2010,2011):
    print(year_investigate)

    ### load data from netCDF file, here is the example for mesopelagic zone (0-200m)
    filename='../IAP_CompoundCID_dataset/ToE_compound_'+str(year_investigate)+'.nc'
    ds_raw = xr.open_dataset(filename)
    
    Exposure_level_mesopelagic = ds_raw["Exposure_level_mesopelagic"].values.transpose()                   
    lon=ds_raw['lon'].values
    lat=ds_raw['lat'].values
    Exposure_type_mesopelagic=ds_raw["Exposure_type_mesopelagic"].values.transpose()


    exposure_T_flag=np.copy(Exposure_level_mesopelagic)
    exposure_T_flag[np.where(Exposure_type_mesopelagic!=1)]=np.nan
    exposure_S_flag=np.copy(Exposure_level_mesopelagic)
    exposure_S_flag[np.where(Exposure_type_mesopelagic!=2)]=np.nan
    exposure_DO_flag=np.copy(Exposure_level_mesopelagic)
    exposure_DO_flag[np.where(Exposure_type_mesopelagic!=3)]=np.nan
    exposure_T_S_flag=np.copy(Exposure_level_mesopelagic)
    exposure_T_S_flag[np.where(Exposure_type_mesopelagic!=4)]=np.nan
    exposure_T_DO_flag=np.copy(Exposure_level_mesopelagic)
    exposure_T_DO_flag[np.where(Exposure_type_mesopelagic!=5)]=np.nan
    exposure_T_S_DO_flag=np.copy(Exposure_level_mesopelagic)
    exposure_T_S_DO_flag[np.where(Exposure_type_mesopelagic!=6)]=np.nan
    

    #### transform the data projection central longitude
    exposure_T_flag=central_transform(exposure_T_flag)
    exposure_S_flag=central_transform(exposure_S_flag)
    exposure_DO_flag=central_transform(exposure_DO_flag)
    exposure_T_S_flag=central_transform(exposure_T_S_flag)
    exposure_T_DO_flag=central_transform(exposure_T_DO_flag)
    exposure_T_S_DO_flag=central_transform(exposure_T_S_DO_flag)
                    
    exposure_T_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_flag),np.transpose(lon))
    exposure_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_S_flag),np.transpose(lon))
    exposure_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_DO_flag),np.transpose(lon))
    exposure_T_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_S_flag),np.transpose(lon))
    exposure_T_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_DO_flag),np.transpose(lon))
    exposure_T_S_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_S_DO_flag),np.transpose(lon))


    ###### mesopelagic zone
    lon2d,lat2d=np.meshgrid(cycle_lon,lat)
    
    fig=plt.figure(figsize=(15, 23))
    plt.rcParams['font.size'] = '12'  #set global fonts
    
    box=[-180,180,-90,90]  
    scale='50m'
    xstep,ystep=30,30
    proj=ccrs.PlateCarree(central_longitude=200)
    ax2=plt.axes(projection=proj)   #create projection
    ax2.plot([-180,180],[0,0],'--',linewidth=0.6,transform=proj,color='black')
    ax2.add_feature(cfeature.LAND, facecolor='0.9') #fill land colour
    # ax2.stock_img()  
    # ax2.coastlines(scale,linewidth=0.6)  # add coastlines
    ax2.set_xticks(np.arange(box[0], box[1] + xstep, xstep), crs=proj)
    ax2.set_yticks(np.arange(box[2], box[3] + ystep, xstep), crs=proj)
    lon_formatter = LongitudeFormatter(zero_direction_label=False)  
    lat_formatter = LatitudeFormatter()
    ax2.xaxis.set_major_formatter(lon_formatter)  # format latitude and longitude
    ax2.yaxis.set_major_formatter(lat_formatter)  # format latitude and longitude
    ax2.set_extent([-180,180,-80,80],crs=proj)
    
    #### plot contour lines
    interval=np.array([0,1,2,3])
    # interval=np.arange(0,1,0.1)
    cb1=ax2.contourf(lon2d,lat2d,(exposure_T_flag),interval,cmap=new_whites,alpha=0.90,extend='both',transform=proj)   
    cb2=ax2.contourf(lon2d,lat2d,(exposure_S_flag),interval,cmap=new_whites,alpha=0.90,extend='both',transform=proj) 
    if year_investigate in [2008,2010]:
        cb3=ax2.contourf(lon2d,lat2d,(exposure_DO_flag),interval,cmap=new_whites,alpha=0.9,extend='both',transform=proj,corner_mask=False)   
    else:   
        cb3=ax2.contourf(lon2d,lat2d,(exposure_DO_flag),interval,cmap=new_whites,alpha=0.9,extend='both',transform=proj)   
    cb4=ax2.contourf(lon2d,lat2d,(exposure_T_S_flag),interval,cmap=new_dark_greens,alpha=0.8,extend='both',transform=proj)  
    cb5=ax2.contourf(lon2d,lat2d,(exposure_T_DO_flag),interval,cmap=new_dark_greens,alpha=0.8,extend='both',transform=proj)
    cb6=ax2.contourf(lon2d,lat2d,exposure_T_S_DO_flag,interval,cmap=new_purples,alpha=0.80,extend='both',transform=proj)   
    
    #### set colorbar (if you don't need the colorbar, just annotate this section)
    cbar1=fig.colorbar(cb1,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar2=fig.colorbar(cb2,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar3=fig.colorbar(cb3,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar4=fig.colorbar(cb4,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar5=fig.colorbar(cb5,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar6=fig.colorbar(cb6,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar1.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar2.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar3.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar4.set_label('Double CIDs', size=12, fontweight='bold', color='k',loc='right')
    cbar5.set_label('Double CIDs', size=12, fontweight='bold', color='k',loc='right')
    cbar6.set_label('Triple CIDs', size=12, fontweight='bold', color='k',loc='right')
    
    plt.title('Exposure of compound CIDs emergence (mesopelagic zone): '+str(year_investigate),fontdict={'weight':'bold','size':25})
    fig.tight_layout()
    
    ### save figures
    # plt.savefig('./mesopelagic/Exposure_mesopelagic_T_S_DO_'+str(year_investigate)+'.png', dpi=750, bbox_inches='tight')
    # plt.savefig('./mesopelagic/Exposure_mesopelagic_T_S_DO_'+str(year_investigate)+'.pdf', dpi=750, bbox_inches='tight')

    plt.show()

#### surface (0m)
for year_investigate in range(1980,2024):
    print(year_investigate)

    ### load data from netCDF file, here is the example for surface zone (0-200m)
    filename='../IAP_CompoundCID_dataset/ToE_compound_'+str(year_investigate)+'.nc'
    ds_raw = xr.open_dataset(filename)
    
    Exposure_level_surface = ds_raw["Exposure_level_surface"].values.transpose()                   
    lon=ds_raw['lon'].values
    lat=ds_raw['lat'].values
    Exposure_type_surface=ds_raw["Exposure_type_surface"].values.transpose()
    Exposure_pH_flag=ds_raw['Exposure_pH_level_surface'].values.transpose()
    
    exposure_T_flag=np.copy(Exposure_level_surface)
    exposure_T_flag[np.where(Exposure_type_surface!=1)]=np.nan
    exposure_S_flag=np.copy(Exposure_level_surface)
    exposure_S_flag[np.where(Exposure_type_surface!=2)]=np.nan
    exposure_DO_flag=np.copy(Exposure_level_surface)
    exposure_DO_flag[np.where(Exposure_type_surface!=3)]=np.nan
    exposure_T_S_flag=np.copy(Exposure_level_surface)
    exposure_T_S_flag[np.where(Exposure_type_surface!=4)]=np.nan
    exposure_T_DO_flag=np.copy(Exposure_level_surface)
    exposure_T_DO_flag[np.where(Exposure_type_surface!=5)]=np.nan
    exposure_T_S_DO_flag=np.copy(Exposure_level_surface)
    exposure_T_S_DO_flag[np.where(Exposure_type_surface!=6)]=np.nan
    
    #### transform the data projection central longitude
    exposure_T_flag=central_transform(exposure_T_flag)
    exposure_S_flag=central_transform(exposure_S_flag)
    exposure_DO_flag=central_transform(exposure_DO_flag)
    exposure_T_S_flag=central_transform(exposure_T_S_flag)
    exposure_T_DO_flag=central_transform(exposure_T_DO_flag)
    exposure_T_S_DO_flag=central_transform(exposure_T_S_DO_flag)
    Exposure_pH_flag=central_transform(Exposure_pH_flag)
                    
    exposure_T_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_flag),np.transpose(lon))
    exposure_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_S_flag),np.transpose(lon))
    exposure_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_DO_flag),np.transpose(lon))
    exposure_T_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_S_flag),np.transpose(lon))
    exposure_T_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_DO_flag),np.transpose(lon))
    exposure_T_S_DO_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_S_DO_flag),np.transpose(lon))
    Exposure_pH_flag, cycle_lon = add_cyclic_point(np.transpose(Exposure_pH_flag),np.transpose(lon))


    ###### surface zone
    lon2d,lat2d=np.meshgrid(cycle_lon,lat)
    
    fig=plt.figure(figsize=(15, 23))
    plt.rcParams['font.size'] = '12'  #set global fonts
    
    box=[-180,180,-90,90]  
    scale='50m'
    xstep,ystep=30,30
    proj=ccrs.PlateCarree(central_longitude=200)
    # proj=ccrs.Robinson()
    ax2=plt.axes(projection=proj)   #create projection
    ax2.plot([-180,180],[0,0],'--',linewidth=0.6,transform=proj,color='black')
    ax2.add_feature(cfeature.LAND, facecolor='0.9') #fill land colour
    # ax2.stock_img()  
    # ax2.coastlines(scale,linewidth=0.6)  # add coastlines
    ax2.set_xticks(np.arange(box[0], box[1] + xstep, xstep), crs=proj)
    ax2.set_yticks(np.arange(box[2], box[3] + ystep, xstep), crs=proj)
    lon_formatter = LongitudeFormatter(zero_direction_label=False)  
    lat_formatter = LatitudeFormatter()
    ax2.xaxis.set_major_formatter(lon_formatter)  # format latitude and longitude
    ax2.yaxis.set_major_formatter(lat_formatter)  # format latitude and longitude
    ax2.set_extent([-180,180,-80,80],crs=proj)
    
    #### plot contour lines
    interval=np.array([0,1,2,3])
    cb1=ax2.contourf(lon2d,lat2d,(exposure_T_flag),interval,cmap=new_whites,alpha=0.90,extend='both',transform=proj)   
    cb2=ax2.contourf(lon2d,lat2d,(exposure_S_flag),interval,cmap=new_whites,alpha=0.90,extend='both',transform=proj)   
    cb3=ax2.contourf(lon2d,lat2d,(exposure_DO_flag),interval,cmap=new_whites,alpha=0.9,extend='both',transform=proj)   
    cb4=ax2.contourf(lon2d,lat2d,(exposure_T_S_flag),interval,cmap=new_dark_greens,alpha=0.8,extend='both',transform=proj)  
    cb5=ax2.contourf(lon2d,lat2d,(exposure_T_DO_flag),interval,cmap=new_dark_greens,alpha=0.8,extend='both',transform=proj)
    cb6=ax2.contourf(lon2d,lat2d,exposure_T_S_DO_flag,interval,cmap=new_purples,alpha=0.80,extend='both',transform=proj)   

    Exposure_pH_flag_medium=np.copy(Exposure_pH_flag)  ###### divide before & after 1995 for pH data
    Exposure_pH_flag_medium[np.where(Exposure_pH_flag>2.5)]=np.nan
    Exposure_pH_flag_high=np.copy(Exposure_pH_flag)
    Exposure_pH_flag_high[np.where(Exposure_pH_flag<2.5)]=np.nan
    
    cb7=ax2.contourf(lon2d,lat2d,(Exposure_pH_flag_high),(3),hatches=['//'],linewidth=0.4,cmap=new_whites,alpha=0,transform=proj)
    cb8=ax2.contourf(lon2d,lat2d,(Exposure_pH_flag_medium),(2),hatches=['\\\\\\'],linewidth=1,alpha=0,cmap=new_whites,transform=proj)

    #### set colorbar (if you don't need the colorbar, just annotate this section)
    cbar1=fig.colorbar(cb1,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar2=fig.colorbar(cb2,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar3=fig.colorbar(cb3,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar4=fig.colorbar(cb4,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar5=fig.colorbar(cb5,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar6=fig.colorbar(cb6,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar1.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar2.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar3.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
    cbar4.set_label('Double CIDs', size=12, fontweight='bold', color='k',loc='right')
    cbar5.set_label('Double CIDs', size=12, fontweight='bold', color='k',loc='right')
    cbar6.set_label('Triple CIDs', size=12, fontweight='bold', color='k',loc='right')
    
    plt.title('Exposure of compound CIDs emergence (surface): '+str(year_investigate),fontdict={'weight':'bold','size':25})
    fig.tight_layout()
    
    ### save figures
    # plt.savefig('./surface/Exposure_surface_T_S_pH_'+str(year_investigate)+'.png', dpi=750, bbox_inches='tight')
    # plt.savefig('./surface/Exposure_surface_T_S_pH_'+str(year_investigate)+'.pdf', dpi=750, bbox_inches='tight')
    
    plt.show()

