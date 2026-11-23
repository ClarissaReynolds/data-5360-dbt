{{ config(materialized='table') }}

select
    row_number() over (order by customerid) as cust_key,
    customerid, firstname, lastname,  email, phonenumber, state
from {{ source('oliver_dw_source', 'customer') }}