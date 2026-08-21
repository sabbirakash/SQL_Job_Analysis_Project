# Inroduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/job_analysis_project_sql/)

# Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    jp.job_id,
    jp.job_title_short,
    jp.job_location,
    jp.job_via,
    jp.job_schedule_type,
    cd.name AS company_name,
    jp.salary_year_avg,
    jp.job_posted_date
FROM job_postings_fact AS jp
LEFT JOIN company_dim AS cd
    ON jp.company_id = cd.company_id
WHERE 
    (jp.job_location = 'Anywhere')
    AND
    (jp.job_title_short = 'Data Analyst')
    AND
    (jp.salary_year_avg IS NOT NULL)
ORDER BY jp.salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:

* **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
* **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
* **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. What skills are required for the top-paying data analyst jobs?

To highlight the specific skills required for the highest-paying roles, I joined the top-paying jobs query with the skills data, allowing us to see what technical tools and programming languages top employers are looking for.

```sql
WITH top_paying_skills AS
    (SELECT
        jp.job_id,
        jp.job_title_short,
        cd.name AS company_name,
        jp.salary_year_avg
    FROM job_postings_fact AS jp
    LEFT JOIN company_dim AS cd
        ON jp.company_id = cd.company_id
    WHERE 
        (jp.job_location = 'Anywhere')
        AND
        (jp.job_title_short = 'Data Analyst')
        AND
        (jp.salary_year_avg IS NOT NULL)
    ORDER BY jp.salary_year_avg DESC
    LIMIT 10)
SELECT
    top_paying_skills.*,
    s.skills,
    s.type
FROM top_paying_skills
INNER JOIN skills_job_dim AS sd ON top_paying_skills.job_id = sd.job_id
INNER JOIN skills_dim AS s ON sd.skill_id = s.skill_id
ORDER BY top_paying_skills.salary_year_avg DESC;
```

Here's the breakdown of the skills required for the top-paying data analyst jobs:

* **SQL Dominance:** SQL is requested across nearly every single top-paying role, making it the absolute foundational language for high salaries.

* **Programming Proficiency:** Python and R are heavily featured alongside SQL, highlighting the need for advanced programming and statistical analysis capabilities.

* **Visualization and Cloud Tools:** Tools like Tableau, Excel, and Power BI, alongside cloud and data platforms like Snowflake, Azure, and AWS, are critical components demanded by top employers.

### 3. What are the most in-demand skills for data analysts?

To identify the most in-demand skills for remote data analyst positions, I queried the job postings by joining them with skill tables, counting the frequency of each skill, and filtering for work-from-home roles. This highlights the tools employers look for most often.

```sql
SELECT
    skills,
    COUNT(jpf.job_id) AS demand_skill
FROM job_postings_fact As jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
ON sd.skill_id = sjd.skill_id
WHERE jpf.job_title_short = 'Data Analyst'
    AND
    jpf.job_work_from_home = True
GROUP BY skills
ORDER BY demand_skill DESC
LIMIT 5;
```

Here's the breakdown of the most in-demand skills for data analysts:

* **SQL Leadership:** SQL is the most requested skill by a large margin, appearing in 7,291 remote job postings, cementing its status as a core requirement.

* **Excel and Python Staples:** Traditional spreadsheet skills like Excel (4,611 postings) and programming languages like Python (4,330 postings) follow closely behind as essential daily tools.

* **Visualization Tools:** Business intelligence platforms like Tableau (3,745 postings) and Power BI (2,609 postings) round out the top five, emphasizing the importance of data storytelling and dashboard creation.

### 4. What are the top skills based on salary?

To find out which specific skills command the highest average salaries, I calculated the average yearly salary for remote data analyst jobs grouped by skill, focusing on positions with specified salaries.

```sql
SELECT
    skills,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact As jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
ON sd.skill_id = sjd.skill_id
WHERE jpf.job_title_short = 'Data Analyst'
    AND
    jpf.salary_year_avg IS NOT NULL
    AND
    jpf.job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 20;
```

Here's the breakdown of the top skills based on salary:

* **Big Data and Advanced Processing:** PySpark leads the highest-paying skills with an average salary of $208,172, followed closely by cloud and data tools like Databricks ($141,907).

* **Development and Version Control Tools:** Tools commonly utilized in engineering workflows, such as Bitbucket ($189,155) and GitLab ($154,500), appear high on the compensation scale.

* **Python Ecosystem & Machine Learning:** Specialized data science libraries and Python tools like Jupyter ($152,777), Pandas ($151,821), NumPy ($143,513), and scikit-learn ($125,781) command strong premium salaries.

### 5. What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?

To identify the most optimal skills to learn—those that combine high demand with high average salaries for remote data analyst roles—I combined the demand count and average salary metrics into a single query.

```sql
WITH demand_skill_table AS(
    SELECT
        a.skill_id,
        b.skills,
        COUNT(j.job_id) AS demand_count
    FROM job_postings_fact As j
    INNER JOIN skills_job_dim AS a
    ON j.job_id = a.job_id
    INNER JOIN skills_dim AS b
    ON b.skill_id = a.skill_id
    WHERE j.job_title_short = 'Data Analyst'
        AND
        j.salary_year_avg IS NOT NULL
        AND
        j.job_work_from_home = True
    GROUP BY a.skill_id, b.skills
),
demand_salary_table AS(
    SELECT
        a.skill_id,
        b.skills,
        ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact As j
    INNER JOIN skills_job_dim AS a
    ON j.job_id = a.job_id
    INNER JOIN skills_dim AS b
    ON b.skill_id = a.skill_id
    WHERE j.job_title_short = 'Data Analyst'
        AND
        j.salary_year_avg IS NOT NULL
        AND
        j.job_work_from_home = True
    GROUP BY a.skill_id, b.skills
)
SELECT 
    *
FROM demand_skill_table AS skill
JOIN demand_salary_table AS salary
ON skill.skill_id = salary.skill_id
ORDER BY demand_count DESC
;
```

Here's the breakdown of the most optimal skills to learn for data analysts:

* **High-Demand Core Skills:** SQL leads with the highest demand count (398 postings) at an average salary of $97,237, followed closely by Excel (256 postings, $87,288 average salary) and Python (236 postings, $101,397 average salary).

* **Strong Visualization Value:** Tableau is heavily sought after (230 demand count) with an impressive average salary of $99,288, making data visualization a very balanced choice for career growth.

* **Programming and Cloud Premiums:** Languages and platforms like R (148 demand count, $100,499 average salary), Power BI (110 demand count, $97,431 average salary), and Snowflake (37 demand count, $112,948 average salary) offer a strategic mix of broad market accessibility and lucrative compensation.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

* **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
* **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
* **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusion
### Insights

1. **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, with the highest reaching **$650,000**.

2. **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in **SQL**, suggesting it's a critical skill for earning a top salary.

3. **Most In-Demand Skills:** **SQL** is also the most demanded skill in the data analyst job market, making it essential for job seekers.

4. **Skills with Higher Salaries:** Specialized skills, such as **SVN** and **Solidity**, are associated with the highest average salaries, indicating a premium on niche expertise.

5. **Optimal Skills for Job Market Value:** **SQL** leads in both demand and high-paying opportunities, positioning it as one of the most valuable skills for data analysts looking to maximize their career potential.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide for prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration also highlights the importance of continuous learning and adapting to emerging trends in the field of data analytics.