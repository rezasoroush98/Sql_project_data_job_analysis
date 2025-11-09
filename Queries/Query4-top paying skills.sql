--What are top skills based on salary for my role ?
SELECT
skills,
round(avg(salary_year_avg),2)   as avg_of_salary_per_skill
FROM job_postings_fact as jpf
JOIN skills_job_dim as sj on jpf.job_id= sj.job_id
JOIN skills_dim     as sd on sj.skill_id=sd.skill_id

where job_title_short='Data Analyst' and 
    salary_year_avg is  NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_of_salary_per_skill DESC
LIMIT 25 