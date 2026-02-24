Gym Tracker Database

**Overview** 

This project represents the relational database schema for a Gym Tracker web application built with SQLite.

The database is designed to support:

- User workout logging
- Daily training tracking
- Set-level performance recording (reps, weight, volume)
- Workout templates
- Analytical queries for progress monitoring

The schema follows proper relational modeling principles including:

- One-to-many relationships
- Many-to-many relationships
- Foreign key constraints
- Data integrity rules
- Aggregation-ready structure


**Database Structure** 

The schema is divided into two logical layers:

1 - Template Layer

These tables define reusable workout structures:

 - workouts – Workout templates (e.g., Push Day, Pull Day)
 - exercises – Exercise catalog (Bench Press, Squat, etc.)
 - workout_exercises – Many-to-many relation between workouts and exercises

2️ - Logging Layer

These tables store actual performed workouts:

- daily_logs – Represents a single day for a user
- daily_workouts – A specific workout performed on that day
- daily_exercises – Exercises performed within that workout
- sets – Individual set data (reps, weight, order)

This separation allows clean historical tracking without duplicating template data.

**Relationship Flow**

users
→ daily_logs
→ daily_workouts
→ daily_exercises
→ sets

workouts
↔ workout_exercises
↔ exercises

This structure enables:

- Accurate workout history
- Volume calculation
- Frequency tracking
- Performance analysis

**Example Analytical Queries**

**1** - Most Performed Exercise (by number of sets)

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

**2** - Total Lifted Volume Per Day

SELECT dl.log_date, SUM(s.reps * s.weight_kg) AS total_volume

FROM sets s

JOIN daily_exercises de ON de.id = s.daily_exercise_id

JOIN daily_workouts dw ON dw.id = de.daily_workout_id

JOIN daily_logs dl ON dl.id = dw.daily_log_id

WHERE dl.user_id = 1 AND dl.log_date = '2026-02-19'

GROUP BY dl.log_date;

**Technical Highlights**

- Normalized relational schema
- Enforced foreign key relationships
- UNIQUE constraints to prevent duplicate daily logs
- Set-level performance tracking
- Multi-table JOIN analytics
- Aggregation using COUNT, SUM
- SQLite-based implementation

**Purpose**

This project demonstrates:

- Database design skills
- Relational modeling
- Data integrity implementation
- Analytical SQL query writing
- Real-world application structure
