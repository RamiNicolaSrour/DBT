// this fils have commands to run queries on snowflake
use database liora_db;
use WAREHOUSE warehouse_exam;
use schema public;

select * from Q1_album_more_than_1_cd;
select * from Q2_songs_2000_2002;
select * from Q3_rock_jazz_songs_title_composer;
select * from Q4_top_10_longest_albums;
select * from Q5_albums_per_artist;
select * from Q6_songs_per_artist;
select * from Q7_top_genre_listened_2000s;
select * from Q8_playlist_long_songs_4MINUTES;
select * from Q9_rock_songs_french_artists;
select * from Q10_avg_song_size_genre;
select * from Q11_playlists_artists_born_before1990;