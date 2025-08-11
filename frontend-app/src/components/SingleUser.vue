<template>
  <div class="single-user">
    <h2>User Details</h2>
    <div v-if="loading">Loading...</div>
    <div v-else-if="error" class="error">{{ error }}</div>
    <div v-else-if="user">
      <ul>
        <li><strong>ID:</strong> {{ user.user_id }}</li>
        <li><strong>Username:</strong> {{ user.username }}</li>
        <li><strong>Email:</strong> {{ user.email }}</li>
        <li><strong>Status:</strong> {{ user.status }}</li>
      </ul>
    </div>
    <div v-else>No user found.</div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { getUserProfile } from '../services/userService'

const route = useRoute()
const user = ref<any>(null)
const error = ref('')
const loading = ref(true)

onMounted(async () => {
  loading.value = true
  error.value = ''
  try {
    user.value = await getUserProfile(Number(route.params.id))
  } catch (e: any) {
    error.value = e.message || 'Failed to fetch user.'
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.single-user {
  max-width: 400px;
  margin: 2rem auto;
  padding: 2rem;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #fafafa;
}
ul {
  list-style: none;
  padding: 0;
}
li {
  margin-bottom: 0.5rem;
}
.error {
  color: #d32f2f;
  margin-top: 1rem;
}
</style>
