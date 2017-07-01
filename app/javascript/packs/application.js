/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual
// application logic in a relevant structure within app/javascript and only use
// these pack files to reference that code so it'll be compiled.  To reference
// this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'

import VueRouter from 'vue-router'
Vue.use(VueRouter)
import routes from './routes'

import 'normalize.css'
import './stylesheets/fonts.css'
import './stylesheets/common.sass'

// add interceptor to add CSRF tokens to request
import axios from 'axios'
axios.interceptors.request.use(function(config) {
  if (config.method !== 'get') {
    let tokenName = document.querySelector('meta[name=csrf-param]')
                            .getAttribute('content')
    let tokenValue = document.querySelector('meta[name=csrf-token]')
                             .getAttribute('content')
    let data = config.data ? config.data : new FormData()
    data[tokenName] = tokenValue
    config.data = data
  }

  return config
})


document.addEventListener('DOMContentLoaded', () => {
  new Vue({
            el: '#app',
            router: new VueRouter({routes, mode: 'history'})
          })
})
