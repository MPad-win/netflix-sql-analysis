
# 📊 Netflix SQL Analysis Project

A complete end-to-end SQL analysis using the Netflix Titles dataset from Kaggle. This project includes data cleaning and exploratory insights to understand the content strategy and distribution patterns of Netflix.

## 📚 Table of Contents
- Dataset Overview
- Data Cleaning
- Exploratory Analysis
  - Movie vs TV Show Distribution
  - Top Countries by Content
  - Most Common Ratings
  - Yearly Release Trends
  - Top Directors
  - Movie & TV Show Duration Distribution
  - Genre Distribution
- Key Takeaways
- Project Files

## 📦 Dataset Overview
- Source: Kaggle (Netflix Titles Dataset)
- Records: 8,807
- Columns include: `title`, `type`, `director`, `cast`, `country`, `date_added`, `release_year`, `rating`, `duration`, `listed_in`, and `description`

## 🧼 Data Cleaning

### 1. Identifying Nulls
```sql
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
```

### Summary of Null Handling:
- Replaced `NULL` values in `country` with `'Unknown'`
- Replaced `NULL` values in `rating` with `'Unrated'`
- Kept other `NULL`s and used `COALESCE()` in queries when needed

### 2. Trimmed Whitespace
```sql
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
```

## 🔍 Exploratory Analysis

### 1. Movie vs TV Show Distribution
```sql
SELECT type, COUNT(*) AS total
FROM netflix_titles
GROUP BY type
ORDER BY total DESC;
```
**Insight:** Netflix hosts significantly more Movies than TV Shows, indicating a strong focus on film content.

### 2. Top Countries by Content
```sql
SELECT TRIM(country_name) AS country, COUNT(*) AS total_titles
FROM (
  SELECT unnest(string_to_array(country, ',')) AS country_name
  FROM netflix_titles
) AS sub
GROUP BY TRIM(country_name)
ORDER BY total_titles DESC
LIMIT 10;
```
**Insight:** The U.S. is the leading contributor of content, followed by India and the U.K., reflecting Netflix’s global licensing and production strategy.

### 3. Most Common Ratings
```sql
SELECT rating, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY rating
ORDER BY total_titles DESC
LIMIT 5;
```
**Insight:** TV-MA is the most common rating, showing Netflix's focus on mature content.

### 4. Yearly Release Trends
```sql
SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
WHERE release_year >= 2000
GROUP BY release_year
ORDER BY release_year;
```
**Insight:** A sharp increase in releases is seen from 2015 to 2020, highlighting Netflix's rapid content expansion during that period.

### 5. Top Directors
```sql
SELECT TRIM(director_name) AS director, COUNT(*) AS total_titles
FROM (
  SELECT unnest(string_to_array(director, ',')) AS director_name
  FROM netflix_titles
) AS sub
GROUP BY TRIM(director_name)
ORDER BY total_titles DESC
LIMIT 5;
```
**Insight:** The most featured directors are highly prolific or involved in multiple Netflix collaborations, revealing popular or frequent creators.

### 6. Movie & TV Show Duration Distribution

#### Movies
```sql
SELECT CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) AS movie_duration,
       COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = 'Movie'
GROUP BY movie_duration
ORDER BY total_movies DESC
LIMIT 10;
```
**Insight:** Most movies on Netflix fall between 80–100 minutes, fitting standard feature-length formats.

#### TV Shows
```sql
SELECT CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) AS number_of_seasons,
       COUNT(*) AS total_tv_shows
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY number_of_seasons
ORDER BY total_tv_shows DESC;
```
**Insight:** Most Netflix TV shows have 1 or 2 seasons, indicating a trend toward limited or short-format series.

### 7. Genre Distribution
```sql
SELECT TRIM(genre) AS genre, COUNT(*) AS total_titles
FROM (
  SELECT unnest(string_to_array(listed_in, ',')) AS genre
  FROM netflix_titles
) AS sub
GROUP BY TRIM(genre)
ORDER BY total_titles DESC
LIMIT 3;
```
**Insight:** "International Movies", "Dramas", and "Comedies" are the most common genres on Netflix, showcasing its global content strategy and focus on mainstream storytelling.

## 🧠 Key Takeaways
- Netflix favors movies over TV shows in total volume
- The U.S. dominates content contributions, but international titles are also growing
- TV-MA is the most frequent rating, indicating a mature target audience
- Content production surged after 2015, peaking before the pandemic
- Genres like Dramas and Documentaries are most widely represented
- Most TV shows on Netflix have only 1–2 seasons, and movies tend to fall within a 90–100 minute duration

## 📁 Project Files
- `data_cleaning.sql`: All cleaning operations (null handling, trimming)
- `exploratory_analysis.sql`: All 7 analysis queries

Thanks for checking out this project! 🚀
