# Datasets, Codes, and Demos: paper of 'Observed large-scale and deep-reaching compound ocean state changes over the past 60 years'

#### **Below are the codes to reproduce the results presented in the paper entitled 'Observed large-scale and deep-reaching compound ocean state changes over the past 60 years' by Tan et al. 2025 published in *Nature Climate Change***. [https://www.nature.com/articles/s41558-025-02484-x](https://www.nature.com/articles/s41558-025-02484-x)

Author: Zhetao Tan (tanzhetao19@mails.ucas.ac.cn; zhetao.tan@lmd.ipsl.fr)

Contributors: Lijing Cheng, Karina von Schuckmann, Sabrina Speich, Laurent Bopp, Jiang Zhu



🎥 **Dashboard**: A dashboard is available [here](http://www.ocean.iap.ac.cn/pages/dataV/dataV.html?navAnchor=dataV) to <span style="color:#058120;">**enable the climate scientists and climate policy-makers**</span> to check the dynamic evolution (since 1985) and current state of the simultaneous change in the global ocean.

**▶️ Video**: an evolution of the <span style="color:#058120;">**changing compound CIDs (ToE and its exposure) from 1980 to 2023**</span> can be reached [here](http://www.ocean.iap.ac.cn/ftp/cheng/Compound_CIDs/dynamic_video/) 

♻️ More information and useful materials could be found on my personal [webpage](https://zqtzt.github.io/)

# 1. Dataset: IAP Compound CIDs Dataset

## 1.1 Introduction

**The IAP Ocean Compound Climatic impact-drivers (CIDs) Monitoring Dataset** integrates global, three-dimensional observations of physical and biogeochemical variables to capture long-term, compound ocean state changes with global coverage (1-degree) from the surface to mesopelagic zone. This dataset, combining time-of-emergence (ToE) analyses and exposure metrics from 1960 to 2023 for the concurrent change of multiple Essential Climate Variables (ECVs) includes ocean temperature, salinity, dissolved oxygen, and surface pH, provides a robust foundation for assessing the interplay between individual and compound CIDs. This dataset, together with the analysis framework shown in the corresponding paper, can server as a science-policy interface tool and indicators to facilitate the integration of our understanding of oceanic environmental change with broader knowledge of the compound impacts on the ocean and human societies.

## 1.2 Data Information

- Format: netCDF 

- Time: 1980 – onward 

- Temporal resolution: Annual 

- Spatial resolution: 1-degree

-  Spatial coverage: Global ocean 

- Vertical resolution: surface, epipelagic zone (0-200m), mesopelagic zone (200-1000m).

- Version: v0.1 (an interim version)

**This dataset is stored at `./IAP_CompoundCID_dataset/`. You can also download the dataset from IAP data protocol: [http://www.ocean.iap.ac.cn/ftp/cheng/Compound_CIDs/](http://www.ocean.iap.ac.cn/ftp/cheng/Compound_CIDs/)**



## 1.3 Video of the evolution of compound ocean state change 

We also provide **a dynamic view** of the compound climatic impact-drivers (Temperature, salinity, dissolved oxygen, and surface pH) from 1980 to 2023, which are represented by the compound time-of-emergence and its exposure. You can find the evolution video in this folder `./dynamic_video/` or via [http://www.ocean.iap.ac.cn/ftp/cheng/Compound_CIDs/dynamic_video/](http://www.ocean.iap.ac.cn/ftp/cheng/Compound_CIDs/dynamic_video/)

This video is produced by using the codes in `Section 2.3` and `Section 2.4`

We also provide **a dashboard to show the dynamic evolution** (since 1985) of compound CIDs here: [http://www.ocean.iap.ac.cn/pages/dataV/dataV.html?navAnchor=dataV](http://www.ocean.iap.ac.cn/pages/dataV/dataV.html?navAnchor=dataV)

# 2. Codes to reproduce the figures

## 2.1 System and software requirements

- MATLAB (>R2020a)
- Python >3.9
  - numpy (version: >= 1.24.3)
  - scipy  (version: >= 1.10.1)
  - cartopy (version: >= 0.21.1)
  - matplotlib (version: >= 3.7.2)
  - seaborn (version: >= 0.12.2)

## 2.2 Codes for Fig. 1a-c (Time of emergence figures)

#### (1) Fig. 1A

Working folder: `Codes_Fig1`

Input data are stored in ` ./Codes_Fig1/ToE_data`

Please run the following script `plot_Fig1a.m` with MATLAB.

#### (2) Fig. 1B

Working folder: `Codes_Fig1`

Input data are stored in ` ./Codes_Fig1/ToE_data`

Please run the followings script `plot_Fig1b.m` with MATLAB.

#### (3) Fig. 1C

Working folder: `Codes_Fig1`

Input data are stored in ` ./Codes_Fig1/ToE_data`

Simply run `plot_Fig1c.m` with MATLAB.

## 2.3 Codes for Fig. 2 (Time of emergence figures)

Working folder: `Codes_Fig2`

Input data are stored in ` ./Codes_Fig2/Demo_Fig2_compound_emergence.py/`

You can also run the script `Demo_Fig2_compound_emergence.ipynb` with Jupyter Notebook under the installation of Python 3.8. This will have the same output as *.py file.

## 2.4 Codes for Fig. 3  (Exposure figures)

Working folder: `Codes_Fig3`

Input data are stored in ` ./Codes_Fig2/Demo_Fig3_exposure/`

You can also run the script `Demo_Fig3_exposure.ipynb` with Jupyter Notebook under the installation of Python 3.8. This will have the same output as *.py file.

## 2.5 Codes for Fig. 5 (compound effects figures)

#### (1) Fig. 5A

Working folder: `Codes_Fig5`

Input data are stored in ` ./Codes_Fig5/Input_data/`

Simply run `plot_Fig5a.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (2) Fig. 5B

Working folder: `Codes_Fig5`

Input data are stored in ` ./Codes_Fig5/Input_data/`

Please run the `plot_Fig5b.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (3) Fig. 5C

Working folder: `Codes_Fig5`

Please run the following script `plot_Fig5c_HighSea.py` .



> ##### Note: The Box 1 Figure and Fig. 4 are schematic (conceptual illustrations). The codes for these two figures can be obtained upon request.
>



# 3. Demos

3.1. Demo for estimating the time of emergency (ToE) for individual climatic impact-drivers

###### Here, taking temperature emergence as an example, we provide the codes to calculate its individual ToE, as presented in the manuscript.

We used the IAPv3 temperature 1-degree gridded product (the analysis mean field) as the input data, which can be assessed via  [http://www.ocean.iap.ac.cn/ftp/cheng/CZ16_v3_IAP_Temperature_gridded_1month_netcdf/](http://www.ocean.iap.ac.cn/ftp/cheng/CZ16_v3_IAP_Temperature_gridded_1month_netcdf/)

Working folder: `demo_individual_ToE`

Input data are stored in ` ./demo_individual_ToE/Input_data`

Some internal functions for used are available in  ` ./demo_individual_ToE/functions` 

#### **Running order**

1. `N01_cal_baseline.m`: This is to calculate the 1960-1989 climatology (baseline). Here, the input data is the IAPv3 1-degree grid dataset from 1960 to 2023 (monthly netCDF format).  **Due to GitHub's data storage limitation, you should download the netCDF data before running the code via  http://www.ocean.iap.ac.cn/ftp/cheng/CZ16_v3_IAP_Temperature_gridded_1month_netcdf/
2. `N02_anomaly_monthly.m`: This is to calculate the anomaly field relative to 1960-1989 baseline
3. `N03_gloal_avg_temp.m`: This is to calculate the global temperature 3-D average and its time series
4. `N04_global_singal_noise.m`: This is to calculate the global average signal (G(t)) and noise
5. `N05_local_singal_noise.m`: This is to calculate the local signal and noise in each 1-degree box at each standard depth level following Hawkins et al., 2020
6. `N06_ToE_calculate.m`: This is to calculate the temperature ToE in each 1-degree box (each standard depth level, epipelagic zone, and mesopelagic zone). We also provide some codes for plotting the spatial ToE maps.
7. `N07_ToE_depth_percentage.m`: This is to calculate the global percentage of temperature emergence as a function of depth
8. `N08_ToE_year_percentage_upper2001000.m`: This is to calculate the global percentage of temperature emergence as a function of year

> ###### **Note: If you don't download the full IAP dataset, you can run this demo from the Step 6.**



# Citation

**Tan Z.**, K. von Schuckmann, S. Speich, L. Bopp, J. Zhu, L. Cheng*., 2025: Observed large-scale and deep-reaching compound ocean state changes over the past 60 years. *Nature Climate Change*.



# License

These codes are licensed under the [MIT License](https://github.com/zqtzt/Compound_ocean_climate_change?tab=MIT-1-ov-file#readme)



# Questions and feedbacks

If you have any questions/suggestions about this manuscript, or if you find some bugs in this demo, please feel free and do not hesitate to tell us via:

- [Create an issue](https://github.com/zqtzt/Compound_ocean_climate_change/issues) in the Github community
- [Pull requests](https://github.com/zqtzt/Compound_ocean_climate_change/pulls) your debugged/improved codes in the Github community
- Send an email to us: [tanzhetao19@mails.ucas.ac.cn](mailto:tanzhetao19@mails.ucas.ac.cn) or [zhetao.tan@lmd.ipsl.fr](mailto:zhetao.tan@lmd.ipsl.fr)
- More information could be found in Zhetao Tan's webpage: [https://zqtzt.github.io/](https://zqtzt.github.io/)



# Update logs

11/03/2024: The initialization to upload the reproduction and demo codes (version 0.1.0)

25/11/2025: Updated version (version 1.0.0)
