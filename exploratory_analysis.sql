-- Movie vs TV Show Distribution
SELECT type, COUNT(*) AS total
FROM netflix_titles
GROUP BY type
ORDER BY total DESC;

--Top Countries by Content
SELECT TRIM(country_name) AS country, COUNT(*) AS total_titles
FROM (
  SELECT unnest(string_to_array(country, ',')) AS country_name
  FROM netflix_titles
) AS sub
GROUP BY TRIM(country_name)
ORDER BY total_titles DESC
LIMIT 10;

--Most Common Ratings
SELECT rating, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY rating
ORDER BY total_titles DESC
LIMIT 5;

--Yearly Release Trends
SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
WHERE release_year >= 2000
GROUP BY release_year
ORDER BY release_year;

--Top Directors
SELECT TRIM(director_name) AS director, COUNT(*) AS total_titles
FROM (
  SELECT unnest(string_to_array(director, ',')) AS director_name
  FROM netflix_titles
) AS sub
GROUP BY TRIM(director_name)
ORDER BY total_titles DESC
LIMIT 5;

--Movie Duration 
SELECT CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) AS movie_duration,
       COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = 'Movie'
GROUP BY movie_duration
ORDER BY total_movies DESC
LIMIT 10;

--TV Show Duration 
SELECT CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) AS number_of_seasons,
       COUNT(*) AS total_tv_shows
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY number_of_seasons
ORDER BY total_tv_shows DESC;

--Genre Distribution
SELECT TRIM(genre) AS genre, COUNT(*) AS total_titles
FROM (
  SELECT unnest(string_to_array(listed_in, ',')) AS genre
  FROM netflix_titles
) AS sub
GROUP BY TRIM(genre)
ORDER BY total_titles DESC
LIMIT 3;
