SELECT
    MOVIE_ID,
    TITLE,
    GENRES,
    RELEASE_YEAR,
    RATINGS,
    UPDATED_AT
FROM {{ ref('m4') }}
WHERE RATING >= 3.5