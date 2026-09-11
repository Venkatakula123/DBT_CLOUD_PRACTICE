{{
    config(
        materialized='table'
    )
}}

WITH Genome_Scores_Raw as (
    SELECT * FROM {{source('movies','RAW_GENOME_SCORES')}}
)
SELECT
    movieId as movie_id,
    tagId as tag_id,
    relevance,
FROM Genome_Scores_Raw