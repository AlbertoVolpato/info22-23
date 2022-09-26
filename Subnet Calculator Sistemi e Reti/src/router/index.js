import { createRouter, createWebHistory } from 'vue-router'
import SubnetCalculator from '../views/SubnetCalculator.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: SubnetCalculator
    }
  ]
})

export default router
