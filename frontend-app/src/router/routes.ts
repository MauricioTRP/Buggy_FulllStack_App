import { RouteRecordRaw } from 'vue-router'

export const routes: RouteRecordRaw[] = [
  { path: '/', name: 'Home', component: () => import('../components/Home.vue') },
  { path: '/register', name: 'Register', component: () => import('../components/Register.vue') },
  { path: '/login', name: 'Login', component: () => import('../components/Login.vue') },
  { path: '/profile', name: 'Profile', component: () => import('../components/Profile.vue') },
  { path: '/admin/users', name: 'AdminUsers', component: () => import('../components/AdminUsers.vue') },
  { path: '/admin/audit', name: 'AdminAudit', component: () => import('../components/AdminAudit.vue') },
  { path: '/users/:id', name: 'SingleUser', component: () => import('../components/SingleUser.vue') },
]

export default routes;
