-- SQLite does not support CREATE DATABASE or USE statements
-- PRAGMA foreign_keys = ON is recommended for enforcing foreign keys
PRAGMA foreign_keys = ON;

-- 1. users Table

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TEXT DEFAULT 'active'
);

-- 2. user_profiles Table

CREATE TABLE user_profiles (
    profile_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    first_name TEXT,
    last_name TEXT,
    phone_number TEXT,
    address TEXT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 3. audit_logs Table

CREATE TABLE audit_logs (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    action TEXT,
    changed_field TEXT,
    old_value TEXT,
    new_value TEXT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Optional: Indexes for faster QC queries

CREATE INDEX idx_user_status ON users(status);
CREATE INDEX idx_profile_user_id ON user_profiles(user_id);
CREATE INDEX idx_log_user_id ON audit_logs(user_id);
