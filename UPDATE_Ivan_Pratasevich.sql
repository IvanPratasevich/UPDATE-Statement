-- 1) Alter the rental duration and rental rates of the film you inserted before to three weeks and 9.99, respectively.
UPDATE film
SET rental_duration = 21, 
    rental_rate = 9.99
WHERE title = 'Den of Thieves';


-- Verification

-- SELECT *
-- FROM film
-- ORDER BY last_update DESC
-- LIMIT 1;

-- 2) Alter any existing customer in the database with at least 10 rental and 10 payment records.
-- 	  Change their personal data to yours (first name, last name, address, etc.).
--    You can use any existing address from the "address" table.
--    Please do not perform any updates on the "address" table, as this can impact multiple records with the same address.


SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(customer_id) >= 10
)
AND customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(customer_id) >= 10
)
LIMIT 5;

WITH cte_address AS (
    SELECT address_id
    FROM address
    LIMIT 1
	OFFSET 4
)

UPDATE customer
SET first_name = 'Ivan',
    last_name = 'Pratasevich',
    email = 'ivan.student@student.com',
    address_id = (SELECT address_id FROM cte_address),
    create_date = CURRENT_DATE
WHERE customer_id = 3;