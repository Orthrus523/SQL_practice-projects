select * from cars;


--Count how many models contain the word “cab”.

select model , count(*) as cab_count 
from cars 
where model ILIKE '%cab%'
group by model;

/*Categorize cars into:

* truck
* sedan
* other
  based on model text.*/

select model ,
case 
when model ILIKE '%truck%' 
      or model ILIKE '%pickup%'
      or model ILIKE '%cab%' then 'truck' 
when model ILIKE '%sedan%' then 'sedan' 
else 'other'
end as car_type
from cars

--Which manufacturers produce the most trucks top 3?
select manufacturer, count(*) as no_trucks
from cars
where model ILIKE '%truck%'  and manufacturer is not null and TRIM(manufacturer) <> ''
group by manufacturer
order by no_trucks desc
limit 3;

--Find models that appear with more than one paint color.

select model ,count(distinct paint) as paint_colr_G1
from cars 
where model is not null and paint is not null
group by model
having count(distinct paint) >1;

--Find manufacturers with models that contain numbers (e.g. 1500, f-150).

select manufacturer , model
from cars
where model ILIKE '%1500%' or model ILIKE '%f-150%' and manufacturer is not null and TRIM(manufacturer) <> ''

--Longest model name (by character length).

select model
from cars
where model is not null
order by char_length(model) desc
limit 1;
----------------------optional 
select model
from cars
where char_length(model) = (
    select max(char_length(model))
    from cars  --inner query chooses the max and outer checks for the matches that is max what we need
);
