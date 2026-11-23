{{ config(materialized='table') }}

select
    c.cust_key,
    d.date_key,
    s.store_key,
    p.product_key,
    e.employee_key,
    ol.quantity,
    ol.quantity * ol.unitprice as dollars_sold,
    ol.unitprice               as unit_price
from {{ source('oliver_dw_source', 'orderline') }} ol
join {{ source('oliver_dw_source', 'orders') }} o
    on ol.orderid = o.orderid
join {{ ref('oliver_dim_customer') }} c
    on o.customerid = c.customerid
join {{ ref('oliver_dim_employee') }} e
    on o.employeeid = e.employeeid
join {{ ref('oliver_dim_store') }} s
    on o.storeid = s.store_id
join {{ ref('oliver_dim_product') }} p
    on ol.productid = p.product_id
join {{ ref('oliver_dim_date') }} d
    on cast(o.orderdate as date) = d.date_id