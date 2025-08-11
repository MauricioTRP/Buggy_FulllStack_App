import { defineStore } from 'pinia'

export const useMainStore = defineStore('main', {
  state: () => ({
    user: null as null | { username: string; email: string },
    isAdmin: false,
  }),
  actions: {
    setUser(user: { username: string; email: string }) {
      this.user = user
    },
    setAdmin(isAdmin: boolean) {
      this.isAdmin = isAdmin
    },
    logout() {
      this.user = null
      this.isAdmin = false
    },
  },
})
