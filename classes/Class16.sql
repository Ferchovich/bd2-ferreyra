					USE sakila;
INSERT INTO employees (employeeNumber, firstName, lastName, email, jobTitle) 
VALUES (1002, 'Javier', 'Guirmard', NULL, 'Sales Rep');

# Si la columna de email en la tabla employees esta definida con la constraint NOT NULL
# no puede ser asignada como NULL

-- Primera query:
UPDATE employees SET employeeNumber = employeeNumber - 20;

-- Segunda query:
UPDATE employees SET employeeNumber = employeeNumber + 20;

ALTER TABLE employees ADD age INT CHECK ( age BETWEEN 16 AND 70);

ALTER TABLE employees ADD lastUpdate datetime;
ALTER TABLE employees ADD lastUpdateUser VARCHAR(100);

DELIMITER //
CREATE TRIGGER employees_before_update
    BEFORE UPDATE ON employees
    FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END; //

CREATE TRIGGER employees_before_insert
    BEFORE INSERT
    ON employees
    FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END;
DELIMITER ;


create trigger customer_create_date
    before insert
    on customer
    for each row
    SET NEW.create_date = NOW();

create trigger del_film
    after delete
    on film
    for each row
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END;

create trigger ins_film
    after insert
    on film
    for each row
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
END;

create trigger upd_film
    after update
    on film
    for each row
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END;



create trigger payment_date
    before insert
    on payment
    for each row
    SET NEW.payment_date = NOW();

