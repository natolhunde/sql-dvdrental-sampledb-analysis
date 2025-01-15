
-------------------------------------------+++ GROUP 2+++---------------------------------------------------------------
                                            ----Enguday----
                                             ---Hemela---
				                               --Natol--
												  
========================================================================================================================

-------------------------------Section 1: DML (Data Manipulation Language) – 5 Questions--------------------------------

=========================================================================================================================


________________________________________________________DML#1____________________________________________________________

1--Insert a New Customer Record:Insert a new customer with appropriate details (e.g., first name, last name, email, address, city) into the customer table.

/* Our SQL code performs a series of database operations within a single transaction.it executes a transaction that 
adds a new country, city, address, and customer to their respective tables in a database. It ensures data consistency 
by linking the new entries appropriately across tables.The transaction is then committed to make the changes permanent.
*/

/*
BEGIN TRANSACTION
This starts a transaction. A transaction is a way to group multiple SQL operations so that they either all succeed or all fail. 
If something goes wrong during any of the operations, none of the changes will be saved to the database.
COMMIT TRANSACTION
This commits the transaction, making all changes made during the transaction permanent. 
If the transaction had failed or been rolled back, none of the changes would be applied.*/


BEGIN TRANSACTION; --Begins a transaction to ensure all inserts are completed together.

INSERT INTO country (country_id, country, last_update)
VALUES (120, 'ETHIOPIA', CURRENT_TIMESTAMP);--Inserts a new country (Ethiopia) into the country table.

INSERT INTO city (city_id, city, country_id, last_update)
VALUES (606, 'Baltimore', 120, CURRENT_TIMESTAMP);--Inserts a new city (Baltimore) into the city table, linked to the new country.

INSERT INTO address (address_id, address, address2, district, city_id, postal_code, phone, last_update)--Inserts a new address into the address table.
VALUES (618, '123 dale st', '', 'Barris3', 399, '21201', '8322061177', CURRENT_TIMESTAMP);

INSERT INTO customer (customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active)
VALUES (620, 1, 'Teka4', 'Adane5', 'tekal5@yahoo.com', 616, TRUE, CURRENT_DATE, CURRENT_TIMESTAMP, 1);--618>>619----Inserts a new customer into the 
--customer table, linked to the new address.
 
COMMIT TRANSACTION; --Commits the transaction.


------------------------------------------------Verifing the insertions------------------------------------------------------------------------------------------

SELECT *
FROM country
WHERE country_id = 120


SELECT *
FROM address
WHERE address_id= 618
___________________________________________________________DML#2_____________________________________________________________________________

2--Update Customer Email: Update the email address of an existing customer by their customer ID.

/* Our sql code to the question above updates the email address of a specific customer in the customer table 
by setting the email column to 'MAerie@gmail.com'. 
The update is targeted at the customer identified by customer_id 600, ensuring that only this particular record is modified.*/

UPDATE customer --'UPDATE' specifies that we're modifying data in the 'customer' table.
SET email='MAerie@gmail.com'--defines the change we're making. We're set the 'email' column to a new value 'MAerie@gmail.com'.
WHERE customer_id=600;--Identifies which customer to update.

___________________________________________________________DML#3_______________________________________________________________________________

3--Delete a Rental Record: Delete a rental record from the rental table by specifying the rental ID.

/*In summary, our SQL quary below deletes a single record from the rental table, specifically the one with a rental_id of 7. 
It's a targeted deletion that affects only one row, leaving all other records in the table untouched.*/

DELETE-- remove records from a database table
FROM rental----Specifies the table from which you want to delete records.
WHERE rental_id = 7; --Determines which record will be deleted.

-----Testing if Specified record is deleted-------

SELECT * 
FROM rental;
_________________________________________________________DML#4____________________________________________________________________

4--Increase Film Rental Duration: Update the rental duration of a specific film in the film table, increasing it by 2 days.

/*Our SQL code below updates a specific record in the film table by increasing the rental_duration by 2 days. 
The change is applied exclusively to the film identified by film_id '133', ensuring that only this particular
record is modified while all other records remain unchanged.*/


UPDATE film --Specifies the film table is to be updated.
SET rental_duration=rental_duration + 2 --Defines what needs to be changed,rental_duration is being increased by 2 days.
WHERE film_id='133'; --Determines which specific record will be updated. the film with film_id of '133' is being updated.

-----Testing if Specified record is updated -------

SELECT * 
FROM film;


_________________________________________________________DML#5___________________________________________________________________

5--Insert a New Film Record: Insert a new film with appropriate details (e.g., title, description, rental rate, length) into the film table.

