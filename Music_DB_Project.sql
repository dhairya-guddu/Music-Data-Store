-- who is the senior most employee based on job title?

select top 1 * from employee
order by levels desc

-- which countries has the most invoices?

select top 1 billing_country, count(*) as maxim from invoice
group by billing_country
order by maxim desc

-- what are the top 3 values of total invoices

select distinct top 3 total from invoice
order by total desc

-- which city has the best customers - query that returns one city that has the highest sum of invoice totlas.

select top 1 billing_city, sum(total) as sum from invoice
group by billing_city
order by sum desc

-- who is the best customer - the customer who has spent the most money

select top 1 c.customer_id, sum(i.total) as sum, c.first_name, c.last_name 
from customer as c
join invoice as i
on c.customer_id = i.customer_id
group by c.customer_id, c.first_name, c.last_name
order by sum desc

-- moderate questions
-- select email, first name, last name of the customer that like classical music
select distinct email, first_name, last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
	select track_id from track
	join genre on track.genre_id = genre.genre_id
	where genre.name Like 'Classical')
order by email

-- or --

select distinct email, first_name, last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name Like 'Classical'
order by email


-- select top 10 artist name according the number of songs

select distinct top 10 artist.name, count(artist.artist_id) as no_of_songs from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
where genre_id = 1
group by artist.artist_id, artist.name
order by no_of_songs desc


-- filter the track that has song length more than the average song length

select track.name, milliseconds from track
where milliseconds > (
select avg(milliseconds) as avrg from tracK)
order by milliseconds desc