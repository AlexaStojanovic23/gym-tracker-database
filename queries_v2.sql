-- Exercises with total lifted volume greater than 1000 kg

SELECT
  e.id,
  e.name,
  SUM(wls.reps * wls.weight_kg) AS total_volume
FROM workout_log_sets wls
JOIN workout_log_exercises wle ON wle.id = wls.workout_log_exercise_id
JOIN exercises e ON e.id = wle.exercise_id
JOIN workout_logs wl ON wl.id = wle.workout_log_id
WHERE wl.user_id = 1
GROUP BY e.id, e.name
HAVING total_volume > 1000
ORDER BY total_volume DESC;

-- Sets where the weight is above the average weight lifted by the user

SELECT
  e.name,
  wls.weight_kg,
  wls.reps
FROM workout_log_sets wls
JOIN workout_log_exercises wle ON wle.id = wls.workout_log_exercise_id
JOIN exercises e ON e.id = wle.exercise_id
JOIN workout_logs wl ON wl.id = wle.workout_log_id
WHERE wl.user_id = 1
AND wls.weight_kg >
( 
  SELECT AVG(weight_kg)
  FROM workout_log_sets 
)
ORDER BY wls.weight_kg DESC;

-- Performance statistics per exercise

SELECT
  e.id,
  e.name,
  COUNT(wls.id) AS total_sets,
  SUM(wls.reps * wls.weight_kg) AS total_volume,
  ROUND(AVG(wls.weight_kg), 2) AS avg_weight,
  ROUND(AVG(wls.reps), 2) AS avg_reps
FROM workout_log_sets wls
JOIN workout_log_exercises wle ON wle.id = wls.workout_log_exercise_id
JOIN exercises e ON e.id = wle.exercise_id
JOIN workout_logs wl ON wl.id = wle.workout_log_id
WHERE wl.user_id = 1
GROUP BY e.id, e.name
ORDER BY total_volume DESC;

-- Workouts where user performed more than 5 sets

SELECT
  wl.id AS workout_id,
  wl.workout_date,
  COUNT(wls.id) AS total_sets
FROM workout_log_sets wls
JOIN workout_log_exercises wle ON wle.id = wls.workout_log_exercise_id
JOIN workout_logs wl ON wl.id = wle.workout_log_id
WHERE wl.user_id = 1
GROUP BY wl.id, wl.workout_date
HAVING total_sets > 5
ORDER BY total_sets DESC;

-- Total lifted volume per day for user 1

SELECT
  wl.workout_date,
  SUM(wls.reps * wls.weight_kg) AS total_volume
FROM workout_log_sets wls
JOIN workout_log_exercises wle ON wle.id = wls.workout_log_exercise_id
JOIN workout_logs wl ON wl.id = wle.workout_log_id
WHERE wl.user_id = 1
GROUP BY wl.workout_date
ORDER BY wl.workout_date;
