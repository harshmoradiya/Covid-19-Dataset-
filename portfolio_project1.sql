-- datewise liklihood of dying due to covid total_case vs total death in india
select date, total_cases,total_deaths 
from "CovidDeaths"
where location like '%India%'

--total % of death out of entire population in india
SELECT max(total_deaths)/avg(cast(population as integer))*100 FROM public."CovidDeaths"
where location like '%India%'

-- verify
SELECT total_deaths,population FROM public."CovidDeaths"
where location like '%India%'

--country with highest death %
select location, max(total_deaths)/avg(cast(population as bigint))*100 as percentage
FROM public."CovidDeaths"
group by location
order by percentage desc

--total% of positive cases in india
select max(total_cases)/avg(cast(population as bigint))*100 as percentage_positive
FROM public."CovidDeaths"
where location like '%India%'

--total% of positive cases for world
select location, max(total_cases)/avg(cast(population as bigint))*100 as percentage_positive
FROM public."CovidDeaths"
group by location
order by percentage_positive desc

--continent wise positive cases
SELECT location,max(total_cases) as total_case 
FROM public."CovidDeaths"
where continent is null
group by location
order by total_case desc;

--continent wise death
SELECT location,max(total_deaths) as total_death 
FROM public."CovidDeaths"
where continent is null
group by location
order by total_death desc;

--daily new cases vs hospitalization vs icu_patient - india
SELECT date,new_cases,hosp_patients,icu_patients
FROM public."CovidDeaths"
where location like '%India%'

--countrywise age > 65
select "CovidDeaths".location,"CovidVaccinations".aged_65_older
FROM public."CovidDeaths"
join "CovidVaccinations" on "CovidDeaths".iso_code = "CovidVaccinations".iso_code
and "CovidDeaths".date = "CovidVaccinations".date

--countrywise total vaccinated people
select "CovidDeaths".location as country,(max("CovidVaccinations".people_fully_vaccinated)) as fully_vaccinated
FROM public."CovidDeaths"
join "CovidVaccinations" on "CovidDeaths".iso_code = "CovidVaccinations".iso_code
and "CovidDeaths".date = "CovidVaccinations".date
where "CovidDeaths".continent is not null
group by country
order by fully_vaccinated desc

