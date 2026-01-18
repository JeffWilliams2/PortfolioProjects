-- Data Cleaning

SELECT *
FROM world_layoffs.layoffs;

-- 1. Remove Duplicates from dataset

#To prepare for data cleaning
CREATE TABLE layoff_staging
LIKE layoffs;

INSERT layoff_staging
SELECT *
FROM layoffs;

--
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, location, total_laid_off, percentage_laid_off, 'date') AS row_num
FROM layoff_staging;

SELECT *
FROM (
	SELECT company, industry, total_laid_off,`date`,
		ROW_NUMBER() OVER (
			PARTITION BY company, industry, total_laid_off,`date`
			) AS row_num
	FROM 
		world_layoffs.layoff_staging
) duplicates
WHERE 
	row_num > 1;

-- let's just look at Casper to confirm
SELECT *
FROM world_layoffs.layoff_staging
WHERE company = 'Casper';

SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoff_staging
) duplicates
WHERE 
	row_num > 1;

--
SELECT *
FROM world_layoffs.layoffs_staging
;

-- 2. Standardize dataset
CREATE TABLE layoff_staging2
LIKE layoffs;

INSERT layoff_staging2
SELECT *
FROM layoffs;

SELECT * 
FROM world_layoffs.layoff_staging2;

-- if we look at industry, we have some null and na rows.
SELECT DISTINCT industry
FROM world_layoffs.layoff_staging2
ORDER BY industry;

-- this helps us take a closer look
SELECT *
FROM world_layoffs.layoff_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- let's take a look...
SELECT *
FROM world_layoffs.layoff_staging2
WHERE company LIKE 'Bally%';

-- nothing wrong here
SELECT *
FROM world_layoffs.layoff_staging2
WHERE company LIKE 'airbnb%';
--
-- Noticed crypto has a few variations... Let's fix to all equal Crypto
SELECT DISTINCT industry
FROM world_layoffs.layoff_staging2
ORDER BY industry;

UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

SELECT DISTINCT industry
FROM world_layoffs.layoff_staging2
ORDER BY industry;

-- Fix United States and United States.
SELECT *
FROM world_layoffs.layoff_staging2;

SELECT DISTINCT country
FROM world_layoffs.layoff_staging2
ORDER BY country;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- Run this to see if fixed...
SELECT DISTINCT country
FROM world_layoffs.layoff_staging2
ORDER BY country;
-- It is fixed.

-- Let's  fix the date column:
SELECT *
FROM world_layoffs.layoff_staging2;

-- we can use STR_TO_DATE to update the field
UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- now lets convert the data types
ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM world_layoffs.layoff_staging2;

-- 3. Look at Null/blank values. 
-- Some null values are valid. Can differ on dataset

-- 4. Remove columns of non-interest
SELECT *
FROM world_layoffs.layoff_staging2
WHERE total_laid_off IS NULL;

SELECT *
FROM world_layoffs.layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Delete data we can't use
DELETE FROM world_layoffs.layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM world_layoffs.layoff_staging2;

ALTER TABLE layoff_staging2
DROP COLUMN row_num;

SELECT * 
FROM world_layoffs.layoff_staging2;





