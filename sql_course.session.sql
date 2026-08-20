CREATE TABLE january_jobs AS
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


CREATE TABLE february_jobs AS
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


CREATE TABLE march_jobs AS
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 3;



SELECT 
        COUNT(job_id) AS job_ids,
        EXTRACT(MONTH FROM job_posted_date) AS job_month
FROM job_postings_fact
GROUP BY job_month
ORDER BY job_ids DESC;



SELECT 
        COUNT(job_id) AS jobs,
        CASE 
                WHEN job_location = 'Anywhere' THEN 'Remote'
                WHEN job_location = 'New York, NY' THEN 'Local'
                ELSE 'Onsite'
        END AS job_location_search
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_location_search;



-- Using CTE
WITH quarter_report AS
(
SELECT 
        *
FROM january_jobs
UNION ALL
SELECT 
        *
FROM february_jobs
UNION ALL
SELECT 
        *
FROM march_jobs)
SELECT
        *
FROM quarter_report
WHERE 
        (salary_year_avg > 70000)
        AND
        (job_title_short = 'Data Analyst')
;



-- Using Subquery
SELECT *
FROM 
        (SELECT
                *
        FROM january_jobs
        UNION ALL
        SELECT 
                *
        FROM february_jobs
        UNION ALL
        SELECT 
                *
        FROM march_jobs) AS quarter_report
WHERE (salary_year_avg > 70000)
        AND
        (job_title_short = 'Data Analyst');