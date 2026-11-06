{{ config(materialized='table', tags=['star_schema_dbt']) }}

select
    GenreID as genre_id,
    Name as genre_name
from {{ source('liora_db', 'genre') }}