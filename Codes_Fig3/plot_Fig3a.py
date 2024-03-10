#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import scipy.io as scio
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from cartopy.mpl.ticker import LongitudeFormatter, LatitudeFormatter
import matplotlib.pyplot as plt
from cartopy.util import add_cyclic_point
import seaborn as sns
import cartopy
import matplotlib
from cartopy.util import add_cyclic_point

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


# In[2]:


data=scio.loadmat('./Input_data/magnitude_upper2001000_T.mat')
lon=data['lon'][:]
lat=data['lat'][:]

data=np.load('./Input_data/Magnitude_low_medium_high_flag_surface.npz')
magnitude_surface_T_flag = data['magnitude_surface_T_flag']
magnitude_surface_S_flag = data['magnitude_surface_S_flag']
magnitude_surface_pH_flag = data['magnitude_surface_pH_flag']
magnitude_overlap_surface_T_S_flag = data['magnitude_overlap_surface_T_S']

data=np.load('./Input_data/Intensity_low_medium_high_flag_surface.npz')
intensity_surface_T_flag = data['intensity_surface_T_flag']
intensity_surface_S_flag = data['intensity_surface_S_flag']
intensity_surface_pH_flag = data['intensity_surface_pH_flag']
intensity_overlap_surface_T_S_flag = data['intensity_overlap_surface_T_S']

data=np.load('./Input_data/Duration_low_medium_high_flag_surface.npz')
duration_surface_T_flag = data['duration_surface_T_flag']
duration_surface_S_flag = data['duration_surface_S_flag']
duration_surface_pH_flag = data['duration_surface_pH_flag']
duration_overlap_surface_T_S_flag = data['duration_overlap_surface_T_S_flag']


# In[3]:


### define high/medium/low exposure for each variables
exposure_T_flag = np.full((360, 180),np.nan)
exposure_S_flag = np.full((360, 180),np.nan)
exposure_pH_flag = np.full((360, 180),np.nan)
exposure_T_S_flag = np.full((360, 180),np.nan)

for i in range(360):
    for j in range(180):
        
        if(~np.isnan(magnitude_surface_T_flag[i,j])):
            data=np.array([magnitude_surface_T_flag[i,j],intensity_surface_T_flag[i,j],duration_surface_T_flag[i,j]])
            if(np.all(np.isnan(data))):
                continue
            if(np.sum(data==3)>=2): ### high exposure: at least two parameter shows 'high'=3
                exposure_T_flag[i,j]=3
            elif(np.sum(data==1)>=2):  # low exposure: at least two parameter shows 'low'
                exposure_T_flag[i,j]=1
            else:
                exposure_T_flag[i,j]=2 #other cases: medium exposure

        if(~np.isnan(magnitude_surface_S_flag[i,j])):
            data=np.array([magnitude_surface_S_flag[i,j],intensity_surface_S_flag[i,j],duration_surface_S_flag[i,j]])
            if(np.all(np.isnan(data))):
                continue
            if(np.sum(data==3)>=2):
                exposure_S_flag[i,j]=3
            elif(np.sum(data==1)>=2):  # low exposure: at least two parameter shows 'low'
                exposure_S_flag[i,j]=1
            else:
                exposure_S_flag[i,j]=2 #other cases: medium exposure

        if(~np.isnan(magnitude_surface_pH_flag[i,j])):
            data=np.array([magnitude_surface_pH_flag[i,j],intensity_surface_pH_flag[i,j],duration_surface_pH_flag[i,j]])
            if(np.all(np.isnan(data))):
                continue
            if(np.sum(data==3)>=2):
                exposure_pH_flag[i,j]=3
            elif(np.sum(data==1)>=2):  # low exposure: at least two parameter shows 'low'
                exposure_pH_flag[i,j]=1
            else:
                exposure_pH_flag[i,j]=2 #other cases: medium exposure
                
        if(~np.isnan(magnitude_overlap_surface_T_S_flag[i,j])):
            data=np.array([magnitude_overlap_surface_T_S_flag[i,j],intensity_overlap_surface_T_S_flag[i,j],duration_overlap_surface_T_S_flag[i,j]])
            if(np.all(np.isnan(data))):
                continue
            if(np.sum(data==3)>=2): #high exposure
                exposure_T_S_flag[i,j]=3
            elif(np.sum(data==1)>=2):  # low exposure: at least two parameter shows 'low'
                exposure_T_S_flag[i,j]=1
            else:
                exposure_T_S_flag[i,j]=2 #other cases: medium exposure
                
exposure_pH_flag_reduce=reduced_dimension(exposure_pH_flag)  # for plotting the figure with friendly visualization

#### transform the data projection central longitude
exposure_T_flag=central_transform(exposure_T_flag)
exposure_S_flag=central_transform(exposure_S_flag)
exposure_pH_flag=central_transform(exposure_pH_flag)
exposure_T_S_flag=central_transform(exposure_T_S_flag)
exposure_pH_flag_reduce=central_transform(exposure_pH_flag_reduce)

