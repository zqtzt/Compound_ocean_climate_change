# Codes and demos: manuscript of 'Large-scale and deep compound change of the ocean state triggered by global warming'

#### **Below are the codes to reproduce the results presented in the manuscripts entitled 'Large-scale and deep compound change of the ocean state triggered by global warming' by Tan et al. submitted to Nature**

Author: Zhetao Tan (tanzhetao19@mails.ucas.ac.cn)

Contributors: Lijing Cheng, Karina von Schuckmann, Sabrina Speich, Laurent Bopp, Jiang Zhu



## 1. System and software requirements

- MATLAB (>R2020a)
- Python 3.8 
  - numpy (version: >= 1.24.3)
  - scipy  (version: >= 1.10.1)
  - cartopy (version: >= 0.21.1)
  - matplotlib (version: >= 3.7.2)
  - seaborn (version: >= 0.12.2)



## 2. Codes for reproducing the main text figures

### 2.1 Codes for Fig. 1 (Time of emergence figures)

#### (1) Fig. 1A

Working folder: `Codes_Fig1`

Input data are stored in ` ./Codes_Fig1/ToE_data`

Please run the followings script `plot_Fig1a.m` with MATLAB.

#### (2) Fig. 1B

Working folder: `Codes_Fig1`

Input data are stored in ` ./Codes_Fig1/ToE_data`

Please run the followings script `plot_Fig1b.m` with MATLAB.

#### (3) Fig. 1C

Working folder: `Codes_Fig1`

Input data are stored in ` ./Codes_Fig1/ToE_data`

Simply run `plot_Fig1c.m` with MATLAB.

#### (4) Fig. 1D

Working folder: `Codes_Fig1`

Input data are stored in ` ./Codes_Fig1/ToE_data`

Please run the followings script `plot_Fig1d.m` with MATLAB.



### 2.2 Codes for Fig. 2 (Time of emergence figures)

#### (1) Fig. 2A

Working folder: `Codes_Fig2`

Input data are stored in ` ./Codes_Fig2/Input_data/`

Please run the followings script  `plot_Fig2a.py` or `plot_Fig2a.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (2) Fig. 2B

Working folder: `Codes_Fig2`

Input data are stored in ` ./Codes_Fig2/Input_data/`

Please run the followings script `plot_Fig2b.py` or `plot_Fig2b.ipynb` (with Jupyter Notebook) under the installation of Python 3.8 .

#### (3) Fig. 2C

Working folder: `Codes_Fig2`

Input data are stored in ` ./Codes_Fig2/Input_data/`

Please run the followings script  `plot_Fig2c.py` or `plot_Fig2c.ipynb` (with Jupyter Notebook) under the installation of Python 3.8 .



### 2.3 Codes for Fig. 3  (Exposure figures)

#### (1) Fig. 3A

Working folder: `Codes_Fig3`

Input data are stored in ` ./Codes_Fig3/Input_data/`

Please run the followings script  `plot_Fig3a.py` or `plot_Fig3a.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (2) Fig. 3B

Working folder: `Codes_Fig3`

Input data are stored in ` ./Codes_Fig3/Input_data/`

Please run the followings script  `plot_Fig3b.py` or `plot_Fig3b.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (3) Fig. 3C

Working folder: `Codes_Fig3`

Input data are stored in ` ./Codes_Fig3/Input_data/`

Please run the followings script  `plot_Fig3c.py` or `plot_Fig3c.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.



### 2.4 Codes for Fig. 5 (compound effects figures)

#### (1) Fig. 5A

Working folder: `Codes_Fig5`

Input data are stored in ` ./Codes_Fig5/Input_data/`

Simply run `plot_Fig5a.py` or `plot_Fig5a.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (2) Fig. 5B

Working folder: `Codes_Fig5`

Input data are stored in ` ./Codes_Fig5/Input_data/`

Please run the followings script  `plot_Fig5b.py` or `plot_Fig5b.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (3) Fig. 5C

Working folder: `Codes_Fig5`

Input data are stored in ` ./Codes_Fig5/Input_data`

Please run the followings script  `plot_Fig5c.m` with MATLAB.



> ##### Note: The Box 1 Figure and Fig. 4 are schematic (conceptual illustrations). The codes for these two figures can be obtained upon request
>



## 3. Demo for estimating the time of emergency (ToE)

###### Here, taking temperature emergence as an example, we provide the codes to calculate its individual ToE, as presented in the manuscript.

We used the IAPv3 temperature 1-degree gridded product (the analysis mean field) as the input data, which can be assessed via  http://www.ocean.iap.ac.cn/

Working folder: `demo_individual_ToE`

Input data are stored in ` ./demo_individual_ToE/Input_data`

Some internal functions for used are available in  ` ./demo_individual_ToE/functions` 

#### **Running order**

1. `N01_cal_baseline.m`: This is to calculate the 1960-1979 climatology (baseline). Here, the input data is the IAPv3 1-degree grid dataset from 1960 to 2021 (monthly netCDF format).  **Due to GitHub's data storage limitation, you should download the netCDF data before running the code via  http://www.ocean.iap.ac.cn/.**
2. `N02_anomaly_monthly.m`: This is to calculate the anomaly field relative to 1960-1979 baseline
3. `N03_gloal_avg_temp.m`: This is to calculate the global temperature 3-D average and its time series
4. `N04_global_singal_noise.m`: This is to calculate the global average signal (G(t)) and noise
5. `N05_local_singal_noise.m`: This is to calculate the local signal and noise in each 1-degree box at each standard depth level following Hawkins et al., 2020
6. `N06_ToE_calculate.m`: This is to calculate the temperature ToE in each 1-degree box (each standard depth level, epipelagic zone, and mesopelagic zone). We also provide some codes for plotting the spatial ToE maps.
7. `N07_ToE_depth_percentage.m`: This is to calculate the global percentage of temperature emergence as a function of depth
8. `N08_ToE_year_percentage_upper2001000.m`: This is to calculate the global percentage of temperature emergence as a function of year

> ###### **Note: If you don't download the full IAP dataset, you can run this demo from the Step 6.**



## License

These codes are licensed under the [MIT License](https://github.com/zqtzt/Compound_ocean_climate_change?tab=MIT-1-ov-file#readme)



## Questions and feedbacks

If you have any questions/suggestions about this manuscript, or if you find some bugs in this demo, please feel free and do not hesitate to tell us via:

- [Create an issue](https://github.com/zqtzt/Compound_ocean_climate_change/issues) in the Github community
- [Pull requests](https://github.com/zqtzt/Compound_ocean_climate_change/pulls) your debugged/improved codes in the Github community
- Send an email to us: [tanzhetao19@mails.ucas.ac.cn](mailto:tanzhetao19@mails.ucas.ac.cn) or [chenglij@mail.iap.ac.cn](mailto:chenglij@mail.iap.ac.cn)



## Update logs

11/03/2024: The initialization to upload the reproduction and demo codes (version 0.1.0)
