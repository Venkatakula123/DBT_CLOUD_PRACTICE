SELECT
    MOVIE_ID,
    TITLE,
    GENRES,
    RELEASE_YEAR,
    RATING,
    UPDATED_AT
FROM {{ ref('m6') }}
WHERE RATING >= 4.0