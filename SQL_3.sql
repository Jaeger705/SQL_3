
-- Question 1 Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hadison, and Ian Still
select c.customer_id, c.first_name, c.last_name, c.email, a.district
from customer AS c
JOIN address AS a ON c.address_id = a.address_id
where a.district = 'Texas';

--Question 2 too many to list
SELECT
    p.payment_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    p.amount,
    p.payment_date
from payment AS p
JOIN customer AS c ON p.customer_id = c.customer_id
where p.amount > 6.99;

   
--Question 3 Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Peter Menard, Tommy Collazo, Karl Seal    
   SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name
from customer AS c
WHERE
    c.customer_id IN (
        SELECT
            p.customer_id
        FROM
            payment AS p
        GROUP BY
            p.customer_id
        HAVING
            SUM(p.amount) > 175
    );
    
   
--Question 4 only one person is in Nepal Kevin Schuler
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.email,
    ci.city
from customer AS c
INNER JOIN address AS a ON c.address_id = a.address_id
INNER JOIN city AS ci ON a.city_id = ci.city_id
INNER JOIN country AS co ON ci.country_id = co.country_id
where co.country = 'Nepal';

   
--Quesion 5 Jon Stephens with a total count of 7,304
SELECT
    s.staff_id,
    s.first_name,
    s.last_name,
    COUNT(p.payment_id) AS transactions_count
from staff AS s
JOIN payment AS p ON s.staff_id = p.staff_id
GROUP by s.staff_id, s.first_name, s.last_name
ORDER BY
    transactions_count DESC
LIMIT 1;

--Question 6 NC-17 210, PG 194, G 178, PG-13 223, R 195
SELECT
    rating,
    COUNT(film_id) AS count
FROM
    film
GROUP BY
    rating;
   
--Question 7 130 customers
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
from customer AS c
WHERE
    c.customer_id IN (
        SELECT
            p.customer_id
        FROM
            payment AS p
        WHERE
            p.amount > 6.99
        GROUP BY
            p.customer_id
        HAVING
            COUNT(p.payment_id) = 1
    );

--Question 8 number of free rentals is 1,476
SELECT COUNT(*)
FROM (
    SELECT rental_id
    FROM payment
    WHERE amount = 0

    UNION

    SELECT r.rental_id
    FROM rental r
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    WHERE p.payment_id IS NULL
) AS free_rentals;
