CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL, 
  password TEXT NOT NULL
);

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  school INT NOT NULL,
  expires DATE NOT NULL
);

CREATE TABLE schools (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL
);

CREATE TABLE observations (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  student_id INT NOT NULL,
  task_id INT NOT NULL,
  duration TEXT NOT NULL
);

CREATE TABLE tasks (
  id SERIAL PRIMARY KEY, 
  name TEXT NOT NULL
);