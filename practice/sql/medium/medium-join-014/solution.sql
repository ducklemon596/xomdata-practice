-- Xom Data · Stock-in history by supplier
-- Problem: https://xomdata.com/practice/medium-join-014
-- Solved: 2026-08-11

select w.warehouse_name, count(si.product_id) as import_count, 
        count(distinct si.product_id) as distinct_product_count,
        count(distinct si.suppliers) as distinct_supplier_count,
        max(import_date) as last_import_date,
        rank() over(ORDER BY count(si.product_id) desc) as activity_rank,
        lag(w.warehouse_name) over (ORDER BY count(si.product_id) desc, w.warehouse_name) as prev_warehouse
from warehouses w
left join stock_imports si on w.id = si.warehouse_id
group by w.warehouse_name
order by activity_rank, warehouse_name;
