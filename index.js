const express = require('express');
const path = require('path');
const PORT = process.env.PORT || 5000;
const { Pool } = require('pg');
const { isNull } = require('util');

const pool = new Pool({
	connectionString: process.env.DATABASE_URL,
	ssl: {
		rejectUnauthorized: false
	}
});

express()
	.use(express.static(path.join(__dirname, 'public')))
	.use(express.json())
	.use(express.urlencoded({ extended: true}))
	.set('views', path.join(__dirname, 'views'))
	.set('view engine', 'ejs')
	.get('/', async(req, res) => {
		try {
			const client = await pool.connect();

			const tasks = await client.query(
				`SELECT * FROM tasks ORDER BY id ASC`);
			const students = await client.query(
				`SELECT * FROM students ORDER BY id ASC`);
				
			const randomNumber = parseInt(Math.floor(Math.random()*students.rows.length));
			
			const schools = await client.query(
				`SELECT * FROM schools ORDER BY id ASC`);

			const locals = {
				'tasks': (tasks) ? tasks.rows : null,
				'studentName': students.rows[randomNumber].name,
				'studentId': students.rows[randomNumber].id,
				'studentSchool': schools.rows[students.rows[randomNumber].school].name
			};
			res.render('pages/index', locals);
			client.release();
		
		} catch (err) {
			console.error(err);
			res.send("Error: " + err);
		}
	})
	.get('/db-info', async(req, res) => {
		try {
			const client = await pool.connect();
			const tables = await client.query(
				`SELECT c.relname AS table, a.attname AS column, t.typname as type
				FROM pg_catalog.pg_class AS c
				LEFT JOIN pg_catalog.pg_attribute AS a 
				ON c.oid = a.attrelid AND a.attnum > 0
				LEFT JOIN pg_catalog.pg_type AS t
				ON a.atttypid = t.oid
				WHERE c.relname IN ('users', 'observations', 'students', 'schools', 'tasks')
				ORDER BY c.relname, a.attnum;`
			);

			const obs = await client.query(
				`SELECT * FROM observations ORDER BY student_id ASC`);

			const students = await client.query(
				`SELECT * FROM students`);
			
				const tasks = await client.query(
				`SELECT * FROM tasks`);
			
			const locals = {
				'tables': (tables) ? tables.rows : null,
				'obs': (obs) ? obs.rows : null,
				'students': (students) ? students.rows : null,
				'tasks': (tasks) ? tasks.rows : null
			};

			res.render('pages/db-info', locals);
			client.release();

		} catch (err) {
			console.error(err);
			res.send("Error: " + err);
		}
	})
	.post('/log', async(req, res) => {
		try {
			const client = await pool.connect();
			const userId = req.body.user_id;
			const studentId = req.body.students_id;
      const tasksId = req.body.tasks_id;
    	const duration = req.body.duration;

			const sqlInsert = await client.query(
				`INSERT INTO observations (user_id, student_id, tasks_id, duration)
				VALUES (${userId}, ${studentId}, ${tasksId}, ${duration}) RETURNING id as new_id;`);
			
			console.log(`Tracking tasks ${tasksId}`);

			const result = {
				'response': (sqlInsert) ? sqlInsert.rows[0] : null
			};
			res.set({
				'Content-Type': 'application/json'
			});
			res.json({ requestBody: result });
			client.release();

		} catch (err) {
			console.error(err);
			res.send("Error: " + err);
		}
	})
	.listen(PORT, () => console.log(`Listening on ${ PORT }`));