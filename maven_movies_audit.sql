-- Maven Movies Project: Policy Update -- 

/* 
1. Please provide a list of all staff members, including their first and last names,
email addresses, and the store identification number where they work. 
*/


SELECT 
	first_name, 
    last_name,
    email, 
    store_id
FROM staff;

/* 
2. We will need separate counts of inventory items held at each location
*/ 

SELECT 
	store_id,
    COUNT(inventory_id) AS items
FROM inventory
GROUP BY
	store_id;

/* 
3. We will also need a count of active customers for each store. 
*/ 

SELECT 
    store_id,
    COUNT(CASE WHEN active = 1 THEN customer_id END) AS active_customers
FROM customer
GROUP BY 
	store_id
ORDER BY 
	store_id;

/*
4. Include a count of all customer emails to assess liability of a data breach
*/ 

SELECT 
    COUNT(email) AS total_emails
FROM customer;

/*
5. The team wants a count of unique film titles in inventory at each store and a count of unique categories
*/ 

SELECT 
	store_id,
    COUNT(DISTINCT film_id) AS unique_films
	
FROM inventory
GROUP BY
	store_id;
    
SELECT 
	COUNT(DISTINCT name) AS number_of_categories
FROM category;

/*
6. We would like to understand the replacement cost of films. Please provide the least and most expensive replacements, 
and the average rental cost for all inventory. 
*/ 

SELECT 
    MIN(replacement_cost) AS least_expensive_to_replace,
    MAX(replacement_cost) AS most_expensive_to_replace,
    ROUND(AVG(replacement_cost),2) AS average_replacement_cost
FROM film;

/* 
7. What are the maximum payment processing restrictions in place to minimize risk of fraud? 
Please provide the average payment processed, as well as maximum payment processed in either store. 
*/ 

SELECT
	ROUND(AVG(amount),2) AS average_transaction_amount,
    MAX(amount) AS highest_transaction_amount
FROM payment;

/*
8. To help better understand the customer base, please provide a list of all customer identification-
values, with a count of rentals they have made all-time, sorting by the highest volume customers 
*/ 

SELECT
	customer_id,
    COUNT(CASE WHEN rental_id > 0 THEN customer_id END) AS total_rentals_by_customer
FROM rental
GROUP BY
	customer_id
ORDER BY
	COUNT(rental_id) DESC;

	
