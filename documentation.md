# API Documentation: Node.js + Express for SQLite QC_DB

This guide will help you set up a simple REST API using Node.js, Express, and SQLite for the database defined in `create_db.sql`.

## Prerequisites
- Node.js (v14+ recommended)
- npm (Node package manager)
- SQLite3 installed (database file created from `create_db.sql`)

## 1. Project Setup

```bash
mkdir qc_db_api
cd qc_db_api
npm init -y
npm install express sqlite3
```

## 2. Project Structure

```
qc_db_api/
  |-- index.js
  |-- qc_db.sqlite  # Your SQLite database file
```

## 3. Example: Basic Express API

### index.js
```js
const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const app = express();
const db = new sqlite3.Database('./qc_db.sqlite');

app.use(express.json());

// Get all users
app.get('/users', (req, res) => {
  db.all('SELECT * FROM users', [], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Get user by ID
app.get('/users/:id', (req, res) => {
  db.get('SELECT * FROM users WHERE user_id = ?', [req.params.id], (err, row) => {
    if (err) return res.status(500).json({ error: err.message });
    if (!row) return res.status(404).json({ error: 'User not found' });
    res.json(row);
  });
});

// Create a new user
app.post('/users', (req, res) => {
  const { username, email, status } = req.body;
  db.run(
    'INSERT INTO users (username, email, status) VALUES (?, ?, ?)',
    [username, email, status || 'active'],
    function (err) {
      if (err) return res.status(400).json({ error: err.message });
      res.status(201).json({ user_id: this.lastID });
    }
  );
});

// Update a user
app.put('/users/:id', (req, res) => {
  const { username, email, status } = req.body;
  db.run(
    'UPDATE users SET username = ?, email = ?, status = ? WHERE user_id = ?',
    [username, email, status, req.params.id],
    function (err) {
      if (err) return res.status(400).json({ error: err.message });
      res.json({ updated: this.changes });
    }
  );
});

// Delete a user
app.delete('/users/:id', (req, res) => {
  db.run('DELETE FROM users WHERE user_id = ?', [req.params.id], function (err) {
    if (err) return res.status(400).json({ error: err.message });
    res.json({ deleted: this.changes });
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

## 4. Running the API

```bash
node index.js
```

The API will be available at `http://localhost:3000`.

## 5. Extending the API
- Add endpoints for `user_profiles` and `audit_logs` tables as needed.
- Implement authentication and validation for production use.

## 6. References
- [Express Documentation](https://expressjs.com/)
- [sqlite3 Node.js Package](https://www.npmjs.com/package/sqlite3)
