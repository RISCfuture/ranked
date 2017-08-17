import StacksNew from './views/stacks/new.vue'
import StacksRank from './views/stacks/rank.vue'
import StacksResults from './views/stacks/results.vue'
import PageNotFound from './views/page_not_found.vue'

export default [
  {path: '/', component: StacksNew, name: 'stack_new'},
  {path: '/stacks/:id', component: StacksRank, name: 'stack_rank'},
  {
    path: '/stacks/:id/results',
    component: StacksResults,
    props: (route) => ({stackID: route.params.id}),
    name: 'stack_results'
  },
  { path: "*", component: PageNotFound }
]
