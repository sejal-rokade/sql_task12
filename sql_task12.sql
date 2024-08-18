create table report_table(
	product_id varchar primary key,
	sum_of_sales float,
	sum_of_profit float

)

create or replace function update_report_table()
returns trigger as $$
declare
   sumofsales float;
   sumofprofit float;
   count_report int;
begin
  select sum(sales),sum(profit) into sumofsales,sumofprofit from sales where product_id=new.product_id;
  select count(*) into count_report from report_table where product_id=new.product_id;

if count_report=0 then
insert into report_table  values(new.product_id,sumofsales,sumofprofit);
else
update report_table set sum_of_sales=sumofsales, sum_of_profit=sumofprofit where product_id=new.product_id;
end if;
return new;
end
$$ language plpgsql


create trigger report_table
after insert on sales
for each row
execute function update_report_table()

select * from sales 

select sum(sales) as sum_sales,sum(profit) as sum_profit from sales where product_id='FUR-BO-10001798'
--3166.957     106.6786
	
select * from sales order by order_line desc

insert into sales(order_line,order_id,order_date,ship_date,ship_mode,customer_id,product_id,sales,quantity,discount,profit)
values(9998,'CA-2016-152156','2024-08-17','2024-08-24','Standard Class','CG-12520','FUR-BO-10001798',200,30,20,20)

select * from report_table

--3366.957    126.6786