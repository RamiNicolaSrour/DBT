// same init used in snowflake exam (databases and warehouses already created but creation codes are here to keep work complete)
// database and schema creation
create database if not exists liora_db;
use database liora_db;
create schema if not exists public;
use schema public;

// create warehouse
CREATE WAREHOUSE if not exists warehouse_exam
with
  WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  COMMENT = 'exams';
USE WAREHOUSE warehouse_exam;

// i use this line to see list of folders and files inside the used stage
LIST @s3_data;

// create csv files format
CREATE FILE FORMAT IF NOT EXISTS CLASSIC_CSV;
ALTER FILE FORMAT "LIORA_DB"."PUBLIC".CLASSIC_CSV 
      SET COMPRESSION = 'AUTO' 
      RECORD_DELIMITER = '\n'
      FIELD_DELIMITER = ',' 
      SKIP_HEADER = 1 
      DATE_FORMAT = 'AUTO' 
      TIMESTAMP_FORMAT = 'AUTO'
      FIELD_OPTIONALLY_ENCLOSED_BY = '"'
      TRIM_SPACE = FALSE
      ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
      ESCAPE = 'NONE' 
      ESCAPE_UNENCLOSED_FIELD = '\134' 
      NULL_IF = ('\\N');

// in case an error happens when reading csv (like a different number of columns)
CREATE FILE FORMAT IF NOT EXISTS csv_error;
ALTER FILE FORMAT "LIORA_DB"."PUBLIC".csv_error 
      SET COMPRESSION = 'AUTO' 
      RECORD_DELIMITER = '\n'
      FIELD_DELIMITER = ',' 
      SKIP_HEADER = 1 
      DATE_FORMAT = 'AUTO' 
      TIMESTAMP_FORMAT = 'AUTO'
      FIELD_OPTIONALLY_ENCLOSED_BY = '"'
      TRIM_SPACE = FALSE
      ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE 
      ESCAPE = 'NONE' 
      ESCAPE_UNENCLOSED_FIELD = '\134' 
      NULL_IF = ('\\N');

// create tables
CREATE TABLE IF NOT EXISTS genre(
   GENREID number primary key,
   Name Varchar
);

CREATE TABLE IF NOT EXISTS Playlist (
   PlaylistID number primary key,
   Name Varchar
);

CREATE TABLE IF NOT EXISTS PlaylistTrack (
   PlaylistID number,
   TrackID number
);

CREATE TABLE IF NOT EXISTS MediaType (
   MediaTypeID number primary key,
   Name Varchar
);

CREATE TABLE IF NOT EXISTS Artist (
   ArtistID Number primary key,
   Name Varchar,
   BirthYear Number,
   Country Varchar
);

CREATE TABLE IF NOT EXISTS Album (
   AlbumID Number primary key,
   title Varchar,
   ArtistID Number,
   ProdYear Number,
   CdYear Number
);

CREATE TABLE IF NOT EXISTS Track (
   TrackID Number primary key,
   Name Varchar,
   AlbumID Number,
   GenreID Number,
   MediaTypeID Number,
   Composer Varchar,
   Milliseconds Number,
   Bytes Number,
   UnitPrice Number
);

// loading data into tables

//show stage properties, here used to see url of files to take data from
desc stage s3_data;

COPY INTO genre
FROM @s3_data/music/Genre.csv
FILE_FORMAT=CLASSIC_CSV;

COPY INTO MediaType
FROM @s3_data/music/MediaType.csv
FILE_FORMAT=CLASSIC_CSV;

COPY INTO Artist
FROM @s3_data/music/Artist.csv
FILE_FORMAT=CLASSIC_CSV;

COPY INTO Album
FROM @s3_data/music/Album.csv
FILE_FORMAT=CLASSIC_CSV;

COPY INTO Playlist
FROM @s3_data/music/Playlist.csv
FILE_FORMAT=CLASSIC_CSV;
COPY INTO PlaylistTrack
FROM @s3_data/music/PlaylistTrack.csv
FILE_FORMAT=CLASSIC_CSV;

// skip rows that fail when loading tables from the stage into track table
FROM @s3_data/music/Track.csv
FILE_FORMAT=csv_error
ON_ERROR = 'Continue';

// use this command to show some data from track table to check if loading data worked
SELECT * from Track limit 4;