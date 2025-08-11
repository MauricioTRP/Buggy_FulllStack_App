const API_BASE = 'http://localhost:3000';

export async function getAllUsers() {
  const res = await fetch(`${API_BASE}/users`);
  if (!res.ok) throw new Error((await res.json()).error || 'Failed to fetch users');
  return await res.json();
}

export async function deleteUser(userId: number) {
  const res = await fetch(`${API_BASE}/users/${userId}`, { method: 'DELETE' });
  if (!res.ok) throw new Error((await res.json()).error || 'Failed to delete user');
  return await res.json();
}
