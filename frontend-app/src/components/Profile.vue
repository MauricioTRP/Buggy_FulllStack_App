<template>
  <div class="profile">
    <h2>User Profile</h2>
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
        <label for="status">Status</label>
        <input id="status" v-model="form.status" />
      </div>
      <div>
        <label for="firstName">First Name</label>
        <input id="firstName" v-model="form.first_name" />
      </div>
      <div>
        <label for="lastName">Last Name</label>
        <input id="lastName" v-model="form.last_name" />
      </div>
      <div>
        <label for="phone">Phone Number</label>
        <input id="phone" v-model="form.phone_number" />
      </div>
      <div>
        <label for="address">Address</label>
        <input id="address" v-model="form.address" />
      </div>
      <button type="submit">Update Profile</button>
    </form>
    <div v-if="error" class="error">{{ error }}</div>
    <div v-if="success" class="success">{{ success }}</div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getUserProfile, updateUserProfile } from '../services/userService'

const userId = 1 // TODO: Replace with actual logged-in user id
const form = ref({
  username: '',
  email: '',
  status: '',
  first_name: '',
  last_name: '',
  phone_number: '',
  address: '',
})
const error = ref('')
const success = ref('')

onMounted(async () => {
  try {
    const user = await getUserProfile(userId)
    form.value.username = user.username
    form.value.email = user.email
    form.value.status = user.status
    form.value.first_name = user.first_name || ''
    form.value.last_name = user.last_name || ''
    form.value.phone_number = user.phone_number || ''
    form.value.address = user.address || ''
  } catch (e: any) {
    error.value = e.message || 'Failed to load profile.'
  }
})

const onSubmit = async () => {
  error.value = ''
  success.value = ''
  try {
    await updateUserProfile(userId, {
      username: form.value.username,
      email: form.value.email,
      status: form.value.status,
      first_name: form.value.first_name,
      last_name: form.value.last_name,
      phone_number: form.value.phone_number,
      address: form.value.address,
    })
    success.value = 'Profile updated successfully!'
  } catch (e: any) {
    error.value = e.message || 'Update failed. Please try again.'
  }
}
</script>

<style scoped>
.profile {
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
