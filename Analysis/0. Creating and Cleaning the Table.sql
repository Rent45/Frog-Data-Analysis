--Creating the table for import--
CREATE TABLE IF NOT EXISTS Forgs (
    id SERIAL PRIMARY KEY,  -- SERIAL handles the auto-incrementing!
    pres_abs INTEGER,       
    northing NUMERIC,
    easting NUMERIC,
    altitude NUMERIC,
    distance NUMERIC,
    no_of_pools INTEGER,
    no_of_sites INTEGER,
    avrain NUMERIC,
    meanmin NUMERIC,
    meanmax NUMERIC
);

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




--CLEANING THE DATA--

--Selecting NULL data (if at least 1 column is null)--
SELECT * 
FROM forgs
WHERE NOT (forgs IS NOT NULL);

--Selecting illogical data--
SELECT *
FROM forgs
WHERE pres_abs NOT IN (0,1)
OR distance < 0
OR no_of_pools < 0
OR no_of_sites < 0
OR meanmin NOT BETWEEN -50 AND 50
OR meanmax NOT BETWEEN meanmin AND 50;

--Checking for duplicates--
WITH duplicates AS (
    SELECT 
        northing, easting, altitude,
        COUNT(*) as duplicate_count
    FROM forgs
    GROUP BY 
        northing, easting, altitude
    HAVING COUNT(*) > 1
)
SELECT f.*, d.duplicate_count
FROM forgs f
JOIN duplicates d 
  ON f.northing = d.northing 
 AND f.easting = d.easting 
 AND f.altitude = d.altitude;
 
--Those are probably due to coordinate inaccuracy. I will keep them.--
