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


-- Total lifted volume per day

SELECT dl.log_date, SUM(s.reps * s.weight_kg) AS total_volume
FROM sets s
JOIN daily_exercises de ON de.id = s.daily_exercise_id
JOIN daily_workouts dw ON dw.id = de.daily_workout_id
JOIN daily_logs dl ON dl.id = dw.daily_log_id
WHERE dl.user_id = 1 AND dl.log_date = '2026-02-19'
GROUP BY dl.log_date;
