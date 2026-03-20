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
**Primary Objective:** Not yet determined
**Secondary Objective:** Identify anomalies in the dataset and standardize geographical metrics for accurate reporting.

## 🛠️ Tools Used
* **Database:** PostgreSQL (pgAdmin)
* **Language:** SQL (Window Functions, Aggregations, CTEs)
* **Dataset:** 212 records containing coordinate, altitude, and weather data.

## 🧹 Step 2: Data Cleaning & Setup
* Created the `forg` schema and successfully imported raw CSV data.
* Will add later

## 📊 Step 3 & 4: Analysis & Key Findings
* *(Pending analysis...)*

## 💡 Step 5: Recommended Actions
* *(Pending conclusions...)*

## 📖 Sources
The CSV file was imported from: https://www.kaggle.com/datasets/ukveteran/frogs-data
