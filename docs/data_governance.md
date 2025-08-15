 # 🛡 Data Governance & Validation

This document outlines the steps taken to ensure **accuracy, consistency, and reliability** of the COVID-19 dataset used in this project.  
The goal is to guarantee that all analysis, dashboards, and insights are based on **clean, validated, and trustworthy data**.

---

## 1. Data Cleaning Approach

### **1.1 Initial Checks**
- Reviewed raw dataset for:
  - Missing values (`NULL`)
  - Duplicates
  - Negative values in counts
  - Inconsistent date formats
  - Outliers in daily cases, deaths, or vaccinations
- Compared total case counts against public reference datasets to verify correctness.

### **1.2 Cleaning Actions Taken**
- **Removed duplicate rows** identified by `(Date, Country)` combination.
- **Standardized date formats** to `YYYY-MM-DD`.
- **Trimmed and standardized country names** to prevent mismatches in grouping.
- **Corrected negative values** in `new_cases` and `new_deaths`:
  - If due to data entry error → replaced with average of day before & after.
  - If zero was expected but incorrectly entered as negative → replaced with 0.
- **Handled missing values**:
  - `new_cases` and `new_deaths`: replaced NULL with average of adjacent days.
  - `vaccinations`: forward-filled last known cumulative value.
  - Other numeric NULLs where "no activity" was implied → replaced with 0.
- **Outlier handling**:
  - Flagged spikes greater than 3× rolling 7-day average for manual review.

---

## 2. Data Validation Logic

SQL checks used to validate the dataset:

```sql
-- Check for negative case counts
SELECT *
FROM covid_data
WHERE new_cases < 0 OR new_deaths < 0;

-- Check for deaths greater than total cases
SELECT *
FROM covid_data
WHERE new_deaths > new_cases;

-- Check for missing country names
SELECT *
FROM covid_data
WHERE country IS NULL OR country = '';

-- Verify vaccination totals do not exceed population
SELECT *
FROM covid_data
WHERE total_vaccinations > population;

4. Governance Principles Applied

Accuracy – All corrections based on verifiable logic or adjacent data patterns.

Consistency – Standardized formats and naming conventions across the dataset.

Traceability – All cleaning steps documented for reproducibility.

Integrity – No artificial inflation/deflation of case or vaccination counts.