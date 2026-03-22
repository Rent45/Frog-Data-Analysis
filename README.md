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

### 🎯 Step 1: Project Goals

* **Goal 1: Establish the Ideal Habitat Profile**  
  Identify the baseline geographical and climatic conditions of locations where frogs are currently present using descriptive statistics (medians, distributions, and outlier detection).
* **Goal 2: Assess Climate vs. Geography Drivers**  
  Evaluate climate sensitivity (temperature and rainfall) and assess the impact of physical geography (water sources and distance) using cohort analysis and rigorous hypothesis testing.
* **Goal 3: Predictive Probability Modeling**  
  By isolating the statistically significant parameters, build a predictive framework to approximate the exact probability of amphibian presence in any given new geographical location.

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

### 1. The Ideal Habitat Profile

| Environmental Metric | Frogs Absent (0) | Frogs Present (1) | Difference / Impact |
| :--- | :--- | :--- | :--- |
| **Distance to Water/Road (Median)** | 1500 m | 500 m | **- 1,000 m** (Highly Significant) |
| **Number of Pools (Median)** | 16 | 21 | **+ 5 pools** (Significant) |
| **Rainfall (Median)** | 149.33 mm | 148.33 mm | *Negligible* |
| **Min Temperature (Median)** | 2.83°C | 3.43°C | **+ 0.6°C** (Slight Preference) |
| **Max Temperature (Median)** | 13.2°C | 13.9°C | **+ 0.7°C** (Slight Preference) |

In the analysis, we noticed that the maximum values changed the most: the outliers mostly belong to the locations where frogs are absent. The number of pools and the distance to the nearest water source affect the presence of frogs the most. Hence, conservation efforts should prioritize these metrics, while ensuring climate metrics remain within acceptable ranges.


### 2. Hypothesis Testing: Climate vs. Geography
To rigorously test whether climate or physical geography (distance from the nearest water source) drives frog presence, we performed a cohort analysis in SQL and validated it with hypothesis testing in Python. 

#### A. SQL Cohort Analysis (Equal-Sized Binning)
Using SQL window functions (`NTILE`), we divided the dataset into three equal-sized cohorts (~33.3% of the data each) to eliminate sample-size bias and calculate the "Win Rate" (probability of frog presence).

* **Distance to Water/Roads (The Geography Angle)**
  * **Close (< 500m):** 69.7% presence rate
  * **Moderate (500m - 900m):** 55.8% presence rate
  * **Far (> 900m):** 16.2% presence rate
  * *Insight:* Habitats further than 900m from a primary water source see a massive, catastrophic drop in habitability.
* **Rainfall (The Climate Angle)**
  * **Low Rain (124 - 144 mm):** 36.6% presence rate
  * **Moderate Rain (144 - 153 mm):** 33.8% presence rate
  * **High Rain (153 - 198 mm):** 41.4% presence rate
  * *Insight:* While there is a slight preference for the wettest habitats, rainfall is a relatively flat line.
* **Temperature Volatility (Max Temp - Min Temp)**
  * **Highly Stable (9.4°C - 10.2°C swing):** 33.8% presence rate
  * **Moderate Swing (10.2°C - 10.6°C swing):** 40.8% presence rate
  * **Volatile (10.6°C - 11.7°C swing):** 37.1% presence rate
  * *Insight:* Frogs show remarkable resilience to temperature volatility.
* **Midpoint Temperature (The Baseline Climate)**
  * **Cold (6.8°C - 8.0°C):** 18.3% presence rate
  * **Moderate (8.0°C - 8.6°C):** 38.0% presence rate
  * **Warm (8.6°C - 10.2°C):** 55.7% presence rate
  * *Insight:* Frogs exhibit a strong, mathematically significant preference for warmer baseline temperatures, with habitability tripling as the average temperature rises from 6.8°C to 10.2°C.

#### B. Statistical Validation (Mann-Whitney U-Test)
To mathematically prove our SQL EDA, the raw, un-binned data was exported to Python. Because environmental metrics like distance are heavily skewed and not normally distributed, we utilized the non-parametric **Mann-Whitney U-test** to calculate statistical significance.

