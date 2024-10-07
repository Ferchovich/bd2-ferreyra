# 1 Create 3 query 
# 1st Query
explain select * from address where postal_code in (select postal_code from address where postal_code > 20000);

# 2nd Query
explain select * from address where postal_code not in (select postal_code from address where postal_code > 20000);

# 3rd Query
explain select a.address, c.city, co.country from address a
inner join city c on a.city_id = c.city_id
inner join country co on c.country_id = co.country_id
where a.postal_code = '35200';

create index idx_address_postal_code on address(postal_code);

# 2

explain select * from actor where first_name = "GRACE";

explain select * from actor where last_name = "SWANK";

/* The difference between the querys is that an index called 'idx_actor_last_name'
	is being called in the second query which makes it faster because it's already loaded
*/

# 3

explain select * from film where description like '%action%';

create fulltext index idx_film_description on film(description);

explain select * from film where match (description) against ('action' in boolean mode);