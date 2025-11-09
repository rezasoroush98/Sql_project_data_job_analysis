-- What are the most optimal skills to learn?
-- Optimal = high demand + high salary (for remote Data Analyst roles)

WITH demanded AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sj.job_id) AS demand        -- Count job postings per skill
    FROM job_postings_fact AS tpjs
    JOIN skills_job_dim AS sj ON tpjs.job_id = sj.job_id   -- Link jobs to skills
    JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id     -- Get skill names
    WHERE job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE                        -- Remote jobs only
    GROUP BY sd.skill_id, sd.skills
),
average_salary AS (
    SELECT
        sd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_of_salary_per_skill   -- Avg salary per skill
    FROM job_postings_fact AS jpf
    JOIN skills_job_dim AS sj ON jpf.job_id = sj.job_id
    JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
    WHERE job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE
    GROUP BY sd.skill_id, sd.skills
)

SELECT
    d.skill_id,
    d.skills,
    d.demand,
    a.avg_of_salary_per_skill
FROM demanded AS d
JOIN average_salary AS a ON d.skill_id = a.skill_id       -- Combine demand and salary data
WHERE d.demand > 10                                       -- Filter out low-demand skills
ORDER BY
    a.avg_of_salary_per_skill DESC,                       -- Sort by salary (high → low)
    d.demand DESC                                         -- Then by demand
LIMIT 25;                                                 -- Top 25 optimal skills
