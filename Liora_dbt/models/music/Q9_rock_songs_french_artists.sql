{{ config(materialized='view', tags=['the_queries']) }}

select
    t.track_name,
    ar.artist_name
from {{ ref('tracks') }} t
join {{ ref('dim_album') }} a
    on t.album_id = a.album_id
join {{ ref('dim_artist') }} ar
    on a.ARTIST_ID = ar.ARTIST_ID
join {{ ref('dim_genre') }} g
    on t.genre_id = g.genre_id
where g.genre_name = 'Rock'
  and ar.country = 'France'