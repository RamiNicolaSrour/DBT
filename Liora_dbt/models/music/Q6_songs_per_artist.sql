{{ config(materialized='view', tags=['the_queries']) }}
select
   ar.ARTIST_NAME,
   count(t.trackid) as songs_count
from {{ ref('dim_artist') }} ar
join {{ ref('dim_album') }} a
    on ar.artist_id = a.artist_id
join {{ ref('tracks') }} t
    on a.album_id = t.album_id
group by ar.artist_name
order by songs_count desc