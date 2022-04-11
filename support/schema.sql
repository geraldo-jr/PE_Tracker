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

-- CREATE TABLE observations (
--   id SERIAL PRIMARY KEY,
--   user_id INT NOT NULL,
--   student_id INT NOT NULL,
--   tasks_id INT NOT NULL,
--   duration INTERVAL NOT NULL
-- );

CREATE TABLE observations (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  student_id INT NOT NULL,
  tasks_id INT NOT NULL,
  duration INTERVAL SECOND NOT NULL
);

CREATE TABLE tasks (
  id SERIAL PRIMARY KEY, 
  name TEXT NOT NULL
);

INSERT INTO tasks (name) VALUES
  ('Planned Pres.');
  
INSERT INTO tasks (name) VALUES
  ('Response Pres.'), ('Monitoring'), ('Perform. Feedbk'), ('Motiv. Feedbk'), ('Beg/End Class'), ('Response Pres.'), ('Equip. Mgt.'), ('Organization'), ('Behavior Mgt.'), ('Other Tasks');


INSERT INTO students (name, school, expires) VALUES
  ('Adam Neely', 1, '2022-12-31'), ('Salma Brandon', 2, '2023-07-31'), ('Andorson Bardot', 3, '2022-07-31'), ('Michael Douglas', 4, '2024-01-31');

INSERT INTO schools (name, address) VALUES
  ('Memorial High School', '2220 Fairfax St, Eau Claire, WI 54701'), ('Logan High School', '1500 Ranger Dr, La Crosse, WI 54603'), ('Regis High School', '2100 Fenwick Ave, Eau Claire, WI 54701'), ('Parkside School', '300 16th Ave, Wautoma, WI 54982'), ('Necedah Area School District', '1801 S Main St, Necedah, WI 54646');

INSERT INTO observations (user_id, student_id, tasks_id, duration) VALUES
  (-1, -1, 1, '+114');
