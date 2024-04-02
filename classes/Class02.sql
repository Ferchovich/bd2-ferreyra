# Class 02 - Ferreyra Octavio

drop database if exists imdb;

create database imdb;
use imdb;

create table film (
	film_id int not null auto_increment primary key,
	title varchar (50) not null,
    description text,
    release_year int not null
);

create table actor (
	actor_id int not null auto_increment primary key,
    first_name varchar(10) not null,
    last_name varchar(10) not null
);

create table film_actor (
	actor_id int not null,
    film_id int not null,
    
    constraint film_actor_pk primary key (actor_id, film_id)
);

# Alter table add column last_update to film and actor

alter table film
	add last_update date not null;
    
alter table actor
	add last_update date not null;
    
# Alter table add foreign keys to film_actor table
alter table film_actor
	add constraint film_id_fk foreign key (film_id) references film (film_id),
	add constraint actor_id_fk foreign key (actor_id) references actor (actor_id);

-- Inserts para la tabla actor
INSERT INTO actor (first_name, last_name, last_update) VALUES
('Johnny', 'Depp', '2024-04-02'),
('Leonardo', 'DiCaprio', '2024-04-01'),
('Scarlett', 'Johansson', '2024-03-31'),
('Tom', 'Hanks', '2024-03-30'),
('Emma', 'Watson', '2024-03-29');

-- Inserts para la tabla film
INSERT INTO film (title, description, release_year, last_update) VALUES
('Pirates of the Caribbean', 'Adventure film about pirates.', 2022, '2024-03-28'),
('Inception', 'Science fiction heist thriller film.', 2023, '2024-03-27'),
('Lost in Translation', 'Drama film about two strangers in Tokyo.', 2022, '2024-03-26'),
('Forrest Gump', 'Comedy-drama about a man with a low IQ.', 2021, '2024-03-25'),
('Harry Potter and the Philosopher''s Stone', 'Fantasy film about a young wizard.', 2022, '2024-03-24');

-- Inserts para la tabla film_actor
INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

