<template>
  <div class="admin-audit">
    <h2>Admin: Audit Log</h2>
    <div class="filters">
      <label>User ID: <input v-model="filters.user_id" /></label>
      <label>Action: <input v-model="filters.action" /></label>
      <label>Field: <input v-model="filters.changed_field" /></label>
      <button @click="fetchLogs">Apply Filters</button>
      <button @click="clearFilters">Clear</button>
    </div>
    <div v-if="loading">Loading...</div>
    <div v-else-if="error" class="error">{{ error }}</div>
    <table v-else-if="logs.length">
      <thead>
        <tr>
          <th>User</th>
          <th>Action</th>
          <th>Field</th>
          <th>Old Value</th>
          <th>New Value</th>
          <th>Changed At</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="log in logs" :key="log.log_id">
          <td>{{ log.username || log.user_id }}</td>
          <td>{{ log.action }}</td>
          <td>{{ log.changed_field }}</td>
          <td>{{ log.old_value }}</td>
          <td>{{ log.new_value }}</td>
          <td>{{ log.changed_at }}</td>
        </tr>
      </tbody>
    </table>
    <div v-else>No audit logs found.</div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getAuditLogs } from '../services/auditService'

const logs = ref<any[]>([])
const loading = ref(false)
const error = ref('')
const filters = ref({
  user_id: '',
  action: '',
  changed_field: '',
})

const fetchLogs = async () => {
  loading.value = true
  error.value = ''
  try {
    const filterParams: any = {}
    if (filters.value.user_id) filterParams.user_id = filters.value.user_id
    if (filters.value.action) filterParams.action = filters.value.action
    if (filters.value.changed_field) filterParams.changed_field = filters.value.changed_field
    logs.value = await getAuditLogs(filterParams)
  } catch (e: any) {
    error.value = e.message || 'Failed to fetch audit logs.'
  } finally {
    loading.value = false
  }
}

const clearFilters = () => {
  filters.value = { user_id: '', action: '', changed_field: '' }
  fetchLogs()
}

onMounted(fetchLogs)
</script>

<style scoped>
.admin-audit {
  max-width: 1200px;
  margin: 2rem auto;
  padding: 2rem;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #fafafa;
}
.filters {
  margin-bottom: 1rem;
  display: flex;
  gap: 1rem;
  align-items: center;
  flex-wrap: wrap;
}
.filters label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}
.filters input {
  padding: 0.25rem;
}
.filters button {
  padding: 0.5rem 1rem;
  background: #42b983;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 1rem;
}
th, td {
  border: 1px solid #ddd;
  padding: 0.5rem;
  text-align: left;
  font-size: 0.9rem;
}
th {
  background: #f5f5f5;
}
.error {
  color: #d32f2f;
  margin-top: 1rem;
}
</style>
