-- Gym Tracker Database Schema (clean export)
-- Generated from SQLite database; excludes framework/system tables (cache/jobs/migrations/sessions, etc.)
-- Generated: 2026-02-24T02:56:28

PRAGMA foreign_keys = ON;

-- Table: users
CREATE TABLE "users" ("id" integer primary key autoincrement not null, "name" varchar not null, "email" varchar not null, "email_verified_at" datetime, "password" varchar not null, "remember_token" varchar, "created_at" datetime, "updated_at" datetime, "full_name" varchar not null, "username" varchar not null);

-- Table: workouts
CREATE TABLE workouts (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
description TEXT,
created_by_user_id INTEGER,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(created_by_user_id) REFERENCES users(id)
);

-- Table: exercises
CREATE TABLE exercises (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
muscle_group TEXT,
description TEXT
);

-- Table: workout_exercises
CREATE TABLE workout_exercises (
id INTEGER PRIMARY KEY AUTOINCREMENT,
workout_id INTEGER,
exercise_id INTEGER,
sort_order INTEGER,
FOREIGN KEY(workout_id) REFERENCES workouts(id),
FOREIGN KEY(exercise_id) REFERENCES exercises(id)
);

-- Table: daily_logs
CREATE TABLE daily_logs (
id INTEGER PRIMARY KEY AUTOINCREMENT,
user_id INTEGER,
log_date DATE DEFAULT CURRENT_DATE,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
UNIQUE(user_id, log_date),
FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Table: daily_workouts
CREATE TABLE daily_workouts (
id INTEGER PRIMARY KEY AUTOINCREMENT,
daily_log_id INTEGER NOT NULL,
workout_id INTEGER NOT NULL,
started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
duration_minutes INTEGER,
FOREIGN KEY (daily_log_id) REFERENCES daily_logs(id),
FOREIGN KEY (workout_id) REFERENCES workouts(id)
);

-- Table: daily_exercises
CREATE TABLE daily_exercises (
id INTEGER PRIMARY KEY AUTOINCREMENT,
daily_workout_id INTEGER NOT NULL,
exercise_id INTEGER NOT NULL,
FOREIGN KEY(daily_workout_id) REFERENCES daily_workouts(id),
FOREIGN KEY(exercise_id) REFERENCES exercises(id)
);

-- Table: sets
CREATE TABLE sets (
id INTEGER PRIMARY KEY AUTOINCREMENT,
daily_exercise_id INTEGER NOT NULL,
set_number INTEGER NOT NULL CHECK(set_number >= 1),
reps INTEGER NOT NULL CHECK(reps > 0),
weight_kg REAL NOT NULL CHECK(weight_kg BETWEEN 0 AND 200),
FOREIGN KEY (daily_exercise_id) REFERENCES daily_exercises(id)
);

-- Table: nutrition_goals
CREATE TABLE "nutrition_goals" ("id" integer primary key autoincrement not null, "user_id" integer not null, "goal" varchar check ("goal" in ('bulk', 'cut', 'recomp')) not null, "calorie_target" integer not null, "protein_g" integer not null, "fat_g" integer not null, "carbs_g" integer not null, "fat_percent" numeric not null default '30', "protein_g_per_kg" numeric not null default '1.8', "bulk_type" varchar check ("bulk_type" in ('lean', 'standard')), "cut_type" varchar check ("cut_type" in ('moderate', 'aggressive')), "created_at" datetime, "updated_at" datetime, foreign key("user_id") references "users"("id") on delete cascade);

-- Table: user_metrics
CREATE TABLE "user_metrics" ("id" integer primary key autoincrement not null, "user_id" integer not null, "gender" varchar check ("gender" in ('male', 'female')) not null, "age" integer not null, "height_cm" integer not null, "weight_kg" numeric not null, "activity_multiplier" numeric not null, "bmr" numeric not null, "tdee" integer not null, "created_at" datetime, "updated_at" datetime, foreign key("user_id") references "users"("id") on delete cascade);

-- Indexes / constraints
CREATE UNIQUE INDEX "users_email_unique" on "users" ("email");
CREATE UNIQUE INDEX "users_username_unique" on "users" ("username");
CREATE UNIQUE INDEX "nutrition_goals_user_id_unique" on "nutrition_goals" ("user_id");
CREATE UNIQUE INDEX "user_metrics_user_id_unique" on "user_metrics" ("user_id");
CREATE UNIQUE INDEX idx_unique_daily_exercise
ON daily_exercises(daily_workout_id, exercise_id);
CREATE UNIQUE INDEX idx_unique_set_number
ON sets(daily_exercise_id, set_number);
CREATE UNIQUE INDEX idx_unique_workout_exercise
ON workout_exercises(workout_id, exercise_id);
