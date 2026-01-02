Create database EDM;
use EDM;

CREATE TABLE edm_data(
year int,
site_name VARCHAR(225),
total_duration_hours decimal(10,2)
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/EDM Sheet(2020-2024).csv'
INTO TABLE edm_data
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(year, site_name, total_duration_hours);

SELECT * from edm.edm_data;

-- checking duplicates
Select year, site_name, count(*) as total_count
from edm.edm_data group by year, site_name
having count(*)>1;

-- Checking missing values
select * from edm.edm_data
where year is null or
site_name is null or
total_duration_hours is null or
total_duration_hours<0;

-- range by year
SELECT year, count(*) as sites,
SUM(total_duration_hours) as total_duration,
AVG(total_duration_hours) as avg_duration,
MAX(total_duration_hours) as max_duration
from edm.edm_data
group by year order by year;

-- Top 20 sites by hours
SELECT site_name,
SUM(total_duration_hours) as durationBTW2020To2024
from edm.edm_data
group by site_name 
order by durationBTW2020To2024 desc
limit 20;

-- Trend by year (total duration by year)
SELECT year, SUM(total_duration_hours) as TotalHours 
from edm.edm_data 
group by year
order by year;

-- year on year change for each site
WITH s AS (
  SELECT
    site_name, year, total_duration_hours,
    LAG(total_duration_hours) OVER (PARTITION BY site_name ORDER BY year) AS PrevYearDuration
  FROM edm.edm_data
)
SELECT
  site_name, year, total_duration_hours, PrevYearDuration,
  (total_duration_hours - PrevYearDuration) AS YoY_ChangeHours,
  CASE
    WHEN PrevYearDuration IS NULL OR PrevYearDuration = 0 THEN NULL
    ELSE Round(((total_duration_hours - PrevYearDuration) / PrevYearDuration),2)
  END AS YoY_ChangePct
FROM s
ORDER BY year, YoY_ChangeHours DESC;

-- Worst improvers
WITH y AS (
  SELECT site_name,
         MAX(CASE WHEN year = 2023 THEN total_duration_hours END) AS H2023,
         MAX(CASE WHEN year = 2024 THEN total_duration_hours END) AS H2024
  FROM edm.edm_data
  GROUP BY site_name
)
SELECT site_name, H2023, H2024, (H2024 - H2023) AS 'Change'
FROM y
WHERE H2023 IS NOT NULL AND H2024 IS NOT NULL
ORDER BY 'Change' DESC limit 20;

-- Zero duration sites
SELECT year, count(*) as zeroDuration
from edm.edm_data 
where total_duration_hours=0
group by year order by year;


-- Spiky vs consistent sites
SELECT
  site_name,
  AVG(total_duration_hours) AS AvgHours,
  STDDEV(total_duration_hours) AS StdDevHours
FROM edm_data
GROUP BY site_name
ORDER BY StdDevHours DESC;

-- missing years/gaps
SELECT
  site_name,
  COUNT(*) AS YearsPresent
FROM edm_data
GROUP BY site_name
HAVING COUNT(*) < 5
ORDER BY YearsPresent ASC;