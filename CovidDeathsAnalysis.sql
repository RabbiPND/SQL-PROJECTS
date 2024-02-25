SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths
order by 1,2

--- Looking at Total cases vs Total deaths
---percentage(chance of dying) of people who died that had the diesase
SELECT 
    location, 
    date, 
    total_cases, 
    total_deaths, 
    CASE 
        WHEN TRY_CAST(total_cases AS decimal) = 0 THEN NULL
        ELSE TRY_CAST(total_deaths AS decimal) / TRY_CAST(total_cases AS decimal) * 100
    END AS percentage
FROM 
    PortfolioProject.dbo.CovidDeaths
WHERE location like '%south africa%' AND continent is not null
	order by 1,2



--- Looking at Total Cases vs Population
---shows the population that is affected
SELECT 
    location, 
    date, 
    total_cases, 
    population, 
    CASE 
        WHEN TRY_CAST(population AS decimal) = 0 THEN NULL
        ELSE TRY_CAST(total_cases AS decimal) / TRY_CAST(population AS decimal) * 100
    END AS death_percentage
FROM 
    PortfolioProject.dbo.CovidDeaths
	WHERE continent is not null
ORDER BY 1,2



---Looking at countries with highest infection rate compared to population
SELECT
    location, 
    date, 
    MAX(total_cases) AS HighestInfectionCount, 
    population, 
    CASE 
        WHEN TRY_CAST(population AS decimal) = 0 THEN NULL
        ELSE MAX(TRY_CAST(total_cases AS decimal) / TRY_CAST(population AS decimal) * 100)
    END AS PercentagePopulationInfected
FROM 
    PortfolioProject.dbo.CovidDeaths
	WHERE continent is not null
--WHERE location like '%south africa&'
GROUP BY
    location, 
    date, 
    population
ORDER BY 
    PercentagePopulationInfected DESC;



---Looking at countries with highest death rate compared to population
SELECT
    location, 
    date, 
    MAX(cast(total_deaths as int)) AS HighestDeathCount, 
    population, 
    CASE 
        WHEN TRY_CAST(population AS decimal) = 0 THEN NULL
        ELSE MAX(TRY_CAST(total_deaths AS decimal) / TRY_CAST(population AS decimal) * 100)
    END AS PercentagePopulationDeaths
FROM 
    PortfolioProject.dbo.CovidDeaths
	WHERE continent is not null
--WHERE location like '%south africa&'
GROUP BY
    location, 
    date, 
    population
ORDER BY 
    PercentagePopulationDeaths DESC;



---to remove continent in location
SELECT * 
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent is not null
ORDER BY 3,4


---LETS BREAK THINGS DOWN BY CONTINENT
SELECT
    location,
    MAX(cast(total_deaths as int)) AS HighestDeathCount
FROM 
    PortfolioProject.dbo.CovidDeaths
	where continent is null
--WHERE location like '%south africa&'
GROUP BY
    location
ORDER BY 
    HighestDeathCount DESC;



---Showing contintents with the highest death count per population
SELECT
    continent,
    MAX(cast(total_deaths as int)) AS HighestDeathCount
FROM 
    PortfolioProject.dbo.CovidDeaths
	where continent is not null
GROUP BY
    continent
ORDER BY 
    HighestDeathCount DESC;



---Global Numbers
SELECT
    date,
    SUM(CAST(new_cases AS int)) AS TotalNewCases,
    SUM(CAST(new_deaths AS int)) AS TotalNewDeaths,
    CASE
        WHEN SUM(CAST(new_cases AS decimal)) = 0 THEN NULL
        ELSE SUM(CAST(new_deaths AS decimal)) / SUM(CAST(new_cases AS decimal)) * 100
    END AS DeathPercentage
FROM 
    PortfolioProject.dbo.CovidDeaths
WHERE 
    continent IS NOT NULL
GROUP BY
    date
ORDER BY 
    1, 2;

---Total numbers
SELECT
    SUM(CAST(new_cases AS int)) AS TotalNewCases,
    SUM(CAST(new_deaths AS int)) AS TotalNewDeaths,
    CASE
        WHEN SUM(CAST(new_cases AS decimal)) = 0 THEN NULL
        ELSE SUM(CAST(new_deaths AS decimal)) / SUM(CAST(new_cases AS decimal)) * 100
    END AS DeathPercentage
FROM 
    PortfolioProject.dbo.CovidDeaths
WHERE 
    continent IS NOT NULL
ORDER BY 
    1, 2;








--SELECT *
--FROM PortfolioProject.dbo.CovidVaccinations


