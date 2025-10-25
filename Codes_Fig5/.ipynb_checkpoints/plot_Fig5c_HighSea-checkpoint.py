#!/usr/bin/env python
# coding: utf-8

from __future__ import annotations

import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

# data
surface_ToE_median = np.array([0.5786, 0.0943, np.nan, 0.9995, 0.0543, np.nan, np.nan]) * 100
upper200_ToE_median = np.array([0.5423, 0.2771, 0.4039, np.nan, 0.1883, 0.2204, 0.0946]) * 100
upper200_1000_ToE_median = np.array([0.6155, 0.4538, 0.5789, np.nan, 0.2965, 0.3839, 0.2016]) * 100

surface_ToE_975 = np.array([0.6213, 0.1508, np.nan, 1.0000, 0.0940, np.nan, np.nan]) * 100
upper200_ToE_975 = np.array([0.5933, 0.3558, 0.4502, np.nan, 0.2483, 0.2532, 0.1246]) * 100
upper200_1000_ToE_975 = np.array([0.6565, 0.6566, 0.6212, np.nan, 0.4216, 0.4154, 0.2801]) * 100

surface_ToE_25 = np.array([0.5132, 0.0458, np.nan, 0.9990, 0.0169, np.nan, np.nan]) * 100
upper200_ToE_25 = np.array([0.4819, 0.1513, 0.3725, np.nan, 0.1158, 0.1925, 0.0613]) * 100
upper200_1000_ToE_25 = np.array([0.5639, 0.2600, 0.5357, np.nan, 0.1896, 0.3612, 0.1228]) * 100

names = ['T','S','DO','pH','T&S','T&DO','T&S&DO']


x = np.arange(len(names))
width = 0.23

fig, ax = plt.subplots(figsize=(10, 5), dpi=150)

bars1 = ax.bar(x - width, surface_ToE_median, width, label='Surface', linewidth=1.5)
bars2 = ax.bar(x, upper200_ToE_median, width, label='Epipelagic Zone (0–200 m)', linewidth=1.5)
bars3 = ax.bar(x + width, upper200_1000_ToE_median, width, label='Mesopelagic Zone (200–1000 m)', linewidth=1.5)


def add_errorbar(xpos: np.ndarray, y_med: np.ndarray, y_p25: np.ndarray, y_p975: np.ndarray):
    err_color = (0.25, 0.25, 0.25)  # 深灰
    yerr_lower = y_med - y_p25
    yerr_upper = y_p975 - y_med
    yerr = np.vstack([yerr_lower, yerr_upper])
    ax.errorbar(
        xpos, y_med,
        yerr=yerr,
        fmt='o',                
        linewidth=1,
        elinewidth=1,
        capsize=3,
        color=err_color,         
        ecolor=err_color,        
        markerfacecolor='white', 
        markersize=4
    )
    
add_errorbar(x - width, surface_ToE_median, surface_ToE_25, surface_ToE_975)
add_errorbar(x, upper200_ToE_median, upper200_ToE_25, upper200_ToE_975)
add_errorbar(x + width, upper200_1000_ToE_median, upper200_1000_ToE_25, upper200_1000_ToE_975)

ax.set_xticks(x)
ax.set_xticklabels(names)
ax.set_ylabel('High Seas Emergence Area Covered (%)')
ax.set_title('Percentage of emergence in the High Sea (until Dec 2023)')
ax.legend()
ax.grid(True, axis='y', linestyle='--', alpha=0.4)
fig.tight_layout()


# fig.savefig('./bar_percentage_new.pdf')
# fig.savefig('./bar_percentage_new.png')

plt.show()