/*In summary,our SQL code below inserts a new record into the film table for a movie titled "Ethiopia hagrie," 
detailing its attributes such as description, release year, rental information, and rating. 
The film_id is set to 1006, the last_update field is populated with the current timestamp, and special features are listed as '{Trailers}'.*/

INSERT INTO film(film_id,title,description,release_year,language_id,rental_duration,rental_rate,length,replacement_cost,rating,last_update,special_features,fulltext)
VALUES(1006,'Ethiopia hagrie','A Amazing ethiopian history',2024,1,3,10.99,120,20.99,'G',Now(),'{Trailers}',null) --inserts a new row into the film table.

       ------------Verify if the new film was successfully inserted into the database-------------------
	   
SELECT *
FROM film
WHERE film_id=1006;


==============================================================================================================================

 
  --------------Section 2: DQL (Data Query Language or Querying for Analysis) – 15 Questions---------------------------

  
===============================================================================================================================

___________________________________________________DQL#1____________________________________________________________
  
1--List All Films: Retrieve a list of all films with their titles, release year, and rental rates.


/*We used SELECT clause to retrieves specific information from the film table in a database. Our quary selects and displays the title, 
release year, and rental rate for all films in the database, providing a basic overview of the film catalog.*/

SELECT title,release_year,rental_rate
FROM film;
____________________________________________________DQL#2____________________________________________________

2--Find the Most Rented Film: Write a query to find the film that has been rented the most times.

/*Our query joins three tables to gather data about films and their rentals.
It counts how many times each film has been rented.
It sorts the films by rental count in descending order.
Finally, it returns only the top result, which is the most rented film.*/

SELECT title,COUNT(r.rental_id) as Most_rented  --Counts how many times film has been rented.
FROM film f 
JOIN inventory inv ON f.film_id = inv.film_id --Joines the film, inventory, and rental table connect films with their rental records.
JOIN rental r ON inv.inventory_id = r.inventory_id
GROUP BY title--Grouped the results by title to count rentals for each unique film.
ORDER BY Most_rented DESC --Ordered the results by the rental count in descending order, so the most frequently rented film appears first.
LIMIT 1;-- Returns only the top result, which is the most rented film.

____________________________________________________DQL#3____________________________________________________

3--Find Customers Who Have Never Rented a Movie: Retrieve the list of customers who have never rented any movie.

/* To find customers who have never rented any movie we left joined each customer with their rentals.
Which keeps customers who have no matching rentals.
It then filters to keep only those with no rentals.Finally, it counts and groups these customers.*/


SELECT first_name,last_name,COUNT(r.rental_id) AS Never_rented --Chooses the columns to display , and counts customers who have never rented any movie
FROM customer cu
LEFT JOIN rental r on cu.customer_id= r.customer_id--Connects customer data with rental data, keeping all customers even if they have no rentals.
WHERE rental_id IS NULL --Filters for customers with no rentals
GROUP BY first_name,last_name --Groups the results by customer name.


____________________________________________________DQL#4____________________________________________________

4--Top 5 Actors by Film Count: List the top 5 actors who have appeared in the most films.

/*To List the top 5 actors who have appeared in the most films, we linked actors to their film appearances using the film_actor table.
We counted how many films each actor has been in.We then grouped the results by actor name and sorted by the film count.
Only the top 5 actors with the highest film counts are shown.*/

SELECT first_name,last_name,
    COUNT(film.film_id) as total_film_count--Counts the no. of unique films each actor has appeared in. 
FROM actor
JOIN film_actor ON actor.actor_id=film_actor.actor_id--Connects actor data with film_actor and film tables.
JOIN film ON film_actor.film_id=film.film_id
GROUP BY first_name,last_name--Groups the results by actor's name.
ORDER BY total_film_count DESC-- Sorts the results by film count in descending order.
LIMIT 5;--Restricts the output to only the top 5 results.


____________________________________________________DQL#5____________________________________________________

5--Total Revenue by Film: Calculate the total revenue generated by each film based on its rental rates and rental history.

/*Our query calculates the total revenue generated by each film from rental payments, 
joining multiple tables to connect films to their rentals and payments. 
The results are sorted to show the highest-grossing films first.*/

SELECT f.film_id,f.title,
    SUM(amount) as total_revenue--Specifies the columns we want in our result set and calculates sum of amounts. 
FROM film f
JOIN inventory inv on f.film_id=inv.film_id--Joins the inventory table with the film table, connecting each film to its inventory entries.
JOIN rental r on inv.inventory_id=r.inventory_id--Joins the rental table with the inventory table, linking each inventory item to its rental records.
JOIN payment pa on r.rental_id=pa.rental_id--Joins the payment table with the rental table, connecting each rental to its payment record.
GROUP BY f.film_id,f.title--This groups the results by film_id and title
ORDER BY total_revenue DESC;--This sorts the results in descending order of total_revenue, so the highest-grossing films appear first.

