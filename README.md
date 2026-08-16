# 🍷 Greek Wine Market Analysis - Power BI & SQL Portfolio Project

## 📊 Project Overview
This project delivers a comprehensive **Data Analysis and Business Intelligence solution** tailored for a retail liquor store (κάβα). Since local transactional data was unavailable, the project leverages a real-world global dataset from *Wine Enthusiast*, specifically isolated and cleaned to extract strategic insights about the **Greek Wine Market**. 

The goal is to help a retail store manager optimize inventory selection, identify Value-for-Money (VFM) opportunities, and understand pricing vs. quality dynamics.

### 📌 Live Dashboard Preview
*   **Page 1:** Market & Quality Overview (Total counts, variety market share, quality brackets, geographic mapping).
*   **Page 2:** Advanced Analytics (Price/Rating correlations, Supplier tracking, interactive filters).
<img width="1347" height="1496" alt="Greek Wine Market Analysis" src="https://github.com/user-attachments/assets/cfe37860-47c8-47a7-983b-89ce6c9b1b84" />


---

## 🛠️ Tech Stack & Skills Demonstrated
*   **Database Management:** Microsoft SQL Server (T-SQL)
*   **Data Wrangling & Cleaning:** Advanced SQL (Type casting, string replacement, handling NULL values, logical error fixing)
*   **Business Intelligence & Visualization:** Power BI Desktop
*   **Data Modeling & Analytics:** DAX Measures (`DISTINCTCOUNT`, `AVERAGE`), Outlier Detection

---

## 🧹 Data Cleaning & Challenges (The "Pro" Analyst Approach)
Real-world data is never perfect. During the ETL (Extract, Transform, Load) phase, several critical data quality issues were discovered and solved using **SQL**:
1.  **System Ingestion Bug (Decimal Displacement):** The source ingestion mixed up local Windows regional settings, multiplying prices by 100. This was systematically fixed using conditional `CASE` logic based on string length to restore true market prices (e.g., ~$15 - \$30).
2.  **Data Standardization (Typos):** The premier variety *Assyrtiko* was split into two due to spelling variations (*Assyrtico* and *Assyrtiko*). They were successfully unified under a single attribute using SQL.
3.  **Missing Values (NULLs):** Filtered out incomplete records lacking country or pricing data to preserve business analysis integrity.

---

## 📈 Key Business Insights (Data Storytelling)
*   **The Power of Blends:** White and Red Blends capture nearly **30% of the market share**, indicating strong consumer and producer preference for complex flavor profiles.
*   **Market Leaders:** Excluding blends, **Agiorgitiko** commands the largest overall single-variety market share, while **Assyrtiko** stands firm as the leading single-variety white wine recognized internationally.
*   **Guaranteed Quality Tier:** Over **70% of reviewed Greek wines** fall into the *Very Good (85-89 points)* category, proving that Greece is a highly reliable and safe region for stock sourcing.
*   **The Premium Outlier:** Advanced scatter plot analysis revealed a significant pricing outlier at **$79**—the *Gerovassiliou Evangelo Red*. While sharing a rating of 88 points with more affordable options, this bottle demonstrates strong brand equity and exclusivity, making it a suitable choice for high-end boutique targeting rather than volume sales.

---

## 📂 Repository Structure
*   `greece_wine_analysis.sql`: Full SQL script containing the database setup, data cleaning, and analytical queries.
*   `Greek Wine Market Analysis.pbix`: The complete Power BI project file with structured data models and visuals.
*   `README.md`: Project documentation.

