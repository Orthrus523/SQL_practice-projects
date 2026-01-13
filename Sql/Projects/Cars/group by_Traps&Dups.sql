--Find exact duplicate rows (all columns same).

select * from cars;

select year,manufacturer,model,paint,count(*) as dups from cars 
group by year,manufacturer,model,paint
having count(*) > 1;


--Find duplicate models within the same manufacturer.

select manufacturer,model,count(*)
from cars
group by manufacturer,model
having count(*) > 1;

--For each manufacturer, count duplicate models.
select manufacturer , count(model) as dups from (select manufacturer,model,count(*)
from cars
group by manufacturer,model
having count(*) > 1) as x
group by manufacturer;

--Years where duplicate records are unusually high.

select year , total_rows , dup_rows --outer query
from (select year ,count(*) as total_rows , count(*) filter (where cnt > 1) as dup_rows --agg year as total n dups(mid  layr)
from (select year,manufacturer,model,paint,
count(*) as cnt from cars  --innermost query!! wr v using to finds duplicate rows with cnt(inner most layr)
group by year,manufacturer,model,paint
)t
group by year
)x
where dup_rows > 0.10 * total_rows  --Keeps only years where duplicates exceed 10%
order by year;

--Remove duplicates logically (do not delete — just show unique rows).


select year,manufacturer,model,paint
from (select year,manufacturer,model,paint,
ROW_NUMBER() over (PARTITION BY year, manufacturer, model, paint order by year) as rn from cars) t
where rn = 1;

