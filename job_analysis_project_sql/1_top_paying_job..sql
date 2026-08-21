/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts.
*/


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
