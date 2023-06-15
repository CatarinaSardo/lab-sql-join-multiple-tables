-- Write a query to display for each store its store ID, city, and country.

select s.store_id, a.city_id, c.city, c.country_id, co.country
from store s
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id
join country co on c.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.

select s.store_id, c.city, co.country, sum(p.amount) as total_sales
from store s
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id
join country co on c.country_id = co.country_id
join staff st on s.store_id = st.store_id
join payment p on st.staff_id = p.staff_id
group by s.store_id, c.city, co.country;

-- What is the average running time of films by category?

select c.name as category, avg(f.length) as average_running_time
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.name;

-- Which film categories are longest?

select c.name as category, avg(f.length) as average_running_time
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by average_running_time desc;

-- Display the most frequently rented movies in descending order.

select f.film_id, f.title, count(*) as rental_count
from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by f.film_id, f.title
order by rental_count desc;

-- List the top five genres in gross revenue in descending order.

select c.name as genre, sum(p.amount) as gross_revenue
from film_category fc
join film f on fc.film_id = f.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
join category c on fc.category_id = c.category_id
group by c.name
order by gross_revenue desc
limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1?

select f.title, s.store_id
from film f
join inventory i on f.film_id = i.film_id
join store s on i.store_id = s.store_id
left join rental r on i.inventory_id = r.inventory_id
where f.title = 'Academy Dinosaur' and s.store_id = 1 and r.return_date is null;