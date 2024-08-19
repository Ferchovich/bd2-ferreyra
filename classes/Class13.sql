
use sakila;
#1
insert into customer (store_id, address_id, first_name, last_name, email)
values (1,(
	select max(address_id) from address ad
    inner join city c on c.city_id = ad.city_id
    inner join country co on c.country_id = co.country_id
    where co.country = 'United States'
), "Octavio", "Ferreyra", "ferreyra@gmail.com");



#2
insert into rental (rental_date, inventory_id, staff_id, customer)
values (now(),(
	select inventory_id from inventory i 
    inner join film f on f.film_id=i.film_id
    where f.title = 'ANNIE IDENTITY' limit 1
), (
	select max(staff_id) from staff where store_id=2), 300);
    
#3
update film set release_year = '1990' where rating = "G"; 
update film SET release_year = '1991' WHERE rating = "PG";
update film SET release_year = '1992' WHERE rating = "PG-13";
update film SET release_year = '1994' WHERE rating = "R";

#4
update rental 
set return_date=now()
where rental_id=(select max(rental_id) where return_date is null);

#5
delete from film where film_id=1;
delete from film_actor where film_id=1;
delete from film_category where film_id=1;
delete from rental where inventory_id in (select inventory_id from inventory where film_id=1);
delete from inventory where film_id=1;
delete from film where film_id=1;
select * from film order by film_id asc;

#6
select inventory_id from inventory i left outer join rental r using(inventory_id) where r.rental_id is null limit 1;
insert into rental (rental_date,inventory_id,customer_id,staff_id) values (
	NOW(), 
	(4587), 
    (SELECT customer_id FROM customer LIMIT 1), 
    (SELECT staff_id FROM staff LIMIT 1));
    
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
    (SELECT customer_id FROM rental WHERE inventory_id = 4587 LIMIT 1),
    (SELECT staff_id FROM rental WHERE inventory_id = 4587 LIMIT 1),   
    (SELECT max(rental_id) FROM rental WHERE inventory_id = 4587),  
    466.43, 
    NOW() 
);



