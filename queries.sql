-- Exercise leaderboard for a user (sets, volume, avg weight)

SELECT e.id, e.name,
  COUNT(*) AS total_sets,
  SUM(s.reps * s.weight_kg) AS total_volume,
  AVG(s.weight_kg) AS avg_weight
FROM sets s
JOIN daily_exercises de ON de.id = s.daily_exercise_id
JOIN exercises e ON e.id = de.exercise_id
JOIN daily_workouts dw ON dw.id = de.daily_workout_id
JOIN daily_logs dl ON dl.id = dw.daily_log_id
WHERE dl.user_id = 1
GROUP BY e.id, e.name
ORDER BY total_volume DESC;

-- "Top day" metric: high-volume days (volume > 10000)

SELECT
  dl.log_date,
  SUM(s.reps * s.weight_kg) AS total_volume,
  COUNT(DISTINCT de.exercise_id) AS diff_exercises,
  MAX(s.weight_kg) AS max_weight
FROM sets s
JOIN daily_exercises de ON de.id = s.daily_exercise_id
JOIN daily_workouts dw ON dw.id = de.daily_workout_id
JOIN daily_logs dl ON dl.id = dw.daily_log_id
WHERE dl.user_id = 1
GROUP BY dl.log_date
HAVING SUM(s.reps * s.weight_kg) > 10000
ORDER BY total_volume DESC;

-- Per-exercise stats: avg reps, total sets, min/max weight
   
SELECT e.id, e.name,
  AVG(s.reps) AS avg_reps_per_set,
  COUNT(*) AS total_sets,
  MIN(s.weight_kg) AS min_weight,
  MAX(s.weight_kg) AS max_weight
FROM sets s
JOIN daily_exercises de ON de.id = s.daily_exercise_id
JOIN exercises e ON e.id = de.exercise_id
JOIN daily_workouts dw ON dw.id = de.daily_workout_id
JOIN daily_logs dl ON dl.id = dw.daily_log_id
WHERE dl.user_id = 1
GROUP BY e.id, e.name
ORDER BY total_sets DESC;

-- Most performed exercise (by number of sets)

SELECT e.name, COUNT(*) AS total_sets
FROM sets s
JOIN daily_exercises de ON de.id = s.daily_exercise_id
JOIN daily_workouts dw ON dw.id = de.daily_workout_id
JOIN daily_logs dl ON dl.id = dw.daily_log_id
JOIN exercises e ON e.id = de.exercise_id
WHERE dl.user_id = 1
GROUP BY e.name
ORDER BY total_sets DESC
LIMIT 1;


-- Total lifted volume per exact date

SELECT
  dl.log_date,
  COUNT(*) AS total_sets,
  SUM(s.reps * s.weight_kg) AS total_volume
FROM sets s
JOIN daily_exercises de ON de.id = s.daily_exercise_id
JOIN daily_workouts dw ON dw.id = de.daily_workout_id
JOIN daily_logs dl ON dl.id = dw.daily_log_id
WHERE dl.user_id = 1
  AND dl.log_date = '2026-02-19'
GROUP BY dl.log_date;
