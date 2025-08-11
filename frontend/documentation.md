# Frontend Requirements Documentation

This document outlines the requirements for the frontend screens that interact with the backend API.

## 1. Normal User Screens

### 1.1. Registration Screen
- Allow new users to create an account.
- Fields: Username, Email, Password (if implemented), Confirm Password.
- On successful registration, redirect to login or profile page.

### 1.2. Login Screen
- Allow users to log in (if authentication is implemented).
- Fields: Username/Email, Password.
- On successful login, redirect to user profile.

### 1.3. User Profile Screen
- Display current user data (username, email, status, profile info).
- Allow user to update their profile information (first name, last name, phone number, address).
- Allow user to update their account data (username, email, status).
- Show feedback on successful or failed updates.

## 2. Admin Screens

### 2.1. User List Screen
- Display a list of all users.
- Allow admin to view user details and status.

### 2.2. Audit Log Screen
- Display a list of all modifications made by users (from the audit_logs table).
- Show: User, Action, Changed Field, Old Value, New Value, Changed At.
- Allow filtering by user, action, or date.

## 3. General Requirements
- Responsive design for desktop and mobile.
- Clear navigation between screens.
- Use API endpoints as defined in the backend documentation.
- Show error and success messages for all user actions.


## 4. Optional Enhancements
- Authentication and authorization for protected routes.
- Admin dashboard with statistics.
- User password management (if implemented in backend).
