
Explore and Inspect the table

-- View first few rows
SELECT * FROM covid_data LIMIT 10;

-- View column names and types
PRAGMA table_info(covid_data);

-- Check distinct countries/locations
SELECT DISTINCT location FROM covid_data LIMIT 20;

-- Find range of dates
SELECT MIN(date), MAX(date) FROM covid_data;

Clean the data 
SELECT *
FROM covid_data
WHERE continent IS NOT NULL AND total_cases IS NOT NULL;


Create a cleaned subset

CREATE TABLE covid_cleaned AS
SELECT
    date,
    location,
    continent,
    population,
    total_cases,
    total_deaths,
    people_vaccinated,
    people_fully_vaccinated,
    (total_deaths * 1.0 / total_cases) AS death_rate,
    (total_cases * 1.0 / population) * 100 AS infection_rate
FROM covid_data
WHERE continent IS NOT NULL AND total_cases IS NOT NULL;





SELECT 
  SUM(total_cases) AS total_cases_world,
  SUM(total_deaths) AS total_deaths_world,
  ROUND(SUM(total_deaths) * 100.0 / SUM(total_cases), 2) AS global_death_rate
FROM covid_cleaned;

/* 1. Global Totals


Find countries with death rates above 5% (death_rate = total_deaths / total_cases)

SELECT 
    location,
    SUM(total_cases) AS total_cases,
    SUM(total_deaths) AS total_deaths,
    ROUND(SUM(total_deaths) * 1.0 / NULLIF(SUM(total_cases), 0) * 100, 2) AS death_rate_percent
FROM 
    covid_cleaned
WHERE 
    continent IS NOT NULL
GROUP BY 
    location
HAVING 
    death_rate_percent > 5
ORDER BY 
    death_rate_percent DESC;

//2. Deaths per Continent

SELECT 
  continent,
  SUM(total_deaths) AS total_deaths
FROM covid_cleaned
GROUP BY continent
ORDER BY total_deaths DESC;

3. Top 10 Countries by Infection Rate

SELECT 
  location,
  MAX(infection_rate) AS max_infection_rate
FROM covid_cleaned
GROUP BY location
ORDER BY max_infection_rate DESC
LIMIT 10;


4. Death Rate per Country (filtered)
SELECT 
  location,
  MAX(death_rate) AS highest_death_rate
FROM covid_cleaned
WHERE total_cases > 100000
GROUP BY location
ORDER BY highest_death_rate DESC
LIMIT 10;



Infection Rate Over Time 
SELECT 
  date,
  AVG(infection_rate) AS avg_infection_rate
FROM covid_cleaned
GROUP BY date
ORDER BY date;


6. Death Rate Map (Choropleth)
SELECT 
  location,
  MAX(death_rate) AS max_death_rate
FROM covid_cleaned
GROUP BY location;


 1. Vaccination Rate by Country
 SELECT 
  location,
  MAX(people_vaccinated * 100.0 / population) AS vaccination_rate
FROM covid_cleaned
WHERE people_vaccinated IS NOT NULL
GROUP BY location
ORDER BY vaccination_rate DESC
LIMIT 10;


 2. Infection Rate vs Vaccination Rate
SELECT 
  location,
  MAX(people_fully_vaccinated * 100.0 / population) AS full_vaccination_rate,
  MAX(infection_rate) AS infection_rate
FROM covid_cleaned
WHERE people_fully_vaccinated IS NOT NULL
GROUP BY location;


3. Deaths vs Vaccination Rate (Effectiveness?)
SELECT 
  location,
  MAX(people_fully_vaccinated * 100.0 / population) AS full_vaccination_rate,
  MAX(death_rate) AS death_rate
FROM covid_cleaned
WHERE people_fully_vaccinated IS NOT NULL
GROUP BY location;


Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated
