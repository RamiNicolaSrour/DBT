{{ config(materialized='view', tags=['the_queries']) }}
select
   a.title,
   sum(t.milliseconds) as album_duration
from {{ ref('dim_album') }} a
join {{ ref('tracks') }} t
    on a.album_id = t.album_id
group by a.title
order by album_duration desc
limit 10