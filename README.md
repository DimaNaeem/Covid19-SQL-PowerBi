# 🦠 COVID-19 Data Analysis Project (SQL + Power BI)
## Overview
This project is a comprehensive analysis of global COVID-19 data using **SQL** for data cleaning and transformation, and **Power BI** for interactive data visualization. It demonstrates key data analytics skills including data wrangling, DAX measures, visual storytelling, and dashboard design.

---

## 📊 Dashboard Preview

![Dashboard Preview](images/dashboard_preview.png)

---

## 📌 Project Goals

- Clean and transform raw COVID-19 data using SQL
- Derive key insights on global cases, deaths, and vaccination trends
- Visualize findings with interactive and insightful Power BI dashboards
- Demonstrate data-driven storytelling and technical skills for portfolio use

---

## 🛠️ Tools & Technologies

- **SQL (SQLite / MySQL)** – Data cleaning, aggregation & analysis queries, Complex queries (CTEs, joins, window functions)
- **Power BI** – Data modeling, DAX measures, slicers & interactive visuals
- **DAX** – Custom measures for death rates, infection rates, and KPIs
- **GitHub** – Version control and project showcase

---

## 📁 File Structure

- `covid_analysis.sql`: SQL queries for data exploration.
- `covid_dashboard.pbix`: Power BI dashboard.

## 📈 Key Insights & Visuals

- **Global COVID KPIs** – Total cases, deaths, vaccinations
- **Global death rate: *X%
- **Continent Breakdown** – Infections, deaths, vaccination rates
- **Infection Rate vs Death Rate** – Country-level correlation
- **Population vs Cases Bubble Chart**
- **Interactive Map** – Total cases by country
- **Slicers** – Filter by continent, country, or date
- **Trend Line** – Cases and deaths over time

---


## 🔍 Key Findings (2020-2024)
### Global Trends
| Metric               | Value           |
|----------------------|-----------------|
| Total Cases          | 715,697,182     |
| Total Deaths         | 8,009,960       |
| Global Death Rate    | 1.12%           |

### SQL Insights
### Highest Death Rates by Country
```sql
SELECT 
    location, 
    ROUND(MAX(death_rate) * 100, 2) AS max_death_rate_percentage
FROM 
    covid_cleaned
WHERE 
    continent IS NOT NULL
GROUP BY 
    location
HAVING 
    max_death_rate_percentage > 5
ORDER BY 
    max_death_rate_percentage DESC;

Key Findings:

Yemen had the highest death rate at 18.73%.

Sudan, Peru, Syria, and Mexico also exceeded 5%.

- 
- **Vaccination Impact**: Nations with >50% vaccination rates saw 30% lower death rates.< ! i want to insert my sql result>
- **Infection Peaks**: Waves correlated with seasonal patterns (e.g., winter surges).

### Power BI Dashboard
![Dashboard](covid-dashboard.png)


### Power BI Dashboard
![Dashboard](covid-dashboard.png)

## 🚀 How to Use

1. Clone the repository or download the ZIP
2. Open `dashboard.pbix` in Power BI Desktop
3. Review the `.sql` files to see how the data was cleaned and analyzed
4. Explore the visualizations and insights interactively

---


## Screenshots
![Power BI Dashboard](screenshot.png) 

## 🧠 Skills Demonstrated

- Data Cleaning with SQL (handling NULLs, calculated fields, filtering)
- Data Modeling in Power BI
- Creating custom DAX measures
- Interactive dashboard design with slicers, tooltips, and formatting
- Communicating insights visually

---

## 📬 Contact

If you're a recruiter or collaborator interested in my work, feel free to [connect with me on LinkedIn](https://www.linkedin.com/in/dimanaeemmirza/) or [view my portfolio](https://dimanaeem.github.io/DimaNaeem-Portfolio/).


