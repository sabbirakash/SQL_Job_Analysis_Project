/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
  helps identify the most financially rewarding skills to acquire or improve
*/


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




/*
Based on the query results you provided, here are the top 3 highest-paying skills for Data Analysts (along with their average yearly salaries):
1. **PySpark** ($\$208,172$) – A powerful Python-based framework for processing massive datasets, highly valued for big data analytics engineering.
2. **Bitbucket** ($\$189,155$) – A Git-based code repository and version control tool heavily used in advanced collaborative data pipelines.
3. **Watson** ($\$160,515$) – IBM's AI and enterprise analytics platform applied in specialized machine learning and data workflows.
*/



/*
[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  }
]
*/
