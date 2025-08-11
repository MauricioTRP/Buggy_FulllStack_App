const API_BASE = 'http://localhost:3000';

export async function getAuditLogs(filters?: {
  user_id?: string;
  action?: string;
  changed_field?: string;
  limit?: number;
  offset?: number;
}) {
  const params = new URLSearchParams();
  if (filters?.user_id) params.append('user_id', filters.user_id);
  if (filters?.action) params.append('action', filters.action);
  if (filters?.changed_field) params.append('changed_field', filters.changed_field);
  if (filters?.limit) params.append('limit', filters.limit.toString());
  if (filters?.offset) params.append('offset', filters.offset.toString());

  const res = await fetch(`${API_BASE}/audit-logs?${params}`);
  if (!res.ok) throw new Error((await res.json()).error || 'Failed to fetch audit logs');
  return await res.json();
}

export async function getAuditLogsByUser(userId: string, limit = 50, offset = 0) {
  const res = await fetch(`${API_BASE}/audit-logs/user/${userId}?limit=${limit}&offset=${offset}`);
  if (!res.ok) throw new Error((await res.json()).error || 'Failed to fetch user audit logs');
  return await res.json();
}

export async function getAuditLogById(logId: string) {
  const res = await fetch(`${API_BASE}/audit-logs/${logId}`);
  if (!res.ok) throw new Error((await res.json()).error || 'Failed to fetch audit log');
  return await res.json();
}
