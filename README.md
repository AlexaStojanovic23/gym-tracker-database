**Gym Tracker Database**

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

Query Files

- queries.sql – analytical queries written for the initial schema design
- queries_v2.sql – updated analytical queries adapted to the backend implementation schema

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

## Project Evolution

This repository contains the initial relational database design for the Gym Tracker application.

During backend development, the production database schema evolved into a more backend-oriented structure.

The original design used:
- daily_logs
- daily_workouts
- daily_exercises
- sets

The implemented application version later introduced:
- workout_logs
- workout_log_exercises
- workout_log_sets

The core logic remained similar, but the final application schema was simplified to better match the backend application flow.

## Query Files

This project includes two SQL query collections:

- `queries.sql` – analytical queries written for the initial schema design
- `queries_v2.sql` – updated analytical queries adapted to the backend implementation schema

These queries demonstrate:

- filtering using `WHERE`
- aggregations using `COUNT`, `SUM`, `AVG`
- grouped reporting with `GROUP BY`
- post-aggregation filtering using `HAVING`
- nested logic using subqueries
