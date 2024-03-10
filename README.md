# Codes and demos: manuscript of 'Large-scale and deep compound change of the ocean state triggered by global warming'

##### **Below are the codes to reproduce the results presented in the manuscripts of 'Large-scale and deep compound change of the ocean state triggered by global warming' by Tan et al.**

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



## 2. Codes for reproduce the main text figures

### 2.1 Codes for Fig. 1 (Time of emergence figures)

#### (1) Fig. 1A

Working folder: `Codes_Fig1`

Input data are storaged in ` ./Codes_Fig1/ToE_data`

Simply run `plot_Fig1a.m` with MATLAB.

#### (2) Fig. 1B

Working folder: `Codes_Fig1`

Input data are storaged in ` ./Codes_Fig1/ToE_data`

Simply run `plot_Fig1b.m` with MATLAB.

#### (3) Fig. 1C

Working folder: `Codes_Fig1`

Input data are storaged in ` ./Codes_Fig1/ToE_data`

Simply run `plot_Fig1c.m` with MATLAB.

#### (4) Fig. 1D

Working folder: `Codes_Fig1`

Input data are storaged in ` ./Codes_Fig1/ToE_data`

Simply run `plot_Fig1d.m` with MATLAB.



### 2.2 Codes for Fig. 2 (Time of emergence figures)

#### (1) Fig. 2A

Working folder: `Codes_Fig2`

Input data are storaged in ` ./Codes_Fig2/Input_data/`

Simply run `plot_Fig2a.py` or `plot_Fig2a.ipynb` (with Jupyter Notebook) under the installation of Python 3.8 .

#### (2) Fig. 2B

Working folder: `Codes_Fig2`

Input data are storaged in ` ./Codes_Fig2/Input_data/`

Simply run `plot_Fig2b.py` or `plot_Fig2b.ipynb` (with Jupyter Notebook) under the installation of Python 3.8 .

#### (3) Fig. 2C

Working folder: `Codes_Fig2`

Input data are storaged in ` ./Codes_Fig2/Input_data/`

Simply run `plot_Fig2c.py` or `plot_Fig2c.ipynb` (with Jupyter Notebook) under the installation of Python 3.8 .



### 2.3 Codes for Fig. 3  (Exposure figures)

#### (1) Fig. 3A

Working folder: `Codes_Fig3`

Input data are storaged in ` ./Codes_Fig3/Input_data/`

Simply run `plot_Fig3a.py` or `plot_Fig3a.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (2) Fig. 3B

Working folder: `Codes_Fig3`

Input data are storaged in ` ./Codes_Fig3/Input_data/`

Simply run `plot_Fig3b.py` or `plot_Fig3b.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (3) Fig. 3C

Working folder: `Codes_Fig3`

Input data are storaged in ` ./Codes_Fig3/Input_data/`

Simply run `plot_Fig3c.py` or `plot_Fig3c.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.



### 2.4 Codes for Fig. 5 (compound effects)

#### (1) Fig. 5A

Working folder: `Codes_Fig5`

Input data are storaged in ` ./Codes_Fig5/Input_data/`

Simply run `plot_Fig5a.py` or `plot_Fig5a.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (2) Fig. 5B

Working folder: `Codes_Fig5`

Input data are storaged in ` ./Codes_Fig5/Input_data/`

Simply run `plot_Fig5b.py` or `plot_Fig5b.ipynb` (with Jupyter Notebook) under the installation of Python 3.8.

#### (3) Fig. 5C

Working folder: `Codes_Fig5`

Input data are storaged in ` ./Codes_Fig5/Input_data`

Simply run `plot_Fig5c.m` with MATLAB.



###### Note: The Box 1 Figure and Fig. 4 are the schematic illustration or the conceptual illustration. The codes for these two figures can be upon request to the author.



## 3. Demo for calculating the time of emergency (ToE)

Here, take temperature emergence as a demo, we provide some codes to calculate its individual ToE, as presented in the manuscript.

We used the IAP temperature 1-degree gridded product (the analysis mean field) as the input data, which can be assessed via http://dx.doi.org/10.12157/IOCAS.20240117.002 or http://www.ocean.iap.ac.cn/





## License

These codes are licensed under the [MIT License](https://github.com/zqtzt/Compound_ocean_climate_change?tab=MIT-1-ov-file#readme)

## Questions and feedbacks

If you have any questions/suggestions about this manuscript, or if you find some bugs in this demo, please feel free and do not hesitate to tell us via:

- [Create an issue](https://github.com/zqtzt/Compound_ocean_climate_change/issues) in the Github community
- [Pull requests](https://github.com/zqtzt/Compound_ocean_climate_change/pulls) your debugged/improved codes in the Github community
- Send an email to us: [tanzhetao19@mails.ucas.ac.cn](mailto:tanzhetao19@mails.ucas.ac.cn) or [chenglij@mail.iap.ac.cn](mailto:chenglij@mail.iap.ac.cn)



## Update logs

11/03/2024: The initialization to upload the reproduction and demo codes (version 0.1.0)
