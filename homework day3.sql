--1) List all customers who live in Texas (use JOINs):
--Write a query to retrieve the full list of customers who reside in the state of Texas. Utilize the appropriate JOIN operation to combine the necessary tables.
--answer = 5 output 
SELECT * 
FROM customer
JOIN address
ON address.address_id = customer.address_id
WHERE district = 'Texas';

SELECT count(district)
FROM address
WHERE district = 'Texas'
--2) Get all payments above $6.99 with the Customer's Full Name:
--Create a query that fetches all payment records where the payment amount exceeds $6.99. Additionally, include the full name of the customer associated with each payment
--answer = 1406 output
SELECT concat( first_name, ' ', last_name)
FROM customer
JOIN payment
ON  payment.customer_id = customer.customer_id
WHERE amount > 6.99;
--3) Show all customer names who have made payments over $175 (use subqueries):
--Construct a query to display the names of customers who have made payments exceeding $175. Employ subqueries to achieve this result.
-- answer = 6 output
SELECT CONCAT(first_name, ' ', last_name), customer_id
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY DISTINCT customer_id
	HAVING SUM(amount) > 175
);

--4) List all customers that live in Nepal (use the city table):
--Formulate a query to list all customers who reside in Nepal. You will need to utilize the city table in your query.
--answer = 1 output
SELECT * 
FROM customer
JOIN address
ON address.address_id = customer.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal';

SELECT *
FROM country
--5) Which staff member had the most transactions?
--Write a query to determine the staff member who conducted the highest number of transactions. Consider the appropriate tables for this task.
--answer= staf MEMBER 2
SELECT COUNT(payment_id), staff.staff_id, CONCAT(first_name, ' ', last_name) AS "fullname"
FROM payment
JOIN staff
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;
--6) How many movies of each rating are there?
--Create a query that counts the number of movies for each distinct rating. Your query should display the rating category along with the corresponding count.
--answer: 5 rating with 223 higest for pg-13 and 178 lower for G rating
SELECT count(film_id),rating  
FROM film
GROUP BY  rating;


--7) Show all customers who have made a single payment above $6.99 (Use Subqueries):
--Construct a query to retrieve the names of customers who have made only one payment, and the payment amount exceeds $6.99. Utilize subqueries to accomplish this task.
--answer 992

SELECT DISTINCT last_name, amount
FROM customer 
JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
AND customer.customer_id in
(SELECT customer_id
FROM payment 
WHERE amount > 6.99);

SELECT amount FROM payment
WHERE amount > 6.99
--8) How many free rentals did our stores give away?
--Write a query to calculate the total number of free rentals given away by our stores.
--answer = 24
SELECT count(amount)
FROM payment
WHERE amount = 0;