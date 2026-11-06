{{ config(materialized='view', tags=['the_queries']) }}

select
    g.genre_name,
    avg(t.bytes) as avg_bytes,
from {{ ref('tracks') }} t
join {{ ref('dim_genre') }} g
    on t.GENRE_ID = g.GENRE_ID
group by g.GENRE_NAME
ORDER by avg_bytes DESC