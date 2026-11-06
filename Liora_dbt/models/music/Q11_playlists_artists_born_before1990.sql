{{ config(materialized='view', tags=['the_queries']) }}
select distinct
    p.playlist_name
from {{ ref('dim_playlist')}} p
join {{ source('liora_db', 'playlisttrack')}} pt
    on p.playlist_id = pt.playlistid
join {{ ref('tracks')}} t
    on pt.trackid = t.trackid
join {{ ref('dim_album')}} a
    on t.album_id = a.album_id
join {{ ref('dim_artist') }} ar
    on a.artist_id = ar.artist_id
where ar.birthyear < 1990