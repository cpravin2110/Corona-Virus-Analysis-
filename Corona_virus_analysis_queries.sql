CREATE TABLE corona_virus (
    province         VARCHAR(100),
    country_region   VARCHAR(100),
    latitude         NUMERIC(9,6),
    longitude        NUMERIC(9,6),
    date             DATE,
    confirmed        INT,
    deaths           INT,
    recovered        INT
);


select * from corona_virus;


--Q1.Write a query to check null values.

SELECT
    COUNT(*) FILTER (WHERE province IS NULL),
    COUNT(*) FILTER (WHERE country_region IS NULL),
    COUNT(*) FILTER (WHERE latitude IS NULL) ,
    COUNT(*) FILTER (WHERE longitude IS NULL),
    COUNT(*) FILTER (WHERE date IS NULL),
    COUNT(*) FILTER (WHERE confirmed IS NULL) ,
    COUNT(*) FILTER (WHERE deaths IS NULL) ,
    COUNT(*) FILTER (WHERE recovered IS NULL)      
FROM corona_virus;


--Q2.Finds the earliest and latest dates in the dataset.

select
min(date) as start_date,
max(date) as End_date
from corona_virus;


--Q3.Find monthly average for confirmed, deaths, recovered

SELECT
    TO_CHAR(date, 'YYYY-MM') AS year_month,
    AVG(confirmed)::NUMERIC(10,4)  AS avg_confirmed,
    AVG(deaths)::NUMERIC(10,4)     AS avg_deaths,
    AVG(recovered)::NUMERIC(10,4)  AS avg_recovered
FROM corona_virus
GROUP BY year_month
ORDER BY year_month;



--Q4.Find maximum values for confirmed, deaths, recovered per Month.

SELECT
 TO_CHAR(date, 'YYYY-MM') AS year_month,
MaX(Confirmed) AS Max_Confirmed,
MAX(Deaths) AS Max_Deaths,
MAX(Recovered) AS Max_Recovered
FROM
corona_virus
GROUP BY year_month
ORDER BY year_month;

--Q5.Find maximum values for confirmed, deaths, recovered per Year.

SELECT
EXTRACT(YEAR FROM date)  AS year,
MaX(Confirmed) AS Max_Confirmed,
MAX(Deaths) AS Max_Deaths,
MAX(Recovered) AS Max_Recovered
FROM
corona_virus
GROUP BY year
ORDER BY year;

--Q6.Find how monthly total cases found .

SELECT
EXTRACT(YEAR FROM date)  AS year,
EXTRACT(MONTH FROM date) AS month,
SUM(confirmed)  AS total_confirmed,
SUM(deaths)     AS total_deaths,
SUM(recovered)  AS total_recovered
FROM corona_virus
GROUP BY year ,month
ORDER BY year, month ;

--Q7.Check how corona virus spread out with respect to confirmed case.

SELECT
SUM(confirmed) AS total_confirmed_cases,
AVG(confirmed) AS avg_confirmed_cases,
VARIANCE(confirmed) AS variance_confirmed_cases,
STDDEV(confirmed) AS stdev_confirmed_cases
FROM corona_virus;

--Q8.Check how corona virus spread out with respect to recoverd case .

SELECT
SUM(recovered) AS total_recovered_cases,
AVG(recovered) AS avg_recovered_cases,
VARIANCE(recovered) AS variance_recovered_cases,
STDDEV(recovered) AS stdev_recovered_cases
FROM corona_virus;

--Q9.Check how corona virus spread out with respect to death case.

SELECT
SUM(deaths) AS total_death_cases,
AVG(deaths) AS avg_death_cases,
VARIANCE(deaths) AS variance_death_cases,
STDDEV(deaths) AS stdev_death_cases
FROM corona_virus;

--Q10.Check how corona virus spread out with respect to death case per month.

SELECT
EXTRACT(YEAR FROM date)  AS year,
EXTRACT(MONTH FROM date) AS month,
SUM(deaths) AS total_death_cases,
AVG(deaths)::NUMERIC(10,4) AS avg_death_cases,
VARIANCE(deaths)::NUMERIC(10,4) AS variance_death_cases,
STDDEV(deaths)::NUMERIC(10,4) AS stdev_death_cases
FROM corona_virus
GROUP BY year , month
ORDER BY year , month ;

--Q11.Check how corona virus spread out with respect to recovered case per month.

SELECT
EXTRACT(YEAR FROM date)  AS year,
EXTRACT(MONTH FROM date) AS month,
SUM(recovered) AS total_recovered_cases,
AVG(recovered)::NUMERIC(15,2) AS avg_recovered_cases,
VARIANCE(recovered)::NUMERIC(15,2) AS variance_recovered_cases,
STDDEV(recovered)::NUMERIC(15,2) AS stdev_recovered_cases
FROM corona_virus
GROUP BY year , month
ORDER BY year , month ;

--Q12.Find Country having highest number of the Confirmed ,deaths and recovered cases.

SELECT
    country_region,
    SUM(confirmed)  AS total_confirmed,
    SUM(deaths)     AS total_deaths,
    SUM(recovered)  AS total_recovered
FROM corona_virus
GROUP BY country_region
ORDER BY
    total_confirmed DESC,
    total_deaths DESC,
    total_recovered DESC
LIMIT 1;


--Q13.Find Country having lowest number of the deaths cases.

WITH rankingCountry AS (
    SELECT
        country_region,
        SUM(deaths) AS total_death_cases,
        RANK() OVER (ORDER BY SUM(deaths) ASC) AS rank_no
    FROM corona_virus
    GROUP BY country_region
)
SELECT
    country_region,
    total_death_cases
FROM rankingCountry
WHERE rank_no = 1;

--Q14.Find top 5 countries having most death cases.

select
country_region,
sum(deaths) as total_death_cases
from corona_virus
group by country_region
order by total_death_cases desc
limit 5;

--Q15.Find top 5 countries having most recovered cases.

select
country_region,
sum(recovered) as total_recovered_cases
from corona_virus
group by country_region
order by total_recovered_cases desc
limit 5;


