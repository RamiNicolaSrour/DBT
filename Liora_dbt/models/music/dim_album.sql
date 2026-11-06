{{ config(materialized='table', tags=['star_schema_dbt']) }}
select
    AlbumId as album_id,
    title as title,
    ARTISTID as artist_id,
    ProdYear as prod_year,
    CDYear as cd_year
from {{ source('liora_db', 'album') }}