-- Check for null values 
SELECT
  COUNT(*) AS total_rows,
  COUNT(*) - COUNT(show_id) AS null_show_id,
  COUNT(*) - COUNT(type) AS null_type,
  COUNT(*) - COUNT(title) AS null_title,
  COUNT(*) - COUNT(director) AS null_director,
  COUNT(*) - COUNT("cast") AS null_cast,
  COUNT(*) - COUNT(country) AS null_country,
  COUNT(*) - COUNT(date_added) AS null_date_added,
  COUNT(*) - COUNT(release_year) AS null_release_year,
  COUNT(*) - COUNT(rating) AS null_rating,
  COUNT(*) - COUNT(duration) AS null_duration,
  COUNT(*) - COUNT(listed_in) AS null_listed_in,
  COUNT(*) - COUNT(description) AS null_description
FROM netflix_titles;

-- Replace country nulls with 'Unknown'
UPDATE netflix_titles
SET country = 'Unknown'
WHERE country IS NULL;

-- Replace NULL ratings
UPDATE netflix_titles
SET rating = 'Unrated'
WHERE rating IS NULL;

-- Trim whitespace
UPDATE netflix_titles
SET
  type = TRIM(type),
  title = TRIM(title),
  director = TRIM(director),
  "cast" = TRIM("cast"),
  country = TRIM(country),
  rating = TRIM(rating),
  duration = TRIM(duration),
  listed_in = TRIM(listed_in),
  description = TRIM(description);

