const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const app = express();
const db = new sqlite3.Database('./qc_db.sqlite');
const cors = require('cors');

app.use(express.json());

app.use(cors({
  origin: 'http://localhost:5173',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

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
  const userId = req.params.id;
  const { username, email, status, first_name, last_name, phone_number, address } = req.body;

  // Fetch current user and profile data
  db.get('SELECT * FROM users WHERE user_id = ?', [userId], (err, userRow) => {
    if (err || !userRow) return res.status(404).json({ error: 'User not found' });

    db.get('SELECT * FROM user_profiles WHERE user_id = ?', [userId], (err, profileRow) => {
      if (err) return res.status(500).json({ error: err.message });

      // Update users table
      db.run(
        'UPDATE users SET username = ?, email = ?, status = ? WHERE user_id = ?',
        [username, email, status, userId],
        function (err) {
          if (err) return res.status(400).json({ error: err.message });

          // Log changes for users table
          const userFields = { username, email, status };
          for (const field in userFields) {
            if (userFields[field] !== undefined && userFields[field] !== userRow[field]) {
              db.run(
                'INSERT INTO audit_logs (user_id, action, changed_field, old_value, new_value) VALUES (?, ?, ?, ?, ?)',
                [userId, 'update', field, userRow[field], userFields[field]]
              );
            }
          }

          // Update user_profiles table if any profile fields are present
          if (
            first_name !== undefined ||
            last_name !== undefined ||
            phone_number !== undefined ||
            address !== undefined
          ) {
            db.run(
              `UPDATE user_profiles SET
                first_name = COALESCE(?, first_name),
                last_name = COALESCE(?, last_name),
                phone_number = COALESCE(?, phone_number),
                address = COALESCE(?, address),
                updated_at = CURRENT_TIMESTAMP
              WHERE user_id = ?`,
              [first_name, last_name, phone_number, address, userId],
              function (err) {
                if (err) return res.status(400).json({ error: err.message });

                // Log changes for user_profiles table
                const profileFields = { first_name, last_name, phone_number, address };
                for (const field in profileFields) {
                  if (
                    profileFields[field] !== undefined &&
                    profileRow &&
                    profileFields[field] !== profileRow[field]
                  ) {
                    db.run(
                      'INSERT INTO audit_logs (user_id, action, changed_field, old_value, new_value) VALUES (?, ?, ?, ?, ?)',
                      [userId, 'update', field, profileRow[field], profileFields[field]]
                    );
                  }
                }

                res.json({ updated: this.changes });
              }
            );
          } else {
            res.json({ updated: this.changes });
          }
        }
      );
    });
  });
});

// Delete a user
app.delete('/users/:id', (req, res) => {
  db.run('DELETE FROM users WHERE user_id = ?', [req.params.id], function (err) {
    if (err) return res.status(400).json({ error: err.message });
    res.json({ deleted: this.changes });
  });
});

// Get all audit logs
app.get('/audit-logs', (req, res) => {
  const { user_id, action, changed_field, limit = 100, offset = 0 } = req.query;
  
  let query = `
    SELECT al.*, u.username 
    FROM audit_logs al 
    LEFT JOIN users u ON al.user_id = u.user_id 
    WHERE 1=1
  `;
  const params = [];
  
  if (user_id) {
    query += ' AND al.user_id = ?';
    params.push(user_id);
  }
  
  if (action) {
    query += ' AND al.action = ?';
    params.push(action);
  }
  
  if (changed_field) {
    query += ' AND al.changed_field = ?';
    params.push(changed_field);
  }
  
  query += ' ORDER BY al.changed_at DESC LIMIT ? OFFSET ?';
  params.push(parseInt(limit), parseInt(offset));
  
  db.all(query, params, (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Get audit logs for a specific user
app.get('/audit-logs/user/:userId', (req, res) => {
  const { limit = 50, offset = 0 } = req.query;
  
  const query = `
    SELECT al.*, u.username 
    FROM audit_logs al 
    LEFT JOIN users u ON al.user_id = u.user_id 
    WHERE al.user_id = ? 
    ORDER BY al.changed_at DESC 
    LIMIT ? OFFSET ?
  `;
  
  db.all(query, [req.params.userId, parseInt(limit), parseInt(offset)], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Get audit log by ID
app.get('/audit-logs/:id', (req, res) => {
  const query = `
    SELECT al.*, u.username 
    FROM audit_logs al 
    LEFT JOIN users u ON al.user_id = u.user_id 
    WHERE al.log_id = ?
  `;
  
  db.get(query, [req.params.id], (err, row) => {
    if (err) return res.status(500).json({ error: err.message });
    if (!row) return res.status(404).json({ error: 'Audit log not found' });
    res.json(row);
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
