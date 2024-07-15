select *
from Project1..data1$

--Select specific data
select location, date, total_cases, new_cases, total_deaths, population_density
from Project1..data1$
order by 1,2

--Total cases and Total deaths
select location, date, total_cases, total_deaths, (cast(total_deaths as float)/cast(total_cases as float))*100 as Death_percentage
from Project1..data1$
order by 1,2

--Select by Sri Lanka dying percentage as of total cases
select location, date, total_cases, total_deaths, (cast(total_deaths as float)/cast(total_cases as float))*100 as Death_percentage
from Project1..data1$
where location like '%lanka%'
order by 1,2

--The date which recorded highest new_cases in SL
select location, date, new_cases
from Project1..data1$
where location like '%lanka%'
order by new_cases desc

--Countries with highest total_deaths
select location, sum(cast(total_deaths as float)) as total_deaths
from Project1..data1$
group by location
order by total_deaths desc

--Continents and their death counts
select location, sum(cast(total_deaths as float)) as total_deaths
from Project1..data1$
where location in ('Europe', 'North America', 'Asia', 'South America', 'Africa')
group by location
order by total_deaths desc

--Global analysis

--Date vs new_cases globally
select date, sum(new_cases)
from Project1..data1$
group by date
order by date 

--Vaccination dataset
select *
from Project1..data1$
order by 1,2

--Joining tables cases and vaccinations
select * 
from Project1..data1$ de
join Project1..data2$ vac
on de.location = vac.location
and de.date =vac.date

--Selecting specific data from both tables
select de.date, de.location, vac.population, vac.total_vaccinations                                                    
from Project1..data1$ de
join Project1..data2$ vac
on de.location = vac.location
and de.date =vac.date
order by 1, 3

select * 
from Project1..data2$

--Total Percentage vaccinated
insert into data3
select vac.location, vac.population, (sum(cast(vac.people_vaccinated as float))/sum(cast(vac.population as float))) *100 as VaccinatedPercentage
from Project1..data1$ de
join Project1..data2$ vac
on de.location = vac.location
and de.date =vac.date
group by vac.population, vac.location

create table data3
(
Location nvarchar(255),
population float,
PercentageVaccinated float,
)

select *
from data3

--Creating view for data visualization
create view data3V as
select vac.location, vac.population, (sum(cast(vac.people_vaccinated as float))/sum(cast(vac.population as float))) *100 as VaccinatedPercentage
from Project1..data1$ de
join Project1..data2$ vac
on de.location = vac.location
and de.date =vac.date
group by vac.population, vac.location