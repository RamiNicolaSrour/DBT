{{ config(materialized='table', tags=['star_schema_dbt']) }}
select
    ArtistID as artist_id,
    Name as artist_name,
    BirthYear,
    Country
from {{ source('liora_db', 'artist') }}