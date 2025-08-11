<template>
  <div class="register">
    <h2>Register</h2>
    <form @submit.prevent="onSubmit">
      <div>
        <label for="username">Username</label>
        <input id="username" v-model="form.username" required />
      </div>
      <div>
        <label for="email">Email</label>
        <input id="email" v-model="form.email" type="email" required />
      </div>
      <div>
        <label for="password">Password</label>
        <input id="password" v-model="form.password" type="password" required />
      </div>
      <div>
        <label for="confirmPassword">Confirm Password</label>
        <input id="confirmPassword" v-model="form.confirmPassword" type="password" required />
      </div>
      <button type="submit">Register</button>
    </form>
    <div v-if="error" class="error">{{ error }}</div>
    <div v-if="success" class="success">{{ success }}</div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { registerUser } from '../services/userService'

const form = ref({
  username: '',
  email: '',
  password: '',
  confirmPassword: '',
})
const error = ref('')
const success = ref('')

const onSubmit = async () => {
  error.value = ''
  success.value = ''
  if (form.value.password !== form.value.confirmPassword) {
    error.value = 'Passwords do not match.'
    return
  }
  try {
    await registerUser({
      username: form.value.username,
      email: form.value.email,
      password: form.value.password,
    })
    success.value = 'Registration successful!'
    form.value = { username: '', email: '', password: '', confirmPassword: '' }
  } catch (e: any) {
    error.value = e.message || 'Registration failed. Please try again.'
  }
}
</script>

<style scoped>
.register {
  max-width: 400px;
  margin: 2rem auto;
  padding: 2rem;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #fafafa;
}
form > div {
  margin-bottom: 1rem;
}
label {
  display: block;
  margin-bottom: 0.25rem;
}
input {
  width: 100%;
  padding: 0.5rem;
  box-sizing: border-box;
}
button {
  width: 100%;
  padding: 0.75rem;
  background: #42b983;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
}
.error {
  color: #d32f2f;
  margin-top: 1rem;
}
.success {
  color: #388e3c;
  margin-top: 1rem;
}
</style>
