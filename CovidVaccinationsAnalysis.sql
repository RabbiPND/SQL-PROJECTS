SELECT *
FROM PortfolioProject.dbo.CovidVaccinations


SELECT *
FROM PortfolioProject.dbo.CovidDeaths AS Deaths
Join PortfolioProject.dbo.CovidVaccinations AS Vac
	ON Deaths.location = Vac.location
	And Deaths.date = Vac.date


---Total population vs vaccinations
---what is total amount of people in the world hat is vaccinated PER DAY
---ADD TO THE SAME LOCATION BY USING PARTITION BY
SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vac.new_vaccinations,
	SUM(CAST(Vac.new_vaccinations AS bigint)) OVER (Partition by Deaths.location ORDER BY Deaths.location,
	Deaths.date) AS RollingPeopleVaccinated
FROM PortfolioProject.dbo.CovidDeaths AS Deaths
Join PortfolioProject.dbo.CovidVaccinations AS Vac
	ON Deaths.location = Vac.location
	And Deaths.date = Vac.date
WHERE Deaths.continent IS NOT NULL
ORDER BY 2,3

---USE CTEs
WITH PopvsVac AS (
SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vac.new_vaccinations,
	SUM(CAST(Vac.new_vaccinations AS bigint)) OVER (Partition by Deaths.location ORDER BY Deaths.location,
	Deaths.date) AS RollingPeopleVaccinated
FROM PortfolioProject.dbo.CovidDeaths AS Deaths
Join PortfolioProject.dbo.CovidVaccinations AS Vac
	ON Deaths.location = Vac.location
	And Deaths.date = Vac.date
WHERE Deaths.continent IS NOT NULL
--ORDER BY 2,3
)

SELECT 
    continent, 
    location, 
    date, 
    population, 
    new_vaccinations, 
    RollingPeopleVaccinated,
	(RollingPeopleVaccinated/population)*100 AS Percentageincrease
FROM 
    PopvsVac;
---Run the whole script(CTE)

--OR

---Temp Table
---NB(DROP TABLE)
DROP TABLE IF EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vac.new_vaccinations,
	SUM(CAST(Vac.new_vaccinations AS bigint)) OVER (Partition by Deaths.location ORDER BY Deaths.location,
	Deaths.date) AS RollingPeopleVaccinated
FROM PortfolioProject.dbo.CovidDeaths AS Deaths
Join PortfolioProject.dbo.CovidVaccinations AS Vac
	ON Deaths.location = Vac.location
	And Deaths.date = Vac.date
WHERE Deaths.continent IS NOT NULL
--ORDER BY 2,3

SELECT 
    continent, 
    location, 
    date, 
    population, 
    new_vaccinations, 
    RollingPeopleVaccinated,
	(RollingPeopleVaccinated/population)*100 AS Percentageincrease
FROM 
    #PercentPopulationVaccinated;







----Creating view to store data for later visualization
Create View PercenPopulationVaccinated AS
SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vac.new_vaccinations,
	SUM(CAST(Vac.new_vaccinations AS bigint)) OVER (Partition by Deaths.location ORDER BY Deaths.location,
	Deaths.date) AS RollingPeopleVaccinated
FROM PortfolioProject.dbo.CovidDeaths AS Deaths
Join PortfolioProject.dbo.CovidVaccinations AS Vac
	ON Deaths.location = Vac.location
	And Deaths.date = Vac.date
WHERE Deaths.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PercenPopulationVaccinated
--TO RUN VIEW(DATABASE>VIEWS)