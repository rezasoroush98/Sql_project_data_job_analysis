-- What are the most in-demand skills for Data Analysts in Italy?

SELECT
    sd.skills,
    COUNT(sj.job_id) AS demand         -- Number of job postings that require each skill
FROM job_postings_fact AS tpjs
JOIN skills_job_dim AS sj ON tpjs.job_id = sj.job_id   -- Link job postings to their required skills
JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id     -- Get skill names from the skills table
WHERE job_title_short = 'Data Analyst'                 -- Filter for Data Analyst roles
  AND job_location = 'Italy'                           -- Limit results to jobs located in Italy
GROUP BY sd.skills                                     -- Aggregate by each skill
ORDER BY demand DESC                                   -- Sort skills by demand (highest first)
LIMIT 5;                                               -- Show top 5 most in-demand skills

