{{ config(materialized='view', tags=['the_queries']) }}
select
    g.genre_name,
    Count(pt.trackid) as listen_count
from {{ ref('dim_genre') }} g
join {{ ref('tracks') }} t
    on g.GENRE_ID = t.GENRE_ID
join {{ source('liora_db', 'playlisttrack') }} pt
    on t.TrackID = pt.TRACKID
join {{ ref('dim_album') }} a
    on t.ALBUM_ID = a.ALBUM_ID
WHERE a.Prod_Year between 2000 and 2009
group by g.genre_name
order by listen_count desc
limit 1