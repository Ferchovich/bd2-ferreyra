# 1
create view list_of_customers as
select c.customer_id, c.first_name, c.last_name, ad.address, ad.postal_code,
ad.phone, ci.city, co.country, c.store_id,
case
	when c.active = 1 then "Active"
    when c.active = 0 then "Inactive"
    end as active
from customer c
inner join address ad on c.address_id = ad.address_id
inner join city ci on ci.city_id = ad.city_id
inner join country co on co.country_id = ci.country_id;

# 2
create view film_details as 
select f.film_id, f.title, f.description, f.replacement_cost, f.rating, f.length, group_concat(distinct c.name), group_concat(a.first_name) from film f
inner join film_actor fa using(film_id)
inner join actor a using (actor_id)
inner join film_category fc using (film_id)
inner join category c using(category_id)
group by f.film_id, f.title, f.description, f.replacement_cost, f.rating;

# 3 
create view sales_by_film_category as
select c.name, count(r.rental_id) as total_rental from rental r
inner join inventory i using(inventory_id)
inner join film f using (film_id)
inner join film_category fc on fc.film_id = f.film_id
inner join category c on fc.category_id = c.category_id
group by c.name;

# 4
create view actor_information as
select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as number_of_acted_films from actor a
inner join film_actor fa using(actor_id)
group by a.actor_id, a.first_name, a.last_name;

# 5: The query would be like this its very similar to the 'actor_information' view
# it's different is that this one shows the category beside the film name, to do this it uses the group_concat
# and the concat function to do it.
select a.actor_id, a.first_name, a.last_name, group_concat(distinct concat(c.name, ": ", f.title) separator "; ") from actor a
inner join film_actor fa using(actor_id)
inner join film f using(film_id)
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
group by a.actor_id, a.first_name, a.last_name;

/* 
6: Materialized Views
What are Materialized Views?

A materialized view is a precomputed table that stores the results of a query. This precomputed data can significantly improve query performance, especially for complex or frequently executed queries.

Why Use Materialized Views?

Enhanced Performance: By precomputing results, materialized views eliminate the need for real-time query execution, leading to faster response times.
Reduced Load on Primary Database: Materialized views can offload the burden of query processing from the main database, improving overall system performance.
Real-time Reporting: Materialized views can provide up-to-date information for real-time reporting and analytics applications.
When to Use Materialized Views:

Frequently Executed Queries: If a query is executed repeatedly, a materialized view can save significant time.
Large Datasets: For large datasets, materialized views can reduce the amount of data that needs to be processed for each query.
Complex Queries: If a query involves multiple joins or aggregations, a materialized view can simplify the query and improve performance.
Alternatives to Materialized Views:

Indexes: While indexes can improve query performance for certain types of queries, they may not be as effective for complex or ad-hoc queries.
Caching: Caching can store query results in memory, but it may not be as persistent or scalable as materialized views.
Denormalization: Denormalizing data can reduce the number of joins required for certain queries, but it can also lead to data redundancy and maintenance challenges.
DBMS Support for Materialized Views:

Most modern database management systems (DBMS) support materialized views, including:

Oracle Database: Offers robust support for materialized views, including refresh methods, query rewrite rules, and partitioning.
MySQL: Introduced materialized views in version 8.0, providing features like refresh methods and query rewrite rules.
PostgreSQL: Supports materialized views with various refresh methods and query rewrite options.
SQL Server: Offers materialized views, including indexed views for improved performance.
Teradata: Provides materialized views with support for partitioning and indexing.
Key Considerations:

Refresh Strategy: Choose an appropriate refresh strategy (e.g., on-demand, periodic, incremental) based on your data update frequency and performance requirements.
Maintenance: Ensure that materialized views are kept up-to-date with changes to the underlying data.
Query Rewrite: Configure your DBMS to rewrite queries to use materialized views when appropriate.
*/