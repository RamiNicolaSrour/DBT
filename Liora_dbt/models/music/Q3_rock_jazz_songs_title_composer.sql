{{ config(materialized='view', tags=['the_queries']) }}

select
    t.track_name,
    t.composer
from {{ ref('tracks') }} t
join {{ ref('dim_genre')}} g
    on t.GENRE_ID = g.GENRE_ID
where g.genre_name in ('Rock', 'Jazz')