____________________________________________________DQL#6_____________________________________________________

6--Average Rental Duration per Category: Find the average rental duration for films in each category.

/*TO find the average rental duration for films in each category, we connected films to their 
categories using the film_category table.
For each category, we calculated the average rental duration of all associated films.
We used ROUND function is used to limit the average to two decimal places. And then
results are grouped by category and sorted with the highest average duration first.*/

SELECT ca.category_id,ca.name, ---Selects category_id and name from the category table.
ROUND(AVG(rental_duration),2) AS avg_rental_duration--Calculates the average rental duration, rounded to 2 decimal places.
FROM category ca
JOIN film_category fc on ca.category_id=fc.category_id--Joins with film_category (fc) to link categories to films.
JOIN film f on fc.film_id=f.film_id--Then joins with the film table (f) to access film details.
GROUP BY ca.category_id,ca.name--Groups the results by category_id and name.
ORDER BY avg_rental_duration desc;--Sorts the results by average rental duration in descending order.

____________________________________________________DQL#7____________________________________________________

7--Customers with Most Rentals: Retrieve the top 10 customers who have rented the most films.

/*Our quary to retrieve the top 10 customers who have rented the most films connects customers 
to their rental records.For each customer, it counts the total number of rentals. And then
results are grouped by customer and sorted with the highest rental count first.
Only the top 10 customers are shown.*/

SELECT c.customer_id, c.first_name, c.last_name, --Selects customer_id, first_name, and last_name from the customer table.
COUNT(r.rental_id) AS total_rental--Counts the number of rentals for each customer.
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id--Joins with the rental table (r) to link customers to their rentals.
GROUP BY c.customer_id, c.first_name, c.last_name--Groups the results by customer (using ID and name).
ORDER BY total_rental DESC--Sorts the results by total rentals in descending order.
LIMIT 10;--Restricts the output to only the top 10 results.
____________________________________________________DQL#8____________________________________________________

8--Films Not Rented in the Last 6 Months: List all films that have not been rented in the last 6 months.

/* Our SQL query retrieves film titles and their rental dates, calculating the time since each rental as of '2006-02-14 15:16:03'. 
It joins film, inventory, and rental tables to find films that either have never been rented or
films that have not been rented in the last 6 months from the specified date. 
The results are ordered by the time elapsed since the last rental*/

--First, we filtered for the most recent or latest date a rental was made by using the following query:

SELECT MAX(rental_date) as latest_rental_date
FROM rental;
--#Output '2006-02-14 15:16:03'

-------------------------------------------------------------------------------------------------------------------------

--We then used the latest rental date to narrowed down the results to show only films that hadn't been rented within the past 6 months. 

/*The AGE() function is used to calculate the difference between two dates or timestamps. 
It returns an interval that represents the difference in terms of years, months, and days.*/

SELECT DISTINCT f.title, r.rental_date,'2006-02-14 15:16:03' as todays_date,
AGE('2006-02-14 15:16:03', rental_date) as age_since_rental--It calculates the age between '2006-02-14 15:16:03' and the rental_date.      
  FROM film f
JOIN inventory i ON f.film_id = i.film_id--Joins the inventory table with the film table.
JOIN rental r ON i.inventory_id = r.inventory_id--Joins the rental table with the inventory table.
WHERE r.rental_id IS NULL OR --Filters for films that either have never been rented  or                                                                      
  AGE('2006-02-14 15:16:03', rental_date) >= '6 mons 0 days 00:00:00'--Were last rented 6 months or more ago from the specified date.
ORDER BY age_since_rental;--Orders the results by the time since the last rental.


____________________________________________________DQL#9____________________________________________________
 
 9--SELECT revenue by Store: Calculate the total rental revenue generated by each store.

/* Our query calculates the total revenue generated by each store. 
It does this by joining multiple tables to connect stores, staff members, and payments. 
Then, it sums up the payment amounts for each store to determine its total revenue.*/

SELECT s.store_id,SUM(amount) AS total_revenue--Calculates the sum of the amount column in the payment table.
FROM store s
JOIN staff ON s.store_id=staff.store_id--This joins the staff table to the store table based on the store_id
JOIN payment pa ON staff.staff_id=pa.staff_id--Joins the payment table to the staff table based on the staff_id.
GROUP BY s.store_id;--This groups the results by the store_id column.

____________________________________________________DQL#10____________________________________________________

