# Frog Habitat & Environmental Sensitivity Analysis

## 📖 Overview
This project explores the environmental factors influencing frog presence across various habitats. Using SQL, we analyze historical sightings against weather and geographical data to determine which conditions are most critical for amphibian survival.

## 📖 Preliminary explanation of the table
* **id:** Primary Key
* **pres_abs:** Presence (1) or Absence (0) of frogs at this location.
* **northing / easting:** Geographic coordinates.
* **altitude:** Elevation of the site, m.
* **distance:** Likely distance to the nearest water source or road, m.
* **NoOfPools / NoOfSites:** Indicators of available breeding habitats.
* **avrain:** Average rainfall, mm.
* **meanmin / meanmax:** Minimum and maximum temperatures, °C.

## 🎯 Step 1: The Goal
**Primary Objective:** To perform a comprehensive Exploratory Data Analysis (EDA) on amphibian habitats to determine the most critical environmental drivers for frog presence. This analysis will:
1. Evaluate climate sensitivity (temperature and rainfall).
2. Assess the impact of physical geography (water sources and distance).
3. Build a profile of the "ideal" habitat to guide future conservation funding and fieldwork.

**Secondary Objective:** Identify anomalies in the dataset and standardize geographical metrics for accurate reporting.

## 🛠️ Tools Used
* **Database:** PostgreSQL (pgAdmin)
* **Language:** SQL (Window Functions, Aggregations, CTEs)
* **Dataset:** 212 records containing coordinate, altitude, and weather data.

## 🧹 Step 2: Data Cleaning & Setup
* Created the `forg` schema and successfully imported raw CSV data.
* Will add later

## 📊 Step 3 & 4: Analysis & Key Findings

By comparing locations with and without frogs, we discovered clear environmental preferences. 
The data reveals that physical geography plays a much larger role in frog presence than local climate.

### The Ideal Habitat Profile

| Environmental Metric | Frogs Absent (0) | Frogs Present (1) | Difference / Impact |
| :--- | :--- | :--- | :--- |
| **Distance to Water/Road (Median)** | 1500 m | 500 m | **- 1 000 m** (Highly Significant) |
| **Number of Pools (Median)** | 16 | 21 | **+ 5 pools** (Significant) |
| **Rainfall (Median)** | 149.33 mm | 148.33 mm | *Negligible* |
| **Min Temperature (Median)** | 2.83°C | 3.43°C | *+0.6°C* (Slight Preference) |
| **Max Temperature (Median)** | 13.2°C | 13.9°C | *+ 0.7°C* (Slight Preference) |

In the analysis, we noticed that the max values changed the most: the outliers mostly belong to the places, where frogs are absent. 
The values of number of pools and distance to the nearest water source affects the presence of frogs the most. 
Hence, we should focus on those values most. The others just need to be within acceptable range.

## 💡 Step 5: Recommended Actions

### The Ideal Habitat Profile

The place should be roughly as following:

| Altitude | Distance | Pools | Sites | Rain | Min Temp | Max Temp |
| 1500 m. | 500 m. | 21+ | 3+ | ~150 mm. | ~3.5°C | ~14°C |

Based on the criteria, it would roughly fall either in Cfb and Cfc (Temperate with no dry season), or in BWk (Dry arid desert cold) climates.
By combining the climate with high elevation, we get such regions:
* Nothern Spain
* South-Eastern Australia
* Tasmania
* New Zealand
* Madagascar
* South Africa
* Souther Argentina
* Northern China

## 📖 Sources
The CSV file was imported from: https://www.kaggle.com/datasets/ukveteran/frogs-data
