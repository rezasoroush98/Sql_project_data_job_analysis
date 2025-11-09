--What are the top-paying jobs for my role?
--top 10 top-paying data analyst remote jobs
SELECT 
job_id,
job_title_short,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date,
name as company_name

from job_postings_fact as jp
LEFT JOIN company_dim  as cd ON jp.company_id=cd.company_id

where job_title_short='Data Analyst' and
      salary_year_avg is NOT NULL and
      job_location = 'Anywhere'

ORDER BY salary_year_avg DESC
LIMIT 10;