<template>
  <div class="login">
    <h2>Login</h2>
    <form @submit.prevent="onSubmit">
      <div>
        <label for="usernameOrEmail">Username or Email</label>
        <input id="usernameOrEmail" v-model="form.usernameOrEmail" required />
      </div>
      <div>
        <label for="password">Password</label>
        <input id="password" v-model="form.password" type="password" required />
      </div>
      <button type="submit">Login</button>
    </form>
    <div v-if="error" class="error">{{ error }}</div>
    <div v-if="success" class="success">{{ success }}</div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { loginUser } from '../services/userService'

const form = ref({
  usernameOrEmail: '',
  password: '',
})
const error = ref('')
const success = ref('')

const onSubmit = async () => {
  error.value = ''
  success.value = ''
  try {
    await loginUser({
      usernameOrEmail: form.value.usernameOrEmail,
      password: form.value.password,
    })
    success.value = 'Login successful!'
    form.value = { usernameOrEmail: '', password: '' }
  } catch (e: any) {
    error.value = e.message || 'Login failed. Please try again.'
  }
}
</script>

<style scoped>
.login {
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
