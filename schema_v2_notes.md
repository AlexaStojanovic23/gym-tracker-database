# Schema V2 Notes

During backend development, the original database schema evolved into a simplified structure used by the application.

The original design used:

- daily_logs
- daily_workouts
- daily_exercises
- sets

The implemented backend schema uses:

- workout_logs
- workout_log_exercises
- workout_log_sets

## Mapping Between Schemas

Original schema → Application schema

- daily_workouts → workout_logs
- daily_exercises → workout_log_exercises
- sets → workout_log_sets
- workout_exercises → exercise_workout

The core logic remains the same:
users perform workouts, workouts contain exercises, and exercises contain sets with reps and weight.
