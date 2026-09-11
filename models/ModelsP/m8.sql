SELECT
    MOVIE_ID,
    TITLE,
    GENRES,
    RELEASE_YEAR,
    RATING,
    UPDATED_AT
FROM {{ ref('m7') }}