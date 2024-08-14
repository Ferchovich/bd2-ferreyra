/*
Write the statements with all the needed subqueries, do not use hard-coded ids unless is specified. Check which fields are mandatory and which ones can be ommited (use default value).

Add a new customer

To store 1
For address use an existing address. The one that has the biggest address_id in 'United States'
Add a rental

Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
Select any staff_id from Store 2.
Update film year based on the rating

For example if rating is 'G' release date will be '2001'
You can choose the mapping between rating and year.
Write as many statements are needed.
Return a film

Write the necessary statements and queries for the following steps.
Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
Use the id to return the film.
Try to delete a film

Check what happens, describe what to do.
Write all the necessary delete statements to entirely remove the film from the DB.
Rent a film

Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
Add a rental entry
Add a payment entry
Use sub-queries for everything, except for the inventory id that can be used directly in the queries.
Once you're done. Restore the database data using the populate script from class 3.

*/
use sakila;
insert into customer (store_id, address_id, first_name, last_name, email)
values (1,(
	select max(address_id) from address ad
    inner join city c on c.city_id = ad.city_id
    inner join country co on c.country_id = co.country_id
    where co.country = 'United States'
), "Octavio", "Ferreyra", "ferreyra@gmail.com");


#ANNIE IDENTITY

insert into rental (rental_date, inventory_id, staff_id, customer)
values (now(),(
	select inventory_id from inventory i 
    inner join film f on f.film_id=i.film_id
    where f.title = 'ANNIE IDENTITY' limit 1
), (
	select max(staff_id) from staff where store_id=2), 300);
    

update film set release_year = '1990' where rating = "G"; 
update film 