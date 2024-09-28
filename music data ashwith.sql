----Who is the senior most employee based on job title? */

SELECT title, last_name, first_name 
FROM employee
ORDER BY levels DESC
LIMIT 1

---Which countries have the most Invoices? */

SELECT COUNT(*) AS c, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC


--- What are top 3 values of total invoice? */

SELECT total 
FROM invoice
ORDER BY total DESC


--- Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
SELECT billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC
LIMIT 1;


---Who is the best customer? 
SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spending DESC
LIMIT 1;


--- Let's invite the artists who have written the most rock music in our dataset? 


SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

---Which customers top 5 generate the most revenue?
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spent DESC
LIMIT 1;

---What are the best-selling top 5 products (tracks)?
SELECT track.name, SUM(invoice_line.quantity) AS total_sold
FROM invoice_line
JOIN track ON invoice_line.track_id = track.track_id
GROUP BY track.track_id
ORDER BY total_sold DESC
LIMIT 5;

---Which  top 3 artists are the most profitable?
SELECT artist.name, SUM(invoice_line.quantity) AS total_sold
FROM invoice_line
JOIN track ON invoice_line.track_id = track.track_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
GROUP BY artist.artist_id
ORDER BY total_sold DESC
LIMIT 3;

---Which genre of music is the most popular?
SELECT genre.name, SUM(invoice_line.quantity) AS total_sold
FROM invoice_line
JOIN track ON invoice_line.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.genre_id
ORDER BY total_sold DESC;

---What are the highest-grossing media types?
SELECT media_type.name, SUM(invoice_line.unit_price * invoice_line.quantity) AS total_revenue
FROM invoice_line
JOIN track ON invoice_line.track_id = track.track_id
JOIN media_type ON track.media_type_id = media_type.media_type_id
GROUP BY media_type.media_type_id
ORDER BY total_revenue DESC;

