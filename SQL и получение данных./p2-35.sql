������� ' ' �� " " 

' ' - ������ 
" " - �������� ��������

dvd-rental

select pg_typeof('01/01/2021'::date::timestamp::text)

numeric varchar

����������������� �����

select "name"
from "language" 

select "select"
from "from"

���������� ������� ���������� SELECT

FROM
ON
JOIN
WHERE
GROUP BY
WITH CUBE ��� WITH ROLLUP
HAVING
SELECT <-- ��������� ������ (����������)
OVER
DISTINCT
ORDER by

select - ������ ����� ��� ������� � �������� �������� ��������

��������_�����.��������_������� --from
��������_�������.��������_������� --select

select tc.constraint_name
from information_schema.table_constraints tc
join information_schema.key_column_usage kcu on kcu.constraint_name = tc.constraint_name

select information_schema.table_constraints.constraint_name
from information_schema.table_constraints 
join information_schema.key_column_usage 
	on information_schema.key_column_usage.constraint_name = 
	information_schema.table_constraints.constraint_name

������� ��������� �������, ��� �� ��������� ����������, � ��� ���.

select t."��������"
from (
	select title "��������", description
	from film f) t

1. �������� �������� id ������, ��������, ��������, ��� ������ �� ������� ������.
������������ ���� ���, ����� ��� ��� ���������� �� ����� Film (FilmTitle ������ title � ��)
- ����������� ER - ���������, ����� ����� ���������� �������
- as - ��� ������� ��������� 

select film_id, title, description, release_year
from film 

select film_id FilmFilm_id, title FilmTitle, 
	description as FilmDescription, release_year as FilmRerease_year
from film 

select film_id "FilmFilm_id", title "FilmTitle", 
	description as "FilmDescription", release_year as "��� ������� ������"
from film 

2. � ����� �� ������ ���� ��� ��������:
rental_duration - ����� ������� ������ � ����  
rental_rate - ��������� ������ ������ �� ���� ���������� �������. 
��� ������� ������ �� ������ ������� �������� ��������� ��� ������ � ����,
������� ������������ ������� ��������� cost_per_day
- ����������� ER - ���������, ����� ����� ���������� �������
- ��������� ������ � ���� - ��������� rental_rate � rental_duration
- as - ��� ������� ��������� 

select title, rental_rate / rental_duration as cost_per_day
from film 

2*
- �������������� ��������
- �������� round

select title, rental_rate / rental_duration as cost_per_day1, 
	rental_rate * rental_duration as cost_per_day2, 
	rental_rate + rental_duration as cost_per_day3, 
	rental_rate - rental_duration as cost_per_day4
from film 

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 

select title, round((rental_rate / rental_duration)::numeric, 2) as cost_per_day
from film 

select title, round((rental_rate / rental_duration)::float) as cost_per_day
from film 

select round(10/90, 2)

smallint / int2 0-65535
int / integer / int4 0-65535*65535
bigint / int8 0-65535*65535*65535*65535

numeric / decimal (10,2) 99999999,99
2.5+2.5=2.5+2.5

float real double precision
2.5+2.5 = 2.499+2.501

SELECT x,
  round(x::numeric) AS num_round,
  round(x::double precision) AS dbl_round
FROM generate_series(-3.5, 3.5, 1) as x;

serial

3.1 ������������� ������ ������� �� �������� ��������� �� ���� ������ (�.2)
- ����������� order by (�� ��������� ��������� �� �����������)
- desc - ���������� �� ��������

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by round(rental_rate / rental_duration, 2) 

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by cost_per_day

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc, 1

3.1* ������������ ������� �������� �� ����������� ����� ������� (amount)
- ����������� ER - ���������, ����� ����� ���������� �������
- ����������� order by 
- asc - ���������� �� ����������� 

select payment_id, payment_date, amount
from payment 
order by 3

select payment_id, amount
from payment 
where amount > 0
order by payment_date

3.2 ������� ���-10 ����� ������� ������� �� ��������� �� ���� ������
- ����������� limit

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc, 1
limit 10

3.3 ������� ���-10 ����� ������� ������� �� ��������� ������ �� ����, ������� � 58-�� �������
- �������������� Limit � offset

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
limit 10
offset 57

3.3* ������� ���-15 ����� ������ ��������, ������� � ������� 14000
- �������������� Limit � Offset

select payment_id, customer_id, amount
from payment 
order by amount
offset 13999
limit 15
	
4. ������� ��� ���������� ���� ������� �������
- �������������� distinct

select distinct release_year
from film 

select distinct film_id, release_year
from film 

4* ������� ���������� ����� �����������
- ����������� ER - ���������, ����� ����� ���������� �������
- �������������� distinct

select distinct first_name
from customer 

select distinct on (c.first_name) c.first_name, c.last_name
from (
	select first_name
	from customer 
	group by first_name
	having count(1) > 1) t
join customer c on c.first_name = t.first_name
order by 1

varchar (200) 0 - 200
char (20)
text 

5.1. ������� ���� ������ �������, ������� ������� 'PG-13', � ����: "�������� - ��� �������"
- ����������� ER - ���������, ����� ����� ���������� �������
- "||" - �������� ������������, ������� �� concat
- where - ����������� ����������
- "=" - �������� ���������

