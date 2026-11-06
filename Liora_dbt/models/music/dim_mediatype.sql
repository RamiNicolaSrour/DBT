{{ config(materialized='table', tags=['star_schema_dbt']) }}
select
    MediaTypeID as mediatype_id,
    Name as mediatype_name
from {{ source('liora_db', 'mediatype') }}