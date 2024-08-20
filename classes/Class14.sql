# 1
select concat(c.first_name, " ", c.last_name) as nombre_apellido ,ad.address , co.country from customer c, address ad, city ci, country co
where c.address_id = ad.address_id
and ad.city_id = ci.city_id
and ci.country_id = co.country_id
and co.country = "Argentina";

# 2
select f.title, l.name,
case 
	when rating = "G" then "General Audiences"
    when rating = "PG" then "Parental Guidance Suggested"
    when rating = "PG-13" then "Parents Strongly Cautioned"
    when rating = "R" then "Restricted"
    when rating = "NC-17" then "Adults Only"
    end as rating
 from film f, language l
where f.language_id = l.language_id;

# 3
select f.title, f.release_year, a.first_name from film f, film_actor fa, actor a
where f.film_id = fa.film_id
and fa.actor_id = a.actor_id
;

# 4
select 
	f.title,
    concat(c.first_name, " ", c.last_name) as customer_name,
    case
		when r.return_date is not null then "Yes"
        else "No"
	end as returned
 from rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
inner join customer c on r.customer_id = c.customer_id
where month(r.rental_date) between 5 and 6
order by r.rental_date;

# 5
select CAST(rental_id as char) as rental_id_str
from rental
limit 5;

select convert(rental_id, char(10)) as rental_id_str
from rental
limit 5;


# 6
# No avaliable in MySQL
SELECT NVL(salary, 0) AS salary
FROM employees;
# Explanation: If salary is NULL, it will be replaced with 0.

SELECT ISNULL(bonus, 100) AS bonus
FROM employees;
# Explanation: If bonus is NULL, it will be replaced with 100.

SELECT IFNULL(bonus, 100) AS bonus
FROM employees;
# Explanation: If bonus is NULL, it will be replaced with 100.

SELECT COALESCE(bonus, commission, 100) AS compensation
FROM employees;
# Explanation: This will return the first non-NULL value from bonus, commission, or 100.