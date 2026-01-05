--Top 5 manufacturers by number of cars.
select * from cars;

select manufacturer ,  count(*) as no_of_cars_by_manu 
from cars 
group by manufacturer 
order by Count(*) desc
limit 5;

--Number of cars produced per decade.

select (year/10)*10 as decade , count(*) as no_of_cars_perDecade 
from cars
where year is not null
group by decade
order by decade

--Average year of cars per manufacturer.

select manufacturer, round(avg(year),0) as avg_cars_perYear 
from cars
where manufacturer is not null and TRIM(manufacturer) <> ''
group by manufacturer
order by manufacturer

--Manufacturers that appear in at least 20 different years.

select manufacturer , count(distinct year)
from cars
where manufacturer is not null and TRIM(manufacturer) <> ''
group by manufacturer
having count(distinct year)>=20


--Paint color distribution for each manufacturer.

select manufacturer , coalesce(paint,'unknown') as paint_clr , count(*) as paint_count
from cars
group by manufacturer, paint_clr 
order by manufacturer, paint_clr 

--For each year, which manufacturer produced the most cars?

select year , coalesce(manufacturer , 'unknown') as manu_winner , car_count  
from (select year , manufacturer , count(*) as car_count ,
DENSE_RANK() OVER (partition by year ORDER BY Count(*) DESC) as Most_cars  --making asc we can simply go for least producers
from cars
group by year ,  manufacturer
) as t
where Most_cars=1 
order by year

--Find manufacturers whose production peaked after 2015.
select year,coalesce(manufacturer , 'unknown') as manu_winner , car_count  
from (select year , manufacturer , count(*) as car_count ,
DENSE_RANK() OVER (partition by manufacturer ORDER BY Count(*) DESC) as peak_manu
from cars
group by year ,  manufacturer
) as t
where peak_manu=1 and year> 2015
order by year

--Which year has the highest number of total cars?
SELECT year, COUNT(*) AS car_count
FROM cars
GROUP BY year
ORDER BY car_count DESC
LIMIT 1;

--Which manufacturer has the most color variety?
select manufacturer ,  count(distinct paint) as paint_count
from cars
where manufacturer is not null and TRIM(manufacturer) <> '' and paint is not null
group by manufacturer 
order by paint_count desc
limit 1
