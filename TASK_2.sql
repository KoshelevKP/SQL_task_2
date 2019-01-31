SELECT 'ФИО: Кошелев Константин';

-- 1.1 SELECT , LIMIT
SELECT 
    *
    FROM public.ratings
    LIMIT 10;

-- 1.2 WHERE, LIKE
(
    SELECT 
        *
    FROM public.links
    WHERE
        imdbid like '%42'
) INTERSECT (
    SELECT
        *
     FROM public.links
     WHERE
        movieid > 100
) INTERSECT (
    SELECT
        *
     FROM public.links
     WHERE
        movieid < 1000
)
LIMIT 10;

-- 2.1 INNER JOIN
SELECT *
FROM public.links
JOIN 
     public.ratings
    ON links.movieid=ratings.movieid
    where rating=5
LIMIT 10;

-- 3.1 COUNT()
SELECT 
COUNT (imdbid)
FROM public.links
LEFT JOIN public.ratings
    ON links.movieid=ratings.movieid
WHERE ratings.movieid IS NULL
LIMIT 10;
 
-- 3.2 GROUP BY, HAVING
SELECT
    userId,
    AVG(rating) as avg_rating
FROM public.ratings
GROUP BY userId
HAVING AVG(rating) > 3.5
ORDER BY avg_rating DESC
LIMIT 10;

-- 4.1 Подзапросы
SELECT 
    imdbid
FROM public.links
JOIN public.ratings
    ON links.movieid=ratings.movieid
WHERE
    rating < (
            SELECT AVG(rating)
            FROM public.ratings
    )    
LIMIT 10;

-- 4.2 Common Table Expressions
WITH tmp_table
AS (
    SELECT 
        userId,
        count (rating) as count_rating
    FROM public.ratings
    GROUP BY userId
    HAVING count (rating) > 10
)
SELECT
    count(userId)
FROM tmp_table;


  