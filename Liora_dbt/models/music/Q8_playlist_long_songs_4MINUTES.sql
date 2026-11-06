{{ config(materialized='view', tags=['the_queries']) }}

select distinct
    p.PLAYLIST_NAME
from {{ ref('dim_playlist') }} p
join {{ source('liora_db', 'playlisttrack') }} pt
    on p.PLAYLIST_ID = pt.PLAYLISTID
join {{ ref('tracks') }} t
    on pt.TRACKID = t.TRACKID
where t.MILLISECONDS > 240000 -- 4 minutes milliseconds