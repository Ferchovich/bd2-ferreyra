# Class 07 - Ferreyra Octavio

# 1
select f1.title, f1.length, f1.rating from film f1
where f1.length <= all (select f2.length from film f2 where f1.film_id <> f2.film_id);

# 2
select f1.title, f1.length, f1.rating from film f1
where f1.length <= all (select f2.length from film f2 where f1.film_id <> f2.film_id)
and not exists (select * from film f2 where f1.film_id <> f2.film_id and f2.length <= f1.length); 

# 3
select c.first_name,min(p.amount),a.address from payment p
inner join customer c on c.customer_id=p.customer_id
inner join address a on c.address_id=a.address_id 
group by p.customer_id;

# 4
select c.*, (select max(p.amount) from payment p where c.customer_id=p.customer_id) as highest, 
(select min(amount) from payment p where c.customer_id=p.customer_id) as lowest from customer c;
