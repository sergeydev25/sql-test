a. Вывести общий объем поставок каждого из продуктов для каждой фирмы с указанием даты последней поставки
select c.name company_name, g.name good_name, sum(quantity) quantity_sum, max(shipdate) last_date
	from shipment s
		join company c on c.id=s.company_id
		join goods g on g.id=s.good_id
	group by good_id, company_id
	order by company_name;

b. Аналогично предыдущему пункту, но за последние 30 дней. Если поставки какого-либо из товаров для компании в этот период отсутствовали, вывести в столбце объема 'No data'
select 
		c.name company_name, 
		g.name good_name,
        CAST(coalesce(counts.quantity_sum, 'No data') AS CHAR) quantity_sum,
		counts.last_date
	from company c
	    left join (
			select company_id, good_id, sum(quantity) quantity_sum, max(shipdate) last_date
				from shipment
			where shipdate >= DATE_ADD(current_date(), INTERVAL -30 DAY) and shipdate <= now()
			group by company_id, good_id
	    ) as counts on c.id=counts.company_id
	    left join goods g on g.id=counts.good_id
