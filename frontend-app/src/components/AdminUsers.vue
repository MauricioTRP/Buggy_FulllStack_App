<template>
  <div class="admin-users">
    <h2>Admin: User List</h2>
    <div v-if="error" class="error">{{ error }}</div>
    <div v-if="success" class="success">{{ success }}</div>
    <table v-if="users.length">
      <thead>
        <tr>
          <th>ID</th>
          <th>Username</th>
          <th>Email</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user.user_id">
          <td>{{ user.user_id }}</td>
          <td>{{ user.username }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.status }}</td>
          <td>
            <button @click="onDelete(user.user_id)">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <div v-else>No users found.</div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getAllUsers, deleteUser } from '../services/adminService'

const users = ref<any[]>([])
const error = ref('')
const success = ref('')

const fetchUsers = async () => {
  error.value = ''
  try {
    users.value = await getAllUsers()
  } catch (e: any) {
    error.value = e.message || 'Failed to fetch users.'
  }
}

onMounted(fetchUsers)

const onDelete = async (userId: number) => {
  error.value = ''
  success.value = ''
  try {
    await deleteUser(userId)
    success.value = 'User deleted.'
    await fetchUsers()
  } catch (e: any) {
    error.value = e.message || 'Failed to delete user.'
  }
}
</script>

<style scoped>
.admin-users {
  max-width: 800px;
  margin: 2rem auto;
  padding: 2rem;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #fafafa;
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
}
th {
  background: #f5f5f5;
}
button {
  background: #d32f2f;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 0.5rem 1rem;
  cursor: pointer;
}
.success {
  color: #388e3c;
  margin-top: 1rem;
}
.error {
  color: #d32f2f;
  margin-top: 1rem;
}
</style>
