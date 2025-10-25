#!/usr/bin/env python
# coding: utf-8
'''
    This is the demo to create the figure for the compound CID dataset
    The code is used to reproduce the Fig.2 in the Tan et al., 2025(NCC)
    Here, we use the 2023 data (ToE_compound_2023.nc) as an example. But you can change the loop to run other year data.
    Creator: Zhetao Tan (LMD/ENS)
    Email: zhetao.tan@lmd.ipsl.fr or tanzhetao19@mails.ucas.ac.cn
    Python pacakages cartopy, matplotlib, xarray, numpy seaborn are necessary
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

def reduced_dimension(variable_2D_lon_lat,times=4):
    signal_divide_noise1_reduced = variable_2D_lon_lat.copy()
    for i in range(360):
        for j in range(180):
            if i % times != 0 or j % times != 0:
                signal_divide_noise1_reduced[i, j] = np.nan
    return signal_divide_noise1_reduced

def central_transform(data2D):
    data2D_new=np.full((360,180),np.nan)
    data2D_new[180:361,:]=data2D[20:200,:]
    data2D_new[0:160,:]=data2D[200:360,:]
    data2D_new[160:180,:]=data2D[0:20,:]
    return data2D_new


######### create customize colorbars
blues=sns.color_palette('Blues_r',6)
blues=[blues[2],blues[4]]
new_blues=matplotlib.colors.ListedColormap(blues,name='new_blues')  #warming+freshening

# sns.palplot(sns.color_palette('Reds_r',6))
reds=sns.color_palette('Reds_r',6)
reds=[reds[2],reds[4]]
new_reds=matplotlib.colors.ListedColormap(reds,name='new_reds')  #only warming

# sns.palplot(sns.color_palette('YlGn_r',20))
pruples=sns.color_palette('YlGn_r',20)
pruples=[pruples[9],pruples[12]]
new_greens=matplotlib.colors.ListedColormap(pruples,name='new_greens')  #warming+salinification
# sns.palplot(pruples)

# sns.palplot(sns.color_palette('binary',100))
whites=sns.color_palette('binary',100)
whites=[whites[0],whites[0]]
new_whites=matplotlib.colors.ListedColormap(whites,name='new_whites')

# sns.palplot(sns.color_palette('YlGn_r',12))
dark_green=sns.color_palette('YlGn_r',12)
dark_greens=[dark_green[0],dark_green[3]]  #### warming+salinification+deoxygenation
new_dark_greens=matplotlib.colors.ListedColormap(dark_greens,name='new_dark_greens') 

# sns.palplot(sns.color_palette('PuOr',12))
browns=sns.color_palette('PuOr',12)
browns=[browns[0],browns[2]]  #### warming+freshening+deoxygenation
new_browns=matplotlib.colors.ListedColormap(browns,name='new_browns') 

# sns.palplot(sns.color_palette('tab20c',20))
blacks=sns.color_palette('tab20c',20)
blacks=[blacks[17],blacks[19]]  
new_blacks=matplotlib.colors.ListedColormap(blacks,name='new_blacks')  #### warming+deoxygenation

# sns.palplot(sns.color_palette('Purples_r',16))
purples=sns.color_palette('Purples_r',16)
purples=[purples[0],purples[3]]  
new_purples=matplotlib.colors.ListedColormap(purples,name='new_purples')  #### only deoxygenation

# sns.palplot(sns.color_palette('pink',20))
pinks=sns.color_palette('pink',20)
pinks=[pinks[6],pinks[10]]  
new_pinks=matplotlib.colors.ListedColormap(pinks,name='new_pinks')  #### only salinification
# sns.palplot(pinks)

# sns.palplot(sns.color_palette('bone',13))
bones=sns.color_palette('bone',13)
bones=[bones[7],bones[12]]  
new_bones=matplotlib.colors.ListedColormap(bones,name='new_bones')  #### only freshening
# sns.palplot(bones)

yellows=[(194/255,165/255,17/255),(246/255,218/255,98/255)]
new_yellows=matplotlib.colors.ListedColormap(yellows,name='new_yellows')  #### warming & salinzation & deoxygenation
# sns.palplot(yellows)

light_yellows=[(209/255,200/255,131/255),(229/255,235/255,141/255)]
new_light_yellows=matplotlib.colors.ListedColormap(light_yellows,name='new_light_yellows')  #### warming & salinzation
# sns.palplot(light_yellows)



#### plot figure of epipelagic zone
for year_investigate in range(2023,2024):
    print(year_investigate)

    ### load data from netCDF file, here is the example for epipelagic zone (0-200m)
    filename='../IAP_CompoundCID_dataset/ToE_compound_'+str(year_investigate)+'.nc'
    ds_raw = xr.open_dataset(filename)

    ToE_compound_epipelagic = ds_raw["ToE_compound_epipelagic"].values                   
    lon=ds_raw['lon'].values
    lat=ds_raw['lat'].values
    direction_epipelagic=ds_raw["ToE_compound_direction_epipelagic"].values
    significant_flag_epipelagic=ds_raw["ToE_compound_significant_flag_epipelagic"].values
    ToE_compound_epipelagic=ToE_compound_epipelagic.transpose()
    direction_epipelagic=direction_epipelagic.transpose()
    significant_flag_epipelagic=significant_flag_epipelagic.transpose()
    
    #### ToE for each CIDs
    ToE_onlyWarming=np.copy(ToE_compound_epipelagic)
    ToE_onlyWarming[np.where(direction_epipelagic!=1)]=np.nan
    ToE_onlySalin=np.copy(ToE_compound_epipelagic)
    ToE_onlySalin[np.where(direction_epipelagic!=2)]=np.nan    
    ToE_onlyFresh=np.copy(ToE_compound_epipelagic)
    ToE_onlyFresh[np.where(direction_epipelagic!=3)]=np.nan    
    ToE_onlyDeoxygen=np.copy(ToE_compound_epipelagic)
    ToE_onlyDeoxygen[np.where(direction_epipelagic!=4)]=np.nan    
    TOE_overlap_warming_salin=np.copy(ToE_compound_epipelagic)
    TOE_overlap_warming_salin[np.where(direction_epipelagic!=5)]=np.nan    
    TOE_overlap_warming_fresh=np.copy(ToE_compound_epipelagic)
    TOE_overlap_warming_fresh[np.where(direction_epipelagic!=6)]=np.nan    
    TOE_overlap_warming_deoxygen=np.copy(ToE_compound_epipelagic)
    TOE_overlap_warming_deoxygen[np.where(direction_epipelagic!=7)]=np.nan  
    TOE_overlap_warming_salin_deoxygen=np.copy(ToE_compound_epipelagic)
    TOE_overlap_warming_salin_deoxygen[np.where(direction_epipelagic!=8)]=np.nan  
    TOE_overlap_warming_fresh_deoxygen=np.copy(ToE_compound_epipelagic)
    TOE_overlap_warming_fresh_deoxygen[np.where(direction_epipelagic!=9)]=np.nan  
    
    #### transform the data projection central longitude
    TOE_overlap_warming_salin_deoxygen=central_transform(TOE_overlap_warming_salin_deoxygen)
    TOE_overlap_warming_fresh_deoxygen=central_transform(TOE_overlap_warming_fresh_deoxygen)
    TOE_overlap_warming_salin=central_transform(TOE_overlap_warming_salin)
    TOE_overlap_warming_fresh=central_transform(TOE_overlap_warming_fresh)
    ToE_onlyWarming=central_transform(ToE_onlyWarming)
    ToE_onlyDeoxygen=central_transform(ToE_onlyDeoxygen)
    TOE_overlap_warming_deoxygen=central_transform(TOE_overlap_warming_deoxygen)
    ToE_onlySalin=central_transform(ToE_onlySalin)
    ToE_onlyFresh=central_transform(ToE_onlyFresh)
    
    #### transform the data projection central longitude
    significant_flag_epipelagic=central_transform(significant_flag_epipelagic)
    
    
    TOE_overlap_warming_salin_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_salin_deoxygen),(lon))
    TOE_overlap_warming_fresh_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_fresh_deoxygen),(lon))
    TOE_overlap_warming_salin, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_salin),(lon))
    TOE_overlap_warming_fresh, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_fresh),(lon))
    ToE_onlyWarming, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyWarming),(lon))
    ToE_onlyDeoxygen, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyDeoxygen),(lon))
    TOE_overlap_warming_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_deoxygen),(lon))
    ToE_onlySalin, cycle_lon = add_cyclic_point(np.transpose(ToE_onlySalin),(lon))
    ToE_onlyFresh, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyFresh),(lon))
    
    
    ###### plot overlap
    lon2d,lat2d=np.meshgrid(cycle_lon,lat)
    
    fig=plt.figure(figsize=(15, 23))
    plt.rcParams['font.size'] = '12'  # global fonts
    
    box=[-180,180,-90,90]  #latitude and longtidue boundary
    scale='50m'
    xstep,ystep=30,30
    proj=ccrs.PlateCarree(central_longitude=200)
    # proj=ccrs.Robinson()
    ax2=plt.axes(projection=proj)   #create project
    ax2.plot([-180,180],[0,0],'--',linewidth=0.6,transform=proj,color='black')
    # land = cfeature.NaturalEarthFeature('physical','land',scale, edgecolor='face', facecolor=cfeature.COLORS['land'])
    ax2.add_feature(cfeature.LAND, facecolor='0.75') #coulour the land 
    ax2.add_feature(cfeature.COASTLINE, facecolor='0.75') #coulour the coastline 
    ax2.coastlines(scale,linewidth=0.3)  # coastline
    ax2.set_xticks(np.arange(box[0], box[1] + xstep, xstep), crs=proj)
    ax2.set_yticks(np.arange(box[2], box[3] + ystep, xstep), crs=proj)
    lon_formatter = LongitudeFormatter(zero_direction_label=False)  
    lat_formatter = LatitudeFormatter()
    ax2.xaxis.set_major_formatter(lon_formatter)  # format the latitude/longitude
    ax2.yaxis.set_major_formatter(lat_formatter)  # format the latitude/longitude
    ax2.set_extent([-180,180,-80,80],crs=proj)
    
    #### plot contour lines
    interval=np.array([1980,2000,2023])
    cb1=ax2.contourf(lon2d,lat2d,(ToE_onlyWarming),interval,cmap=new_reds,alpha=0.80,extend='both',transform=proj)   
    cb2=ax2.contourf(lon2d,lat2d,(ToE_onlyDeoxygen),interval,cmap=new_purples,alpha=0.60,extend='both',transform=proj)   
    cb3=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_salin),interval,cmap=new_light_yellows,alpha=0.8,extend='both',transform=proj)   
    cb4=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_fresh),interval,cmap=new_blues,alpha=0.8,extend='both',transform=proj)   
    cb5=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_deoxygen),interval,cmap=new_blacks,alpha=0.95,extend='both',transform=proj)
    cb6=ax2.contourf(lon2d,lat2d,TOE_overlap_warming_salin_deoxygen,interval,cmap=new_yellows,alpha=0.80,extend='both',transform=proj)   
    cb7=ax2.contourf(lon2d,lat2d,TOE_overlap_warming_fresh_deoxygen,interval,cmap=new_browns,alpha=0.80,extend='both',transform=proj)   
    cb8=ax2.contourf(lon2d,lat2d,(ToE_onlySalin),interval,cmap=new_pinks,alpha=0.80,extend='both',transform=proj)   
    cb9=ax2.contourf(lon2d,lat2d,(ToE_onlyFresh),interval,cmap=new_bones,alpha=0.80,extend='both',transform=proj)   
    
    ## putting insignificant dots
    significant_flag_epipelagic=reduced_dimension(significant_flag_epipelagic)
    row, col = np.where(significant_flag_epipelagic == 0)  #insignificant points
    lons=lon[row]
    lats=lat[col]
    cb10=ax2.scatter(lons, lats, transform=proj, s=3, color='black')
    
    
    #### set colorbar  (if you don't need the colorbar, just annotate this section
    cbar1=fig.colorbar(cb1,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar2=fig.colorbar(cb2,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar3=fig.colorbar(cb3,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar4=fig.colorbar(cb4,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar5=fig.colorbar(cb5,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar6=fig.colorbar(cb6,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar7=fig.colorbar(cb7,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar8=fig.colorbar(cb8,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar9=fig.colorbar(cb9,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar1.set_label('only warming (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar2.set_label('only deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar3.set_label('warming & salinification (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar4.set_label('warming & freshening (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar5.set_label('warming & deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar6.set_label('warming & salinification & deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar7.set_label('warming & freshening & deoxygenation(year)', size=12, fontweight='bold', color='k',loc='right')
    cbar8.set_label('only salinification (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar9.set_label('only freshening (year)', size=12, fontweight='bold', color='k',loc='right')

    
    plt.title('Epipelagic Zone ('+str(year_investigate)+')',fontdict={'weight':'bold','size':25})
    fig.tight_layout()
    
    ### save the figure
    # plt.savefig('./ToE_multiple_upper200_T_S_DO_'+str(year_investigate)+'.png', dpi=750, bbox_inches='tight')
    # plt.savefig('./ToE_multiple_upper200_T_S_DO_'+str(year_investigate)+'.pdf', dpi=750, bbox_inches='tight')
    
    plt.show()

###### mesopealgic zone （200-1000m)
for year_investigate in range(2023,2024):  
    print(year_investigate)

    ### load data from netCDF file, here is the example for mesopelagic zone (200-1000m)
    filename='../IAP_CompoundCID_dataset/ToE_compound_'+str(year_investigate)+'.nc'
    ds_raw = xr.open_dataset(filename)

    ToE_compound_mesopelagic = ds_raw["ToE_compound_mesopelagic"].values                   
    lon=ds_raw['lon'].values
    lat=ds_raw['lat'].values
    direction_mesopelagic=ds_raw["ToE_compound_direction_mesopelagic"].values
    significant_flag_mesopelagic=ds_raw["ToE_compound_significant_flag_mesopelagic"].values
    ToE_compound_mesopelagic=ToE_compound_mesopelagic.transpose()
    direction_mesopelagic=direction_mesopelagic.transpose()
    significant_flag_mesopelagic=significant_flag_mesopelagic.transpose()
    
    #### ToE for each CIDs
    ToE_onlyWarming=np.copy(ToE_compound_mesopelagic)
    ToE_onlyWarming[np.where(direction_mesopelagic!=1)]=np.nan
    ToE_onlySalin=np.copy(ToE_compound_mesopelagic)
    ToE_onlySalin[np.where(direction_mesopelagic!=2)]=np.nan    
    ToE_onlyFresh=np.copy(ToE_compound_mesopelagic)
    ToE_onlyFresh[np.where(direction_mesopelagic!=3)]=np.nan    
    ToE_onlyDeoxygen=np.copy(ToE_compound_mesopelagic)
    ToE_onlyDeoxygen[np.where(direction_mesopelagic!=4)]=np.nan    
    TOE_overlap_warming_salin=np.copy(ToE_compound_mesopelagic)
    TOE_overlap_warming_salin[np.where(direction_mesopelagic!=5)]=np.nan    
    TOE_overlap_warming_fresh=np.copy(ToE_compound_mesopelagic)
    TOE_overlap_warming_fresh[np.where(direction_mesopelagic!=6)]=np.nan    
    TOE_overlap_warming_deoxygen=np.copy(ToE_compound_mesopelagic)
    TOE_overlap_warming_deoxygen[np.where(direction_mesopelagic!=7)]=np.nan  
    TOE_overlap_warming_salin_deoxygen=np.copy(ToE_compound_mesopelagic)
    TOE_overlap_warming_salin_deoxygen[np.where(direction_mesopelagic!=8)]=np.nan  
    TOE_overlap_warming_fresh_deoxygen=np.copy(ToE_compound_mesopelagic)
    TOE_overlap_warming_fresh_deoxygen[np.where(direction_mesopelagic!=9)]=np.nan  
    
    #### transform the data projection central longitude
    TOE_overlap_warming_salin_deoxygen=central_transform(TOE_overlap_warming_salin_deoxygen)
    TOE_overlap_warming_fresh_deoxygen=central_transform(TOE_overlap_warming_fresh_deoxygen)
    TOE_overlap_warming_salin=central_transform(TOE_overlap_warming_salin)
    TOE_overlap_warming_fresh=central_transform(TOE_overlap_warming_fresh)
    ToE_onlyWarming=central_transform(ToE_onlyWarming)
    ToE_onlyDeoxygen=central_transform(ToE_onlyDeoxygen)
    TOE_overlap_warming_deoxygen=central_transform(TOE_overlap_warming_deoxygen)
    ToE_onlySalin=central_transform(ToE_onlySalin)
    ToE_onlyFresh=central_transform(ToE_onlyFresh)
    
    #### transform the data projection central longitude
    significant_flag_mesopelagic=central_transform(significant_flag_mesopelagic)
    
    
    TOE_overlap_warming_salin_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_salin_deoxygen),(lon))
    TOE_overlap_warming_fresh_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_fresh_deoxygen),(lon))
    TOE_overlap_warming_salin, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_salin),(lon))
    TOE_overlap_warming_fresh, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_fresh),(lon))
    ToE_onlyWarming, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyWarming),(lon))
    ToE_onlyDeoxygen, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyDeoxygen),(lon))
    TOE_overlap_warming_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_deoxygen),(lon))
    ToE_onlySalin, cycle_lon = add_cyclic_point(np.transpose(ToE_onlySalin),(lon))
    ToE_onlyFresh, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyFresh),(lon))
    
    
    ###### plot overlap
    lon2d,lat2d=np.meshgrid(cycle_lon,lat)
    
    fig=plt.figure(figsize=(15, 23))
    plt.rcParams['font.size'] = '12'  # global fonts
    
    box=[-180,180,-90,90]  #latitude and longtidue boundary
    scale='50m'
    xstep,ystep=30,30
    proj=ccrs.PlateCarree(central_longitude=200)
    # proj=ccrs.Robinson()
    ax2=plt.axes(projection=proj)   #create project
    ax2.plot([-180,180],[0,0],'--',linewidth=0.6,transform=proj,color='black')
    # land = cfeature.NaturalEarthFeature('physical','land',scale, edgecolor='face', facecolor=cfeature.COLORS['land'])
    ax2.add_feature(cfeature.LAND, facecolor='0.75') #coulour the land 
    ax2.add_feature(cfeature.COASTLINE, facecolor='0.75') #coulour the coastline 
    ax2.coastlines(scale,linewidth=0.3)  # coastline
    ax2.set_xticks(np.arange(box[0], box[1] + xstep, xstep), crs=proj)
    ax2.set_yticks(np.arange(box[2], box[3] + ystep, xstep), crs=proj)
    lon_formatter = LongitudeFormatter(zero_direction_label=False)  
    lat_formatter = LatitudeFormatter()
    ax2.xaxis.set_major_formatter(lon_formatter)  # format the latitude/longitude
    ax2.yaxis.set_major_formatter(lat_formatter)  # format the latitude/longitude
    ax2.set_extent([-180,180,-80,80],crs=proj)
    
    #### plot contour lines
    interval=np.array([1980,2000,2023])
    cb1=ax2.contourf(lon2d,lat2d,(ToE_onlyWarming),interval,cmap=new_reds,alpha=0.80,extend='both',transform=proj)   
    cb2=ax2.contourf(lon2d,lat2d,(ToE_onlyDeoxygen),interval,cmap=new_purples,alpha=0.60,extend='both',transform=proj)   
    cb3=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_salin),interval,cmap=new_light_yellows,alpha=0.8,extend='both',transform=proj)   
    cb4=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_fresh),interval,cmap=new_blues,alpha=0.8,extend='both',transform=proj)   
    cb5=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_deoxygen),interval,cmap=new_blacks,alpha=0.95,extend='both',transform=proj)
    cb6=ax2.contourf(lon2d,lat2d,TOE_overlap_warming_salin_deoxygen,interval,cmap=new_yellows,alpha=0.80,extend='both',transform=proj)   
    cb7=ax2.contourf(lon2d,lat2d,TOE_overlap_warming_fresh_deoxygen,interval,cmap=new_browns,alpha=0.80,extend='both',transform=proj)   
    cb8=ax2.contourf(lon2d,lat2d,(ToE_onlySalin),interval,cmap=new_pinks,alpha=0.80,extend='both',transform=proj)   
    cb9=ax2.contourf(lon2d,lat2d,(ToE_onlyFresh),interval,cmap=new_bones,alpha=0.80,extend='both',transform=proj)   
    
    ## putting insignificant dots
    significant_flag_mesopelagic=reduced_dimension(significant_flag_mesopelagic)
    row, col = np.where(significant_flag_mesopelagic == 0)  #insignificant points
    lons=lon[row]
    lats=lat[col]
    cb10=ax2.scatter(lons, lats, transform=proj, s=3, color='black')
    
    
    #### set colorbar  (if you don't need the colorbar, just annotate this section
    cbar1=fig.colorbar(cb1,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar2=fig.colorbar(cb2,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar3=fig.colorbar(cb3,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar4=fig.colorbar(cb4,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar5=fig.colorbar(cb5,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar6=fig.colorbar(cb6,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar7=fig.colorbar(cb7,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar8=fig.colorbar(cb8,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar9=fig.colorbar(cb9,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar1.set_label('only warming (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar2.set_label('only deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar3.set_label('warming & salinification (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar4.set_label('warming & freshening (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar5.set_label('warming & deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar6.set_label('warming & salinification & deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar7.set_label('warming & freshening & deoxygenation(year)', size=12, fontweight='bold', color='k',loc='right')
    cbar8.set_label('only salinification (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar9.set_label('only freshening (year)', size=12, fontweight='bold', color='k',loc='right')

    
    plt.title('Mesopelagic Zone ('+str(year_investigate)+')',fontdict={'weight':'bold','size':25})
    fig.tight_layout()

    ### save the figure
    # plt.savefig('./ToE_multiple_mesopelagic_T_S_DO_'+str(year_investigate)+'.png', dpi=750, bbox_inches='tight')
    # plt.savefig('./ToE_multiple_mesopelagic_T_S_DO_'+str(year_investigate)+'.pdf', dpi=750, bbox_inches='tight')
    
    plt.show()

###### surface （0m)
for year_investigate in range(2023,2024):  
    print(year_investigate)

    ### load data from netCDF file, here is the example for surface (0m)
    filename='../IAP_CompoundCID_dataset/ToE_compound_'+str(year_investigate)+'.nc'
    ds_raw = xr.open_dataset(filename)

    ToE_compound_surface = ds_raw["ToE_compound_surface"].values                   
    lon=ds_raw['lon'].values
    lat=ds_raw['lat'].values
    direction_surface=ds_raw["ToE_compound_direction_surface"].values
    significant_flag_surface=ds_raw["ToE_compound_significant_flag_surface"].values
    ToE_compound_surface=ToE_compound_surface.transpose()
    direction_surface=direction_surface.transpose()
    significant_flag_surface=significant_flag_surface.transpose()

    ToE_pH_surface=ds_raw["ToE_pH_surface"].values.transpose()
    
    
    #### ToE for each CIDs
    ToE_onlyWarming=np.copy(ToE_compound_surface)
    ToE_onlyWarming[np.where(direction_surface!=1)]=np.nan
    ToE_onlySalin=np.copy(ToE_compound_surface)
    ToE_onlySalin[np.where(direction_surface!=2)]=np.nan    
    ToE_onlyFresh=np.copy(ToE_compound_surface)
    ToE_onlyFresh[np.where(direction_surface!=3)]=np.nan    
    ToE_onlyDeoxygen=np.copy(ToE_compound_surface)
    ToE_onlyDeoxygen[np.where(direction_surface!=4)]=np.nan    
    TOE_overlap_warming_salin=np.copy(ToE_compound_surface)
    TOE_overlap_warming_salin[np.where(direction_surface!=5)]=np.nan    
    TOE_overlap_warming_fresh=np.copy(ToE_compound_surface)
    TOE_overlap_warming_fresh[np.where(direction_surface!=6)]=np.nan    
    TOE_overlap_warming_deoxygen=np.copy(ToE_compound_surface)
    TOE_overlap_warming_deoxygen[np.where(direction_surface!=7)]=np.nan  
    TOE_overlap_warming_salin_deoxygen=np.copy(ToE_compound_surface)
    TOE_overlap_warming_salin_deoxygen[np.where(direction_surface!=8)]=np.nan  
    TOE_overlap_warming_fresh_deoxygen=np.copy(ToE_compound_surface)
    TOE_overlap_warming_fresh_deoxygen[np.where(direction_surface!=9)]=np.nan  
    
    #### transform the data projection central longitude
    TOE_overlap_warming_salin_deoxygen=central_transform(TOE_overlap_warming_salin_deoxygen)
    TOE_overlap_warming_fresh_deoxygen=central_transform(TOE_overlap_warming_fresh_deoxygen)
    TOE_overlap_warming_salin=central_transform(TOE_overlap_warming_salin)
    TOE_overlap_warming_fresh=central_transform(TOE_overlap_warming_fresh)
    ToE_onlyWarming=central_transform(ToE_onlyWarming)
    ToE_onlyDeoxygen=central_transform(ToE_onlyDeoxygen)
    TOE_overlap_warming_deoxygen=central_transform(TOE_overlap_warming_deoxygen)
    ToE_onlySalin=central_transform(ToE_onlySalin)
    ToE_onlyFresh=central_transform(ToE_onlyFresh)
    ToE_pH_surface=central_transform(ToE_pH_surface)
    
    #### transform the data projection central longitude
    significant_flag_surface=central_transform(significant_flag_surface)
    
    TOE_overlap_warming_salin_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_salin_deoxygen),(lon))
    TOE_overlap_warming_fresh_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_fresh_deoxygen),(lon))
    TOE_overlap_warming_salin, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_salin),(lon))
    TOE_overlap_warming_fresh, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_fresh),(lon))
    ToE_onlyWarming, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyWarming),(lon))
    ToE_onlyDeoxygen, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyDeoxygen),(lon))
    TOE_overlap_warming_deoxygen, cycle_lon = add_cyclic_point(np.transpose(TOE_overlap_warming_deoxygen),(lon))
    ToE_onlySalin, cycle_lon = add_cyclic_point(np.transpose(ToE_onlySalin),(lon))
    ToE_onlyFresh, cycle_lon = add_cyclic_point(np.transpose(ToE_onlyFresh),(lon))
    ToE_pH_surface, cycle_lon = add_cyclic_point(np.transpose(ToE_pH_surface),(lon))
    
    
    ###### plot overlap
    lon2d,lat2d=np.meshgrid(cycle_lon,lat)
    
    fig=plt.figure(figsize=(15, 23))
    plt.rcParams['font.size'] = '12'  # global fonts
    
    box=[-180,180,-90,90]  #latitude and longtidue boundary
    scale='50m'
    xstep,ystep=30,30
    proj=ccrs.PlateCarree(central_longitude=200)
    # proj=ccrs.Robinson()
    ax2=plt.axes(projection=proj)   #create project
    ax2.plot([-180,180],[0,0],'--',linewidth=0.6,transform=proj,color='black')
    # land = cfeature.NaturalEarthFeature('physical','land',scale, edgecolor='face', facecolor=cfeature.COLORS['land'])
    ax2.add_feature(cfeature.LAND, facecolor='0.75') #coulour the land 
    ax2.add_feature(cfeature.COASTLINE, facecolor='0.75') #coulour the coastline 
    ax2.coastlines(scale,linewidth=0.3)  # coastline
    ax2.set_xticks(np.arange(box[0], box[1] + xstep, xstep), crs=proj)
    ax2.set_yticks(np.arange(box[2], box[3] + ystep, xstep), crs=proj)
    lon_formatter = LongitudeFormatter(zero_direction_label=False)  
    lat_formatter = LatitudeFormatter()
    ax2.xaxis.set_major_formatter(lon_formatter)  # format the latitude/longitude
    ax2.yaxis.set_major_formatter(lat_formatter)  # format the latitude/longitude
    ax2.set_extent([-180,180,-80,80],crs=proj)
    
    #### plot contour lines
    interval=np.array([1980,2000,2023])
    cb1=ax2.contourf(lon2d,lat2d,(ToE_onlyWarming),interval,cmap=new_reds,alpha=0.80,extend='both',transform=proj)   
    cb2=ax2.contourf(lon2d,lat2d,(ToE_onlyDeoxygen),interval,cmap=new_purples,alpha=0.60,extend='both',transform=proj)   
    cb3=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_salin),interval,cmap=new_light_yellows,alpha=0.8,extend='both',transform=proj)   
    cb4=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_fresh),interval,cmap=new_blues,alpha=0.8,extend='both',transform=proj)   
    cb5=ax2.contourf(lon2d,lat2d,(TOE_overlap_warming_deoxygen),interval,cmap=new_blacks,alpha=0.95,extend='both',transform=proj)
    cb6=ax2.contourf(lon2d,lat2d,TOE_overlap_warming_salin_deoxygen,interval,cmap=new_yellows,alpha=0.80,extend='both',transform=proj)   
    cb7=ax2.contourf(lon2d,lat2d,TOE_overlap_warming_fresh_deoxygen,interval,cmap=new_browns,alpha=0.80,extend='both',transform=proj)   
    cb8=ax2.contourf(lon2d,lat2d,(ToE_onlySalin),interval,cmap=new_pinks,alpha=0.80,extend='both',transform=proj)   
    cb9=ax2.contourf(lon2d,lat2d,(ToE_onlyFresh),interval,cmap=new_bones,alpha=0.80,extend='both',transform=proj)   

    ToE_pH_surface_before1995=np.copy(ToE_pH_surface)  ###### divide before & after 1995 for pH data
    ToE_pH_surface_before1995[np.where(ToE_pH_surface>=1995)]=np.nan
    ToE_pH_surface_after1995=np.copy(ToE_pH_surface)
    ToE_pH_surface_after1995[np.where(ToE_pH_surface<1995)]=np.nan

    cb1_1=ax2.contourf(lon2d,lat2d,(ToE_pH_surface_before1995),(1989,1995),hatches=['//'],linewidth=0.4,cmap=new_whites,alpha=0,transform=proj)
    cb1_2=ax2.contourf(lon2d,lat2d,(ToE_pH_surface_after1995),(1995,2000,2005,2010,2015,2022),hatches=['\\\\'],linewidth=1,alpha=0,cmap=new_whites,transform=proj)
    
    ## putting insignificant dots
    significant_flag_surface=reduced_dimension(significant_flag_surface)
    row, col = np.where(significant_flag_surface == 0)  #insignificant points
    lons=lon[row]
    lats=lat[col]
    cb10=ax2.scatter(lons, lats, transform=proj, s=3, color='black')
    
    
    #### set colorbar  (if you don't need the colorbar, just annotate this section
    cbar1=fig.colorbar(cb1,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar2=fig.colorbar(cb2,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar3=fig.colorbar(cb3,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
    cbar4=fig.colorbar(cb4,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar5=fig.colorbar(cb5,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar6=fig.colorbar(cb6,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar7=fig.colorbar(cb7,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar8=fig.colorbar(cb8,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar9=fig.colorbar(cb9,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.03)
    cbar1.set_label('only warming (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar2.set_label('only deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar3.set_label('warming & salinification (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar4.set_label('warming & freshening (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar5.set_label('warming & deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar6.set_label('warming & salinification & deoxygenation (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar7.set_label('warming & freshening & deoxygenation(year)', size=12, fontweight='bold', color='k',loc='right')
    cbar8.set_label('only salinification (year)', size=12, fontweight='bold', color='k',loc='right')
    cbar9.set_label('only freshening (year)', size=12, fontweight='bold', color='k',loc='right')

    
    plt.title('surface ('+str(year_investigate)+')',fontdict={'weight':'bold','size':25})
    fig.tight_layout()

    ### save the figure
    # plt.savefig('./ToE_multiple_surface_T_S_DO_'+str(year_investigate)+'.png', dpi=750, bbox_inches='tight')
    # plt.savefig('./ToE_multiple_surface_T_S_DO_'+str(year_investigate)+'.pdf', dpi=750, bbox_inches='tight')
    
    plt.show()
