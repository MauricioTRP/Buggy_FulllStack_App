<script setup lang="ts">
</script>

<template>
  <nav>
    <router-link to="/">Home</router-link> |
    <router-link to="/register">Register</router-link> |
    <router-link to="/login">Login</router-link> |
    <router-link to="/profile">Profile</router-link> |
    <router-link to="/users/1">Single User</router-link> |
    <router-link to="/admin/users">Admin: Users</router-link> |
    <router-link to="/admin/audit">Admin: Audit Log</router-link>
  </nav>
  <router-view />
</template>

<style scoped>
nav {
  margin-bottom: 1rem;
}
nav a {
  margin-right: 0.5rem;
  text-decoration: none;
  color: #42b983;
}
nav a.router-link-exact-active {
  font-weight: bold;
}
</style>
