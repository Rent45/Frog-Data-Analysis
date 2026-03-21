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



--EXPLORING THE DATA--

--Checking percentage--
SELECT pres_abs, 100.0*COUNT(*)/(SELECT COUNT(*) FROM forgs) AS percentage
FROM forgs
GROUP BY pres_abs; --60/40 is good--

--Selecting only coordinates--
SELECT northing, easting FROM forgs;

--Checking the Measures of central tendency--
SELECT 
    'Min' AS statistic, 
    MIN(altitude) AS altitude,
    MIN(distance) AS distance, 
    MIN(no_of_pools) AS pools, 
    MIN(no_of_sites) AS sites, 
    ROUND(MIN(avrain)::NUMERIC, 2) AS rain, 
    ROUND(MIN(meanmin)::NUMERIC, 2) AS temp_min,
    MIN(meanmax) AS temp_max
FROM forgs 

UNION ALL 

SELECT 
    'Mean', 
    ROUND(AVG(altitude)::NUMERIC, 2),
    ROUND(AVG(distance)::NUMERIC, 2), 
    ROUND(AVG(no_of_pools)::NUMERIC, 2), 
    ROUND(AVG(no_of_sites)::NUMERIC, 2), 
    ROUND(AVG(avrain)::NUMERIC, 2), 
    ROUND(AVG(meanmin)::NUMERIC, 2),
    ROUND(AVG(meanmax)::NUMERIC, 2)
FROM forgs

UNION ALL 

SELECT 
    'Median', 
    (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY altitude))::NUMERIC,
    (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY distance))::NUMERIC,
    (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY no_of_pools))::NUMERIC,
    (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY no_of_sites))::NUMERIC,
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY avrain))::NUMERIC, 2),
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY meanmin))::NUMERIC, 2),
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY meanmax))::NUMERIC, 2)
FROM forgs

UNION ALL

SELECT 
    'Max', 
    MAX(altitude),
    MAX(distance), 
    MAX(no_of_pools), 
    MAX(no_of_sites), 
    ROUND(MAX(avrain)::NUMERIC, 2),
    ROUND(MAX(meanmin)::NUMERIC, 2),
    ROUND(MAX(meanmax)::NUMERIC, 2)
FROM forgs;
/*Since the median and mean of distance and number of pools are far apart, 
there are some outliers at the higher end of the values.
The max value is quite high, too.
It is alright for the distance, but the pools may be skewed.*/


--Comparing the Measures of central tendency of present and absent frogs--
SELECT
	pres_abs,
    'Min' AS statistic, 
    MIN(altitude) AS altitude, 
    MIN(distance) AS distance, 
    MIN(no_of_pools) AS pools, 
    MIN(no_of_sites) AS sites, 
    ROUND(MIN(avrain),2) AS rain, 
    ROUND(MIN(meanmin),2) AS temp_min,
    ROUND(MIN(meanmax),2) AS temp_max
FROM forgs
GROUP BY pres_abs

UNION ALL 

SELECT 
	pres_abs,
    'Mean', 
    ROUND(AVG(altitude), 2), 
    ROUND(AVG(distance), 2), 
    ROUND(AVG(no_of_pools), 2), 
    ROUND(AVG(no_of_sites), 2), 
    ROUND(AVG(avrain), 2), 
    ROUND(AVG(meanmin), 2),
    ROUND(AVG(meanmax), 2)
FROM forgs
GROUP BY pres_abs

UNION ALL 

SELECT 
	pres_abs,
    'Median', 
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY altitude))::NUMERIC,2),
    (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY distance)),
    (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY no_of_pools)),
    (PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY no_of_sites)),
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY avrain))::NUMERIC,2),
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY meanmin))::NUMERIC,2),
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY meanmax))::NUMERIC,2)
FROM forgs
GROUP BY pres_abs

UNION ALL

SELECT 
	pres_abs,
    'Max', 
    ROUND(MAX(altitude), 2),
    MAX(distance), 
    MAX(no_of_pools), 
    MAX(no_of_sites), 
    ROUND(MAX(avrain), 2),
    ROUND(MAX(meanmin),2),
    ROUND(MAX(meanmax),2)
FROM forgs
GROUP BY pres_abs;
--Read about this one in GitHub...--