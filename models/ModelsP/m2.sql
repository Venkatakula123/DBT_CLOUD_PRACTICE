SELECT
    MOVIE_ID,
    TITLE,
    GENRES,
    RELEASE_YEAR,
    RATING,
    UPDATED_AT
FROM {{ ref('m1') }}
WHERE RATING >= 3.0