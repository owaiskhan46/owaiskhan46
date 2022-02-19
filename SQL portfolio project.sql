select *
from [portfolio project]..[covid deaths]
order by 3,4

select *
from [portfolio project]..['covid vaccination$']
order by 3,4


select location,date, total_cases,new_cases,total_deaths,new_deaths,population
from [portfolio project]..[covid deaths]
order by 1,2



select location,date, total_cases,total_deaths,new_deaths,(total_deaths/total_cases)*100 as percentagedeaths
from [portfolio project]..[covid deaths]
order by 1,2


select location,date, total_cases,new_cases,total_deaths,new_deaths,(total_deaths/total_cases)*100 as percentagedeaths
from [portfolio project]..[covid deaths]
where location like '%states%' 
order by 1,2

select location,date, total_cases,population,(total_cases/population)*100 as percentagerate
from [portfolio project]..[covid deaths]
where location like '%states%' 
order by 1,2

select date,continent,location,population,total_cases,new_cases,total_deaths,new_deaths,
(total_deaths/total_cases)*100 as totaldeathrate
from [portfolio project]..[covid deaths]

order by 3,4


select location,population,max(total_cases)as maxinfection,
(max(total_cases/population))*100 as totalinfectionrate
from [portfolio project]..[covid deaths]
group by location,population
order by totalinfectionrate desc



select location,max(cast (total_deaths as int)) as totaldeathcount
from [portfolio project]..[covid deaths]
where continent is not null
group by location 
order by totaldeathcount  desc


select location,max(cast (total_deaths as int)) as totaldeathcount
from [portfolio project]..[covid deaths]
where continent is  null
group by location 
order by totaldeathcount  desc

select location, CONVERT(bigint,total_vaccinations)
from [portfolio project]..['covid vaccination$']
order by 1,2

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,vac.total_vaccinations
from [portfolio project]..[covid deaths] dea
join [portfolio project]..['covid vaccination$'] vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null 
order by 2,3


with popvsvac (continent,location,date,population,new_vaccination,total_vaccination)
as(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,vac.total_vaccinations
from [portfolio project]..[covid deaths] dea
join [portfolio project]..['covid vaccination$'] vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null 
)
select*,(total_vaccination/population)*100 as vaccinationrate
from popvsvac


create view visulization as
with popvsvac (continent,location,date,population,new_vaccination,total_vaccination)
as(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,vac.total_vaccinations
from [portfolio project]..[covid deaths] dea
join [portfolio project]..['covid vaccination$'] vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null 
)
select*,(total_vaccination/population)*100 as vaccinationrate
from popvsvac




