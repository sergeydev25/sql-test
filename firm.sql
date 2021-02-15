a. Вернуть название фирмы и ее телефон. В результате должны быть представлены
   все фирмы по одному разу. Если у фирмы нет телефона, нужно вернуть пробел или
   прочерк. Если у фирмы несколько телефонов, нужно вернуть любой из них.
select f.name, case when p.phone is null then '-' else p.phone end phone
	from firm f
		left join phone p on p.firm_id=f.id
    group by f.id;

b. Вернуть все фирмы, не имеющие телефонов.
select f.name
	from firm f
		left join phone p on p.firm_id=f.id
	where p.phone is null;

c. Вернуть все фирмы, имеющие не менее 2-х телефонов.
select name from firm where id in(
	select firm_id
		from (
			select firm_id, count(phone) AS cnt
			from phone
			group by firm_id
		) as phone_count
	where phone_count.cnt >= 2
);

d. Вернуть все фирмы, имеющие менее 2-х телефонов.
select name from firm where id in(
	select firm_id
		from (
			select firm_id, count(phone) AS cnt
			from phone
			group by firm_id
		) as phone_count
	where phone_count.cnt < 2
);

e. Вернуть фирму, имеющую максимальное кол-во телефонов.
select f.name, count(firm_id) cnt 
	from phone p
		join firm f on f.id=p.firm_id
	group by firm_id
	order by cnt desc
	limit 1;
