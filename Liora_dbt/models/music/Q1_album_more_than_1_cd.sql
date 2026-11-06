{{ config(materialized='view', tags=['the_queries']) }}

select title
from {{ ref('dim_album') }}
where cd_year > 1