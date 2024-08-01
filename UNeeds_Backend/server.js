const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 8000;
app.use(express.json());

// MySQL Connection Configuration
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'uneeds',
});

// Connect to MySQL
db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL: ' + err.stack);
    return;
  }
  console.log('Connected to MySQL as id ' + db.threadId);
});

//GET Functions
// Define API Endpoints
app.get('/jobs', (req, res) => {
  db.query('SELECT * FROM jobs', (error, results) => {
    if (error) {
      console.error('Error executing MySQL query: ' + error.stack);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
    res.json({ users: results });
  });
});

//POST Functions
app.post('/addUser', (req, res) => {
    const { username, email, age, uid, mobilenumber, jobs} = req.body;
  
    // Validate input
    if (!username || !email || !age || !uid || !mobilenumber || !jobs) {
      return res.status(400).json({ error: 'Username and email are required.' });
    }
    
    db.query('SELECT * FROM expertdetails WHERE uid = ?', [uid], (error, results) => {
        if (error) {
          console.error('Error checking user existence:', error);
          res.status(500).send('Internal Server Error');
          return;
        }
    
        // If the user doesn't exist, insert the user data
        if (results.length === 0) {
          console.log("jobs : ", JSON.stringify(jobs));
    // Insert user into the database
            const query = 'INSERT INTO expertdetails (uid,username,mobilenumber,age,emailid,jobs) VALUES (?, ?, ?, ?, ?,?)';
            db.query(query, [uid, username, mobilenumber, age, email,JSON.stringify(jobs)], (error, results) => {
            if (error) {
                console.error('Error executing MySQL query: ' + error.stack);
                return res.status(500).json({ error: 'Internal Server Error' });
            }
        
            // Return success response
            res.json({ success: true, userId: results.insertId });
            });
        }
        else {
            // User already exists
            res.status(409).send('User already exists');
          }
  })
});

app.post('/checkUser', (req, res) => {
    const { uid } = req.body;
  
    const sql = 'SELECT * FROM expertdetails WHERE uid = ?';
  
    db.query(sql, [uid], (err, result) => {
      if (err) {
        console.error('Error checking user existence:', err);
        res.status(500).json({ error: 'Internal Server Error' });
      } else {
        const userExists = result.length > 0;
        console.log("User Exists : ", userExists);
        res.status(200).json({ exists: userExists, expertdetails: result[0] });
      }
    });
  }
);


app.post('/checkConnection', () => {
  console.log("User Connected");
});


// Start the Server
app.listen(port, '172.20.10.2' || 'localhost',() => {
  console.log(`Server is running on http://localhost:${port}`);
});

