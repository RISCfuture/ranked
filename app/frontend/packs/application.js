/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'

import VueRouter from 'vue-router'
import routes from 'routes'
Vue.use(VueRouter)
const router = new VueRouter({routes, mode: 'history'})

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

import Layout from 'views/layout.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    render: create => create(Layout),
    router
  }).$mount('#app');
})

import 'normalize.css'
import 'stylesheets/fonts.scss'
import 'stylesheets/common.sass'
