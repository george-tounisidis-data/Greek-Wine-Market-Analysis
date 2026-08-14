-- =========================================================================
-- PROJECT: Greek Wine Market Analysis for Retail Liquor Stores
-- AUTHOR: George Tounisidis
-- PURPOSE: Data Cleaning, Transformation, and EDA on Greek Wine Dataset
--          to prepare structured data for Power BI Dashboarding.
-- =========================================================================


-- =========================================================================
-- STEP 1: DATA CLEANING - REMOVING NULL VALUES & CREATING CLEANED TABLE
-- DESCRIPTION: Filters out records with missing Country or Price and stores 
--              the valid data into a new structured table for analysis.
-- =========================================================================
SELECT *
INTO cleaned_wine_reviews
FROM [winemag-data-130k-v2] 
WHERE country IS NOT NULL 
  AND price IS NOT NULL;


-- =========================================================================
-- STEP 2: DATA SEGMENTATION - CREATING GREEK WINES VIEW
-- DESCRIPTION: Creates a virtual table (View) containing exclusively 
--              Greek wine records that have passed the initial cleaning phase.
-- =========================================================================
GO
CREATE VIEW greek_wines_analytics AS
SELECT 
    column1 AS wine_id, -- Renaming source auto-increment column to a valid ID
    country,
    province,
    region_1 AS region,
    winery,
    variety,
    title,
    points,
    price,
    description
FROM cleaned_wine_reviews
WHERE country = 'Greece';
GO


-- =========================================================================
-- STEP 3: DATA STANDARDIZATION & LOGICAL DECIMAL CORRECTION
-- DESCRIPTION: Solves system decimal-point bugs based on numeric length 
--              to restore true prices (~$15-$30) and unifies the 'Assyrtiko' typo.
-- =========================================================================
SELECT 
    wine_id,
    country,
    province,
    region,
    winery,
    title,
    points,
    -- Case logic to fix system ingestion decimal displacement bug
    CASE 
        WHEN price >= 10000 THEN CAST(price AS DECIMAL(10,2)) / 1000.0
        WHEN price >= 1000  THEN CAST(price AS DECIMAL(10,2)) / 100.0
        ELSE CAST(price AS DECIMAL(10,2)) / 10.0
    END AS price_usd,
    -- Standardizing variety naming convention (Assyrtico -> Assyrtiko)
    CASE 
        WHEN variety = 'Assyrtico' THEN 'Assyrtiko'
        ELSE variety 
    END AS variety_standardized,
    description
INTO final_greek_wines_cleaned
FROM greek_wines_analytics;


-- =========================================================================
-- STEP 4: EXPLORATORY DATA ANALYSIS (EDA) - VARIETY MARKET SHARE
-- DESCRIPTION: Retrieves the final, validated market share, average rating, 
--              and realistic pricing for top Greek wine varieties.
-- =========================================================================
SELECT 
    variety_standardized AS variety,
    COUNT(*) AS total_wines,
    ROUND(AVG(points), 1) AS avg_rating_points,
    ROUND(AVG(CAST(price_usd AS FLOAT)), 2) AS avg_price_usd
FROM final_greek_wines_cleaned
GROUP BY variety_standardized
ORDER BY total_wines DESC;


-- =========================================================================
-- STEP 5: SUPPLIER ANALYSIS - TOP 5 GREEK WINERIES BY QUALITY
-- DESCRIPTION: Identifies the top 5 premium Greek wineries with at least 
--              3 reviewed wines, ranked by their average rating points.
-- =========================================================================
SELECT TOP 5
    winery,
    COUNT(*) AS total_wines_reviewed,
    ROUND(AVG(points), 1) AS avg_rating_points,
    ROUND(AVG(CAST(price_usd AS FLOAT)), 2) AS avg_price_usd
FROM final_greek_wines_cleaned
GROUP BY winery
HAVING COUNT(*) >= 3
ORDER BY avg_rating_points DESC;


-- =========================================================================
-- STEP 6: POWER BI EXTRACTION QUERY (FINAL DATASET FOR DASHBOARD)
-- DESCRIPTION: Generates the full clean dataset including dynamic quality 
--              tiers to feed directly into the Power BI reporting model.
-- =========================================================================
SELECT 
    wine_id,
    province,
    variety_standardized AS variety,
    winery,
    title,
    points,
    ROUND(CAST(price_usd AS FLOAT), 2) AS price_usd,
    CASE 
        WHEN points >= 90 THEN 'Excellent (90+)'
        WHEN points >= 85 THEN 'Very Good (85-89)'
        ELSE 'Good (80-84)'
    END AS quality_tier,
    description
FROM final_greek_wines_cleaned;