10--Longest Rental Period: Find the longest rental period for any film.

/*Our quary joins rental, inventory, and film tables to calculate the maximum duration a film was kept by any customer. 
The results, sorted by longest rental period*/

SELECT f.film_id,f.title, 
  MAX(r.return_date - r.rental_date) AS longest_rental_period--Calculates the longest rental period for each film.
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id--Joins the inventory table using the inventory_id to rentals table.
JOIN film f ON i.film_id = f.film_id--Joins's the film table to connect inventory items with their corresponding films.
GROUP BY f.film_id,f.title--Groups the results by f.film_id and f.title.
ORDER BY longest_rental_period DESC;--Orders the results in descending order

____________________________________________________DQL#11____________________________________________________

11--Customers Renting in Multiple Stores: List customers who have rented from both store locations

/*Our query effectively identifies customers who have rented movies from multiple stores. 
It joins multiple tables to gather customer information, rental history, and store details. 
By grouping and counting the distinct stores for each customer, it filters the results to show only 
those customers who have rented from from both stores.*/

SELECT c.customer_id, c.first_name, c.last_name,---Counts number of different stores a customer has rented from
  COUNT(DISTINCT s.store_id) as rented_both_store
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id--Joins the rental table to connect customers to their rental history.
JOIN inventory i ON r.inventory_id = i.inventory_id--Joins the inventory table to link rentals to specific inventory items.
JOIN store s ON i.store_id = s.store_id--Joins the store table to associate inventory items with their respective stores.
GROUP BY c.customer_id, c.first_name, c.last_name--Groups the results by customer ID, first name, and last name.
HAVING COUNT(DISTINCT s.store_id) = 2 ;--Filters the results to include only customers who have rented from both stores.

____________________________________________________DQL#12____________________________________________________

12--Films Rented More Than 5 Times: Retrieve a list of films that have been rented more than 5 times.

/* Our query counts the number of rentals for each film by joining the film, inventory, and rental tables. 
It filters the results to include only films that have been rented more than five times and orders the output by rental count.*/

SELECT f.film_id,f.title,
    COUNT(r.rental_id) AS rental_count--counts the number of rentals for each film.
FROM film f
JOIN  inventory i ON f.film_id = i.film_id-- Joins the film, inventory, and rental tables to connect films with their rental records.
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title --Grouped the results by film_id and title to count rentals for each unique film.
HAVING COUNT(r.rental_id) > 5 -- filters for films with more than 5 rentals.
ORDER BY rental_count; --Orders the results by the rental count.

____________________________________________________DQL#13____________________________________________________

13--Total Number of Rentals per Category: For each film category, count the total number of rentals.

/* Our quary below calculates the total number of rentals for each film category by joining the category, 
film_category, film, inventory, and rental tables. 
It groups the results by category and orders them by the total rental count*/

SELECT c.category_id,c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals--Counts the number of rentals for each category
FROM 
    category c
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id--Joined the necessary tables:
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY c.category_id, c.name--Grouped the results by category_id and category name.
ORDER BY total_rentals;--Ordered the results by the total number of rentals

____________________________________________________DQL#14____________________________________________________

14--Customers Renting the Same Film Multiple Times: Find customers who have rented the same film more than once.

/* Our query below identifies customers who have rented the same film multiple times 
by joining the customer, rental, inventory, and film tables. It groups the results by customer and 
film title, then filters to show only cases where
a customer has rented a specific film more than once.*/

SELECT c.customer_id, f.title, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id---JOINs with rental to connect customers with their rentals.
JOIN inventory i ON r.inventory_id = i.inventory_id--JOINs with inventory to link rentals with specific inventory items.
JOIN film f ON i.film_id = f.film_id--JOINs with film  to get the film details for each rental.
GROUP BY c.customer_id, f.title--Groups the results by c.customer_id and f.title.
HAVING COUNT(r.rental_id) > 1;--filters the results to only show instances where a customer has rented
                                --the same film more than once.

____________________________________________________DQL#15________________________________________________________________________________

15--Actors Who Have Not Appeared in Any Film: List actors from the actor table who have not appeared in any film.

/*This query identifies actors in the database who are not associated with any films. 
It does this by finding actors whose IDs don't appear in the film_actor table, 
effectively listing actors who have never been cast in a movie in the database.*/

SELECT a.actor_id, a.first_name, a.last_name--Selects actor_id, first_name, and last_name from the actor table.
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id--A LEFT JOIN keeps all records from the left table (actor) even if there's no match in the right table (film_actor).
WHERE fa.film_id IS NULL;--filters for cases where there's no matching entry in the film_actor table.


===========================================================END===================================================================================





