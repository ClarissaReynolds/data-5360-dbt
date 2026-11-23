{{ config(materialized='table') }}

select
    row_number() over (order by employeeid) as employee_key,
    employeeid,
    firstname,
    lastname,
    email,
    phone_number,
    hire_date,
    position
from {{ source('oliver_dw_source', 'employee') }}