exposure_T_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_flag),np.transpose(lon)[0])
exposure_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_S_flag),np.transpose(lon)[0])
exposure_pH_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_pH_flag),np.transpose(lon)[0])
exposure_T_S_flag, cycle_lon = add_cyclic_point(np.transpose(exposure_T_S_flag),np.transpose(lon)[0])


# In[4]:


######### create customize colorbars  tiaosepan
white=(1,1,1)

# sns.palplot(sns.color_palette('Reds',6))
reds=sns.color_palette('Reds',6)
reds=[white,reds[0],reds[2]]
new_reds=matplotlib.colors.ListedColormap(reds,name='new_reds')  #only T (qian hong)

# sns.palplot(sns.color_palette('binary',6))
whites=sns.color_palette('binary',6)
whites=[white,whites[1],whites[3]]
new_whites=matplotlib.colors.ListedColormap(whites,name='new_whites')  # only S (hui se)
# sns.palplot(whites)

# sns.palplot(sns.color_palette('Purples_r',16))
purples=sns.color_palette('Purples_r',16)
purples=[white,purples[3],purples[0]]  
new_purples=matplotlib.colors.ListedColormap(purples,name='new_purples')  #### only DO (zi se)
# sns.palplot(purples)

# sns.palplot(sns.color_palette('YlOrBr',8))
oranges=sns.color_palette('YlOrBr',8)
oranges=[oranges[3],white]
new_oranges=matplotlib.colors.ListedColormap(oranges,name='new_oranges')  #T+S  oranges
# sns.palplot(oranges)

# sns.palplot(sns.color_palette('YlGn_r',12))
dark_green=sns.color_palette('YlGn_r',12)
dark_greens=[white,dark_green[3],dark_green[0]]  
new_dark_greens=matplotlib.colors.ListedColormap(dark_greens,name='new_dark_greens')  #T+S+DO  dark green
# sns.palplot(dark_greens)

# sns.palplot(sns.color_palette('YlGn_r',12))
light_green=sns.color_palette('YlGn_r',12)
light_green=[white,light_green[8],light_green[6]]  
new_light_greens=matplotlib.colors.ListedColormap(light_green,name='new_light_greens')  #T+DO  light green

blacks=sns.color_palette('binary',100)
blacks=[blacks[60],blacks[60]]
new_blacks=matplotlib.colors.ListedColormap(blacks,name='new_blacks')  #pH
# sns.palplot(blacks)


# In[5]:


###### plot overlap
lon2d,lat2d=np.meshgrid(cycle_lon,lat)
fig=plt.figure(figsize=(15, 23))
plt.rcParams['font.size'] = '12'  # set Font size
box=[-180,180,-90,90] 
scale='50m'
xstep,ystep=30,30
proj=ccrs.PlateCarree(central_longitude=200)
ax2=plt.axes(projection=proj)   # create map and projection
ax2.plot([-180,180],[0,0],'--',linewidth=0.6,transform=proj,color='black')
ax2.add_feature(cfeature.LAND, facecolor='0.75') 
ax2.add_feature(cfeature.COASTLINE, facecolor='0.75') 
ax2.coastlines(scale,linewidth=0.6)  # costalines
ax2.set_xticks(np.arange(box[0], box[1] + xstep, xstep), crs=proj)
ax2.set_yticks(np.arange(box[2], box[3] + ystep, xstep), crs=proj)
lon_formatter = LongitudeFormatter(zero_direction_label=False) 
lat_formatter = LatitudeFormatter()
ax2.xaxis.set_major_formatter(lon_formatter) 
ax2.yaxis.set_major_formatter(lat_formatter) 
ax2.set_extent([-180,180,-80,80],crs=proj)

#### plot contour lines
interval=np.array([0,1,2,3])
interval_pH=np.array([2,3])
cb4=ax2.contourf(lon2d,lat2d,(exposure_pH_flag),interval_pH,cmap=new_oranges,alpha=1,extend='both',transform=proj)   
cb1=ax2.contourf(lon2d,lat2d,(exposure_T_flag),interval,cmap=new_whites,alpha=0.80,extend='both',transform=proj)   
cb2=ax2.contourf(lon2d,lat2d,(exposure_S_flag),interval,cmap=new_whites,alpha=0.80,extend='both',transform=proj)   
cb3=ax2.contourf(lon2d,lat2d,(exposure_T_S_flag),interval,cmap=new_dark_greens,alpha=0.8,extend='both',transform=proj)  
row, col = np.where(exposure_pH_flag_reduce == 3)  #insignificant points
lons=lon[row]
lats=lat[col]
cb8=ax2.scatter(lons, lats, transform=proj, s=3, color='black')

#### set colorbar
cbar1=fig.colorbar(cb1,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
cbar2=fig.colorbar(cb2,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
cbar3=fig.colorbar(cb3,ax=ax2,orientation='horizontal',shrink=0.8,fraction=0.01)
cbar1.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
cbar2.set_label('Single CID', size=12, fontweight='bold', color='k',loc='right')
cbar3.set_label('Double CIDs', size=12, fontweight='bold', color='k',loc='right')
plt.title('Fig3a',fontdict={'weight':'bold','size':25})
fig.tight_layout()

# plt.savefig('./Fig3a.pdf', dpi=750, bbox_inches='tight')
plt.show()

