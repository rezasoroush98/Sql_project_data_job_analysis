--what are the skills required for these top-paying roles?
SELECT 
jp.job_id,
job_title_short,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date,
name as company_name,
sd.skills

from job_postings_fact         as   jp
LEFT JOIN company_dim          as   cd   ON jp.company_id=cd.company_id
LEFT JOIN skills_job_dim       as   sj   ON jp.job_id=sj.job_id
LEFT JOIN  skills_dim          as   sd   ON sj.skill_id=sd.skill_id

where job_title_short='Data Analyst' and
      salary_year_avg is NOT NULL and
      job_location = 'Anywhere' and 
      sd.skills is not NULL

ORDER BY salary_year_avg DESC

