#1
use sakila;
drop procedure if exists countNumberOfFilms;
delimiter //
create procedure countNumberOfFilms(in storeId int, in filmId int)
	begin
		select f.title, count(inv.inventory_id) as count_of_films, inv.store_id from film f
		inner join inventory inv on inv.film_id = f.film_id
		where f.film_id = filmId
		and inv.store_id = storeId
		group by f.title, inv.store_id;
	end //
delimiter ;

call countNumberOfFilms(2, 5);
# 2
drop procedure if exists getListOfCustomer;
delimiter //
create procedure getListOfCustomer(in countryName varchar(100), out listOfCustomer varchar(255))
	begin
    
		declare finished integer default 0;
        declare selectedCustomer varchar(255) default "";
        declare customerCursor cursor for select concat(c.first_name, " " , c.last_name) as customer from customer c
		inner join address ad on ad.address_id = c.address_id
		inner join city ci on ci.city_id = ad.city_id
		inner join country co on co.country_id = ci.country_id
		where co.country = countryName;
        
        
        declare continue handler
        for not found set finished = 1;
        
		set listOfCustomer = "";
        open customerCursor;
        addCustomersToString: loop
			fetch customerCursor into selectedCustomer;
            
            if finished = 1 then
				leave addCustomersToString;
			end if;
            if not selectedCustomer is null then
            
				set listOfCustomer = concat(listOfCustomer, ";", selectedCustomer);
			end if ;
		end loop addCustomersToString;
        close customerCursor;
        select listOfCustomer;
    end //
delimiter ;
set @listOfCustomer = "";
call getListOfCustomer("Colombia", @listOfCustomers);

select @listOfCustomers;
-- 3 Review the function inventory_in_stock and the procedure 'film_in_stock' explain the code, write usage examples
/*
The function 'inventory_in_stock' returns whether the film set by parameters has stock
And the procedure film_in_stock returns how many copies are left of a film in a certain store

*/



