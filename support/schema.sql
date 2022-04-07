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
  tasks_id INT NOT NULL,
  duration INTERVAL NOT NULL
);

CREATE TABLE tasks (
  id SERIAL PRIMARY KEY, 
  name TEXT NOT NULL
);

INSERT INTO tasks (name) VALUES
  ('Planned Pres.');
  
INSERT INTO tasks (name) VALUES
  ('Response Pres.'), ('Monitoring'), ('Perform. Feedback'), ('Motiv. Feedback'), ('Beg/End Class'), ('Response Pres.'), ('Equip. Mgt.'), ('Organization'), ('Behavior Mgt.'), ('Other Tasks');