| Feature | Value of U | P-Value | Significance |
| :--- | :--- | :--- | :--- |
| **Distance** | 2316.0 | $1.03 \times 10^{-11}$ | **Highly Significant** |
| **Temp_Mid** | 3288.0 | $5.33 \times 10^{-6}$ | **Highly Significant** |
| **Altitude** | 3464.0 | $3.42 \times 10^{-5}$ | **Highly Significant** |
| **NoOfSites** | 4025.0 | $0.0044$ | **Significant** |
| **NoOfPools** | 4277.5 | $0.0238$ | **Significant** |
| **Temp_Diff** | 4910.0 | $0.426$ | *Not Significant* |
| **Av_Rain** | 5203.5 | $0.908$ | *Not Significant* |

**Conclusion:** The Python hypothesis testing perfectly mirrors the SQL cohort analysis. The Null Hypothesis is rejected for Distance and Midpoint Temperature, proving them to be the primary drivers of amphibian presence. Climate metrics like rainfall and temperature swings have no statistically significant impact.

*(Note: Visualizations of these distributions and correlations can be found in the `Outputs/2.5 Validation of Correlation and Visualisations/` directory).*

![Distance Distribution Chart](Outputs/2.5%20Validation%20of%20Correlation%20and%20Visualisations/Distribution%20of%20distance.png)

---

## 💡 Step 5: Recommended Actions

### 1. The Ideal Habitat Profile

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

### 2. Parameter Prioritization for Site Selection

When evaluating potential habitats, conservation teams do not need to find a location that perfectly matches every single metric. Instead, site selection should follow a **Three-Tier Prioritization Strategy** based on our statistical modeling:

* **Tier 1: Strict Constraints (The Non-Negotiables)**
  The statistical evidence is conclusive: habitat viability is anchored by a narrow "Survival Sweet Spot" defined by **Distance to Water**, **Midpoint Temperature**, and **Altitude**.
  * **The Proximity Threshold (Distance < 500m):** Proximity to a primary water source is the single greatest predictor of habitability. Our analysis reveals a "geographical cliff" at the 900-meter mark, where presence probability plummets. The "commute" between breeding sites and foraging grounds must be minimized.
  * **The Thermal Baseline (Midpoint Temp > 8.6°C):** While frogs show resilience to day-to-night temperature swings, the overall thermal energy of the environment must reach a specific baseline. Once the midpoint reaches > 8.6°C, presence rates nearly triple.
  * **Altitude:** There is a highly significant preference for higher elevation sites (~1,500m).
  * *The Bottom Line:* Compromising on Tier 1 variables effectively nullifies the conservation potential of the location.

* **Tier 2: Habitat Quality Optimization**
  The **Number of Pools** and **Number of Sites** are statistically significant but act as "value-add" drivers.
  * *Business Action:* If a conservation charity has limited land-purchasing funds, they can prioritize buying land that meets Tier 1 criteria. If the land lacks natural pools, they can spend their remaining budget to **manually dig additional pools**, which is a scientifically backed method to artificially boost habitability.

* **Tier 3: Flexible Variables (The Uncorrelated Factors)**
  Because our Mann-Whitney U-tests proved **Rainfall** and **Temperature Volatility** are statistically insignificant, fieldwork teams have massive geographic flexibility. We do not need to restrict our search to high-rainfall areas, nor do we need to avoid regions with volatile day-to-night temperature swings. 

By holding the strict constraints tight and loosening the flexible variables, we vastly expand our potential global search radius.

---

## 📖 Sources & Validation
To validate these analytical findings, external biodiversity databases were cross-referenced to confirm actual amphibian presence in our recommended target zones. 

* **Raw Dataset:** [Kaggle: Frogs Data](https://www.kaggle.com/datasets/ukveteran/frogs-data)
* **Validation (Tasmania):** [iNaturalist Central Highlands Check List](https://www.inaturalist.org/check_lists/51594-Central-Highlands-Check-List?view=photo)
* **Validation (Argentina - Neuquén):** [iNaturalist Neuquén Check List](https://www.inaturalist.org/check_lists/13184-Neuqu-n-Check-List)
* **Validation (Argentina - Río Negro):** [iNaturalist Río Negro Check List](https://www.inaturalist.org/check_lists/15180-R-o-Negro-Check-List)
* **Validation (New Zealand):** [iNaturalist Canterbury](https://www.inaturalist.org/places/canterbury-nz#taxon=20978) & [Mackenzie Basin](https://www.inaturalist.nz/check_lists/43235-Mackenzie-Check-List?iconic_taxon=20978) *(Note: Amphibian presence is sparser in the NZ data, requiring further on-the-ground validation).*
