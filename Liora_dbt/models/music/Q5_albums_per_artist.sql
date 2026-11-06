{{ config(materialized='view', tags=['the_queries']) }}
select
   artist_name,
   count(album_id) as albums_count
from {{ ref('dim_artist') }} ar
left join {{ ref('dim_album') }} a
    on ar.ARTIST_ID = a.ARTIST_ID
group by ar.artist_name
order by albums_count desc