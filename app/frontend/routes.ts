import {RouteConfig} from 'vue-router'

import StacksNew from 'views/stacks/New'
import StacksRank from 'views/stacks/Rank'
import StacksResults from 'views/stacks/Results'
import PageNotFound from 'views/PageNotFound'

const routes: RouteConfig[] = [
  {path: '/', component: StacksNew, name: 'stack_new'},
  {path: '/stacks/:id', component: StacksRank, name: 'stack_rank'},
  {
    path: '/stacks/:id/results',
    component: StacksResults,
    props: route => ({stackID: route.params.id}),
    name: 'stack_results'
  },
  { path: "*", component: PageNotFound }
]

export default routes
