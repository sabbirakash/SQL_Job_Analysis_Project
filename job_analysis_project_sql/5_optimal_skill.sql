/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for career development in data analysis
*/


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


