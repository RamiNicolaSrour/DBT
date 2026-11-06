{{ config(materialized='table', tags=['star_schema_dbt']) }}
select
    PlaylistID as Playlist_id,
    Name as PlayList_name
from {{ source('liora_db', 'playlist') }}