select title, rating
from film 
where rating = 'PG-13'

select concat(title, ' - ', release_year), rating
from film 
where rating = 'PG-13'

select title || ' - ' || release_year, rating
from film 
where rating = 'PG-13'

select 'Hello' || null

select 2 + null

select concat('Hello', null)

5.2 ������� ���� ������ �������, ������� �������, ������������ �� 'PG'
- cast(�������� ������� as ���) - ��������������
- like - ����� �� �������
- ilike - ������������������� �����
- lower
- upper
- length

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG%'

select pg_typeof(rating)
from film

select pg_typeof(release_year)
from film

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like '%-%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text not like '%-%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG___'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG__!_' escape '!'

select concat(title, ' - ', release_year), rating
from film 
where rating::text ilike 'pg%' 

select concat(title, ' - ', release_year), rating
from film 
where lower(rating::text) like 'pg%' 

select concat(title, ' - ', release_year), rating
from film 
where upper(rating::text) like 'PG%' 

select concat(title, ' - ', release_year), rating
from film 
where rating::text ilike 'pg%' and character_length(rating::text) = 5

select concat(title, ' - ', release_year), rating
from film 
where rating::text ilike 'pg%' or character_length(rating::text) = 5

and ����� ��������� ����� or

..1.. and ..2.. or ..3.. or ..4.. or ..5..

1�2 ��� 3 ��� 4 ��� 5

..1.. and (..2.. or ..3..) or (..4.. or ..5..)

1 � (2 ��� 3) ��� (4 ��� 5)

5.2* �������� ���������� �� ����������� � ������ ���������� ���������'jam' (���������� �� �������� ���������), � ����: "��� �������" - ����� �������.
- "||" - �������� ������������
- where - ����������� ����������
- ilike - ������������������� �����
- strpos
- character_length
- overlay
- substring
- split_part

select first_name, last_name
from customer 
where first_name ilike '%jam%'

select strpos('Hello world', 'world')

select character_length('Hello world')

select length('Hello world')

select overlay('Hello world' placing 'Max' from 7 for 5)

select overlay('Hello world' placing 'Max' 
	from strpos('Hello world', 'world') for character_length('world'))
	
select substring('Hello world', 7)

select split_part('Hello world', ' ', 1), split_part('Hello world', ' ', 2)

select split_part('Hello world !', ' ', 3), split_part('Hello world', ' ', 2)

select initcap('hello-world-my friend')

select left('Hello world', 1), right('Hello world', 3)

6. �������� id �����������, ������������ ������ � ���� � 27-05-2005 �� 28-05-2005 ������������
- ����������� ER - ���������, ����� ����� ���������� �������
- between - ������ ���������� (������ ... >= ... and ... <= ...)
- date_part()
- date_trunc()
- interval
- extract

select customer_id, rental_date
from rental 
where rental_date >= '27/05/2005' and rental_date <= '28-05-2005'

select customer_id, rental_date
from rental 
where rental_date between '27/05/2005 00:00:00' and '28-05-2005 00:00:00'
order by 2 desc

select pg_typeof(rental_date)
from rental 

select customer_id, rental_date
from rental 
where rental_date between '27/05/2005' and '28-05-2005'::date + interval '1 day'
order by 2 desc

date 
timestamp 
timestamptz
interval

select customer_id, rental_date
from rental 
where rental_date between '27/05/2005' and '28-05-2005 24:00:00'
order by 2 desc

select customer_id, rental_date
from rental 
where rental_date::date between '27/05/2005' and '28-05-2005'
order by 2 desc

select customer_id, rental_date
from rental 
where rental_date::date between '27/05/2005' and '28-05-2005'
order by 2 desc

select date_part('year', '27/05/2005'::date) || '-' 
	|| date_part('month', '27/05/2005'::date) || '-' 
	|| date_part('day', '27/05/2005'::date)

select date_part('month', '27/05/2005'::date)

select date_part('day', '27/05/2005'::date)

select date_part('week', '27/05/2005'::date)

select date_trunc('year', '27/05/2005'::date)

select date_trunc('month', '27/05/2005'::date)

select date_trunc('day', '27/05/2005'::date)

select power(5,7)

select date_trunc('week', '27/05/2005'::date)

6* ������� ������� ����������� ����� 28-05-2005
- ����������� ER - ���������, ����� ����� ���������� �������
- > - ������� ������ (< - ������� ������)

select *
from payment 
where payment_date::date > '28-05-2005'
order by payment_date

7 �������� ���������� ���� � '30-04-2007' �� ����������� ����.
�������� ���������� ������� � '30-04-2007' �� ����������� ����.
�������� ���������� ��� � '30-04-2007' �� ����������� ����.

select now()

select current_date

--���:
select date_part('day', now() - '30-04-2007')

select '30-04-2007'::date - '30-04-2005'::date

select '30-04-2007 21:00:00'::timestamp - '30-04-2007 19:00:00'::timestamp


--������:
select date_part('year', age(now(), '30-04-2007')) * 12 +
	date_part('month', age(now(), '30-04-2007'))

--����:
select date_part('year', age(now(), '30-04-2007'))

select  age(now(), '30-04-2007')

