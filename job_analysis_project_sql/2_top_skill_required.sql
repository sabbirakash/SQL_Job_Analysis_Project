/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
  helping job seekers understand which skills to develop that align with top salaries
*/


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





/*
The top 3 most demanded skills across the top-paying data analyst jobs are:

SQL (Appears in 8 out of top roles): The foundational language for querying, managing, and extracting data directly from relational databases. It is universally required for data retrieval at scale.

Python (Appears in 7 out of top roles): The leading programming language for advanced data manipulation, automation, machine learning integration, and complex data cleaning tasks.

Tableau (Appears in 6 out of top roles): A premier business intelligence and data visualization tool used to build interactive dashboards and communicate insights effectively to stakeholders.
*/

/*
[
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "r",
    "type": "programming"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "azure",
    "type": "cloud"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "databricks",
    "type": "cloud"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "aws",
    "type": "cloud"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "pandas",
    "type": "libraries"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "pyspark",
    "type": "libraries"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "jupyter",
    "type": "libraries"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "excel",
    "type": "analyst_tools"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "power bi",
    "type": "analyst_tools"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skills": "powerpoint",
    "type": "analyst_tools"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skills": "r",
    "type": "programming"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skills": "hadoop",
    "type": "libraries"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skills": "crystal",
    "type": "programming"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skills": "oracle",
    "type": "cloud"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skills": "flow",
    "type": "other"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "go",
    "type": "programming"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "snowflake",
    "type": "cloud"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "pandas",
    "type": "libraries"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "numpy",
    "type": "libraries"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "excel",
    "type": "analyst_tools"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skills": "gitlab",
    "type": "other"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "azure",
    "type": "cloud"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "aws",
    "type": "cloud"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "oracle",
    "type": "cloud"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "snowflake",
    "type": "cloud"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "power bi",
    "type": "analyst_tools"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "sap",
    "type": "analyst_tools"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "jenkins",
    "type": "other"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "bitbucket",
    "type": "other"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "atlassian",
    "type": "other"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "jira",
    "type": "async"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skills": "confluence",
    "type": "async"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "r",
    "type": "programming"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "git",
    "type": "other"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "bitbucket",
    "type": "other"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "atlassian",
    "type": "other"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "jira",
    "type": "async"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skills": "confluence",
    "type": "async"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "go",
    "type": "programming"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "snowflake",
    "type": "cloud"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "pandas",
    "type": "libraries"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "numpy",
    "type": "libraries"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "excel",
    "type": "analyst_tools"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "tableau",
    "type": "analyst_tools"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skills": "gitlab",
    "type": "other"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "skills": "sql",
    "type": "programming"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "skills": "python",
    "type": "programming"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "skills": "r",
    "type": "programming"
  }
]
*/