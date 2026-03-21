# Frog Habitat & Environmental Sensitivity Analysis

## 📖 Overview
This project explores the environmental factors influencing frog presence across various habitats. Using SQL, we analyze historical sightings against weather and geographical data to determine which conditions are most critical for amphibian survival.

## 📖 Preliminary explanation of the table
* **id:** Primary Key
* **pres_abs:** Presence (1) or Absence (0) of frogs at this location.
* **northing / easting:** Geographic coordinates (but not latitude and longitude).
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
* The data was already clean, so no changes were made.

## 📊 Step 3 & 4: Analysis & Key Findings

By comparing locations with and without frogs, we discovered clear environmental preferences. The data reveals that physical geography plays a much larger role in frog presence than local climate.

### The Ideal Habitat Profile

| Environmental Metric | Frogs Absent (0) | Frogs Present (1) | Difference / Impact |
| :--- | :--- | :--- | :--- |
| **Distance to Water/Road (Median)** | 1500 m | 500 m | **- 1,000 m** (Highly Significant) |
| **Number of Pools (Median)** | 16 | 21 | **+ 5 pools** (Significant) |
| **Rainfall (Median)** | 149.33 mm | 148.33 mm | *Negligible* |
| **Min Temperature (Median)** | 2.83°C | 3.43°C | **+ 0.6°C** (Slight Preference) |
| **Max Temperature (Median)** | 13.2°C | 13.9°C | **+ 0.7°C** (Slight Preference) |

In the analysis, we noticed that the maximum values changed the most: the outliers mostly belong to the locations where frogs are absent. The number of pools and the distance to the nearest water source affect the presence of frogs the most. Hence, conservation efforts should prioritize these metrics, while ensuring climate metrics remain within acceptable ranges.

---

## 💡 Step 5: Recommended Actions

Based on our analysis, the ideal location for future field expeditions should look roughly like this:

| Altitude | Distance | Pools | Sites | Rain | Min Temp | Max Temp |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1,500 m | 500 m | 21+ | 3+ | ~150 mm | ~3.5°C | ~14°C |

Based on these criteria, the ideal habitat falls squarely into **Cfb/Cfc** (Temperate with no dry season) or **BWk** (Dry arid desert cold) climates. Combining this specific climate profile with high elevation yields the following global regions:
* Northern Spain
* South-Eastern Australia
* Tasmania
* New Zealand
* Madagascar
* South Africa
* Southern Argentina
* Northern China

By further filtering for locations with high concentrations of water pools (specifically lake districts), we narrow the optimal search areas down to three prime locations:
1. **The Central Highlands of Tasmania**
2. **The Patagonian Andean Lake District** (Neuquén & Río Negro, Argentina)
3. **The South Island High Country** (Canterbury / Mackenzie Basin, New Zealand)

*(Note: Reference images from Google Maps of these precise locations can be found in the `outputs/1.` folder).*

---

## 📖 Sources & Validation
To validate these analytical findings, external biodiversity databases were cross-referenced to confirm actual amphibian presence in our recommended target zones. 

* **Raw Dataset:** [Kaggle: Frogs Data](https://www.kaggle.com/datasets/ukveteran/frogs-data)
* **Validation (Tasmania):** [iNaturalist Central Highlands Check List](https://www.inaturalist.org/check_lists/51594-Central-Highlands-Check-List?view=photo)
* **Validation (Argentina - Neuquén):** [iNaturalist Neuquén Check List](https://www.inaturalist.org/check_lists/13184-Neuqu-n-Check-List)
* **Validation (Argentina - Río Negro):** [iNaturalist Río Negro Check List](https://www.inaturalist.org/check_lists/15180-R-o-Negro-Check-List)
* **Validation (New Zealand):** [iNaturalist Canterbury](https://www.inaturalist.org/places/canterbury-nz#taxon=20978) & [Mackenzie Basin](https://www.inaturalist.nz/check_lists/43235-Mackenzie-Check-List?iconic_taxon=20978) *(Note: Amphibian presence is sparser in the NZ data, requiring further on-the-ground validation).*
