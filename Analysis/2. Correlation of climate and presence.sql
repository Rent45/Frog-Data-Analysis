/*
id: Primary Key
pres_abs: Presence (1) or Absence (0) of frogs at this location.
northing / easting: Geographic coordinates.
altitude: Elevation of the site, m.
distance: Likely distance to the nearest water source or road, m.
NoOfPools / NoOfSites: Indicators of available breeding habitats.
avrain: Average rainfall, mm.
meanmin / meanmax: Minimum and maximum temperatures, °C.
*/

--Checking what a row looks like--
SELECT * FROM forgs
LIMIT 1;

--Counting the number of entries--
SELECT COUNT(*) FROM forgs;

--Climate sensitivity of frogs (Cohort Analysis)--

--Rainfall--
WITH PrecipitationTerciles AS (
    SELECT 
        pres_abs,
        avrain,
        NTILE(3) OVER (ORDER BY avrain) AS rain_bucket
    FROM forgs
)
SELECT 
    rain_bucket,
    ROUND(MIN(avrain), 2) AS min_rain_mm,
    ROUND(MAX(avrain), 2) AS max_rain_mm,
    COUNT(*) AS total_locations,
    ROUND(AVG(pres_abs) * 100, 2) AS frog_win_rate_pct,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM forgs), 2) AS pct_of_all_data
FROM PrecipitationTerciles
GROUP BY rain_bucket
ORDER BY rain_bucket;
--It oscillates with a slight preference for the wetter points.--

--Distance to a water source--
WITH DistanceTerciles AS (
    SELECT 
        pres_abs,
        distance,
        NTILE(3) OVER (ORDER BY distance) AS distance_bucket
    FROM forgs
)
SELECT 
    distance_bucket,
    MIN(distance) AS min_distance_m,
    MAX(distance) AS max_distance_m,
    COUNT(*) AS total_locations,
    ROUND(AVG(pres_abs) * 100, 2) AS frog_win_rate_pct,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM forgs), 2) AS pct_of_all_data
FROM DistanceTerciles
GROUP BY distance_bucket
ORDER BY distance_bucket;
--There is a significant drop in presence as the distance increases. The values should be negatively correlated--

--Difference of temperatures (meanmax-meanmin)--
WITH TempSwingTerciles AS (
    SELECT 
        pres_abs,
        ROUND((meanmax - meanmin), 2) AS temp_swing,
        NTILE(3) OVER (ORDER BY (meanmax - meanmin)) AS swing_bucket
    FROM forgs
)
SELECT 
    swing_bucket,
    MIN(temp_swing) AS min_swing_c,
    MAX(temp_swing) AS max_swing_c,
    COUNT(*) AS total_locations,
    ROUND(AVG(pres_abs) * 100, 2) AS frog_win_rate_pct,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM forgs), 2) AS pct_of_all_data
FROM TempSwingTerciles
GROUP BY swing_bucket
ORDER BY swing_bucket;
--It oscillates with a slight preference for the bigger swings.--

--Middle of temperatures (meanmax+meanmin)/2--
WITH TempMidTerciles AS (
    SELECT 
        pres_abs,
        ROUND((meanmax+meanmin)/2, 2) AS temp_mid,
        NTILE(3) OVER (ORDER BY (meanmax+meanmin)/2) AS mid_bucket
    FROM forgs
)
SELECT 
    mid_bucket,
    MIN(temp_mid) AS min_mid_c,
    MAX(temp_mid) AS max_mid_c,
    COUNT(*) AS total_locations,
    ROUND(AVG(pres_abs) * 100, 2) AS frog_win_rate_pct,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM forgs), 2) AS pct_of_all_data
FROM TempMidTerciles
GROUP BY mid_bucket
ORDER BY mid_bucket;
--There seems to be a positive correlation between the middle of temperature interval and frog presence--