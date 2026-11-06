{{ config(materialized='table', tags=['star_schema_dbt']) }}
select
   TRACKID as trackid,
   Name as track_name,
   ALBUMID as album_id,
   GENREID as genre_id,
   MediatypeID as MediaType_ID,
   COMPOSER,
   MILLISECONDS,
   BYTES,
   UNITPRICE as unit_price
from {{ source('liora_db', 'track') }}