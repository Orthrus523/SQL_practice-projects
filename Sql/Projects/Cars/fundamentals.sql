
ALTER TABLE public."Cars" RENAME TO cars;  --facing the error where table was in quotes so could not find the data So renaming as per our need


--Warm-up aka fundamentals..!!!!!

--How many total records are in the table?

SELECT COUNT(*) FROM cars;

--How many distinct manufacturers exist?

SELECT Count(DISTINCT manufacturer) FROM cars;
SELECT DISTINCT manufacturer FROM cars;

--How many cars have a missing paint color?

select count(*) filter (where paint is null) as missing_paint from cars;

--How many cars were manufactured before the year 2000?

select count(*) filter (where year > 2000) as manu_before_2000 from cars;

--List all distinct paint colors in alphabetical order.

select distinct paint from cars where paint is not null
order by paint ASC;

--Find the earliest and latest year in the dataset.

select 
min(year) as min_year ,
max(year) as max_year 
from cars;

--Count cars per year, sorted by year.

select Count(*) as cars_in_year ,year from cars
group by year
order by year;

--Count cars per manufacturer, sorted descending.

select Count(*) as cars_by_manu ,manufacturer from cars
group by manufacturer
order by cars_by_manu DESC;

--Which manufacturer has the highest number of cars?

select Count(*) as cars_by_manu ,manufacturer from cars  where manufacturer is not null
group by manufacturer
order by cars_by_manu DESC
LIMIT 1;

--Which paint color appears the least?

select Count(*) as least_paint ,paint from cars  where paint is not null
group by paint
order by least_paint ASC
LIMIT 1;

--cross checked!!!

select count(paint) from cars where paint='purple';


