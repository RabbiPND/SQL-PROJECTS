SELECT TOP (1000)
    [iso_code],
    [continent],
    [location],
    [population],
    [date],
    [total_cases],
    [new_cases],
    [new_cases_smoothed],
    [total_deaths],
    [new_deaths],
    [new_deaths_smoothed],
    [total_cases_per_million],
    [new_cases_per_million],
    [new_cases_smoothed_per_million],
    [total_deaths_per_million],
    [new_deaths_per_million],
    [new_deaths_smoothed_per_million],
    [reproduction_rate],
    [icu_patients],
    [icu_patients_per_million],
    [hosp_patients],
    [hosp_patients_per_million],
    [weekly_icu_admissions],
    [weekly_icu_admissions_per_million],
    [weekly_hosp_admissions],
    [weekly_hosp_admissions_per_million],
    CASE
        WHEN TRY_CAST([total_cases] AS float) = 0 THEN NULL
        ELSE TRY_CAST([total_deaths] AS float) / TRY_CAST([total_cases] AS float)
    END AS death_ratio
FROM [PortfolioProject].[dbo].[CovidDeaths];
