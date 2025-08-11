const API_BASE = 'http://localhost:3000';

export async function registerUser(data: { username: string; email: string; password: string }) {
  const res = await fetch(`${API_BASE}/users`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username: data.username, email: data.email, status: 'active' })
  });
  if (!res.ok) throw new Error((await res.json()).error || 'Registration failed');
  return await res.json();
}

// Mock login (since backend has no auth)
export async function loginUser(data: { usernameOrEmail: string; password: string }) {
  // Simulate login by fetching user by username or email
  const res = await fetch(`${API_BASE}/users`);
  if (!res.ok) throw new Error('Login failed');
  const users = await res.json();
  const user = users.find((u: any) => u.username === data.usernameOrEmail || u.email === data.usernameOrEmail);
  if (!user) throw new Error('User not found');
  return user;
}

export async function getUserProfile(userId: number) {
  const res = await fetch(`${API_BASE}/users/${userId}`);
  if (!res.ok) throw new Error((await res.json()).error || 'Failed to fetch user');
  const user = await res.json();
  // Try to fetch profile
  const profileRes = await fetch(`${API_BASE}/user_profiles/${userId}`);
  let profile = {};
  if (profileRes.ok) profile = await profileRes.json();
  return { ...user, ...profile };
}

export async function updateUserProfile(userId: number, data: {
  username: string;
  email: string;
  status: string;
  first_name?: string;
  last_name?: string;
  phone_number?: string;
  address?: string;
}) {
  const res = await fetch(`${API_BASE}/users/${userId}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  });
  if (!res.ok) throw new Error((await res.json()).error || 'Update failed');
  return await res.json();
}
