#answer13
with my_cte as (select pt.category , pt.name , sum(p.price * od.quantity) as revenue 
from pizza_types as pt
join pizzas as p 
on pt.pizza_type_id = p.pizza_type_id
join order_details as od
on od.pizza_id = p.pizza_id
group by  pt.category , pt.name 
order by category asc , revenue desc),
tt as (select category , name , revenue , rank() over (partition by category order by revenue desc) as rn
from my_cte)
select category , name , revenue
from tt where rn<4;
