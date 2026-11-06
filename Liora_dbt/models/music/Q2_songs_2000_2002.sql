{{ config(materialized='view', tags=['the_queries']) }}
select
    track_name
from {{ ref('tracks') }} t
join {{ ref('dim_album') }} a
    on t.ALBUM_ID = a.ALBUM_ID
where a.PROD_YEAR in (2000, 2002)