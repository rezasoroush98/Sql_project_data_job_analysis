--what are the skills required for these top-paying roles?
with top_paying_jobs_skills as 

(SELECT 
jp.job_id,
job_title,
salary_year_avg,
name as company_name

from job_postings_fact         as   jp
LEFT JOIN company_dim          as   cd   ON jp.company_id=cd.company_id

where job_title_short='Data Analyst' and
      salary_year_avg is NOT NULL and
      job_location = 'Anywhere'

ORDER BY salary_year_avg DESC
)

SELECT tpjs.*, skills from 
top_paying_jobs_skills   as tpjs
JOIN   skills_job_dim    as sj  on tpjs.job_id=sj.job_id
JOIN   skills_dim        as sd  on sj.skill_id=sd.skill_id
ORDER BY salary_year_avg DESC