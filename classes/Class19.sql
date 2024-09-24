use sakila;

# 1
create user "data_analyst"@"localhost" identified by "123456";

# 2
grant select, update, delete on sakila.* to "data_analyst"@"localhost";

# 3
create table test_table (id int);

# 4
update sakila.film set title = "Dallas Buyers Club" where film_id = 1;

# 5
revoke update on sakila.* from 'data_analyst'@'localhost';

# 6
update sakila.film set title = 'Star Wars' WHERE film_id = 1;