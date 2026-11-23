{{ config(materialized='table') }}

with dates as (
    select distinct cast(orderdate as date) as date_id
    from {{ source('oliver_dw_source', 'orders') }}
)

select
    to_number(to_char(date_id, 'YYYYMMDD')) as date_key,
    date_id,
    dayname(date_id)   as day_of_week,
    monthname(date_id) as month,
    quarter(date_id)   as quarter,
    year(date_id)      as year
from dates