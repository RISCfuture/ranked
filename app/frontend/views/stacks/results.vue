<template>
  <div>
    <h1>{{stack.name}}, ranked.</h1>
    <h2 v-if="shared">by {{$route.query.name}}</h2>

    <ol>
      <li v-for="ranking in stack.rankings">{{ranking.name}}</li>
    </ol>

    <p v-if="canShare"><a href="#" @click.prevent="share">Share with my friends.</a></p>
    <p v-if="shared">
      <router-link :to="{name: 'stack_rank', params: {id: $route.params.id}}">I want to rank {{stack.name}}!</router-link>
      <span class="dot">&middot;</span>
      <router-link :to="{name: 'stack_new'}">I’d like to make my own list of things to rank!</router-link>
    </p>
  </div>
</template>

<script lang="ts">
  import Vue from 'vue'
  import Component from 'vue-class-component'
  import * as _ from 'lodash';
  import Axios from 'axios'

  import {Stack} from 'types'

  @Component
  export default class Results extends Vue {
    stack?: Stack = null
    error?: Error = null

    get canShare(): boolean { return !this.$route.query.name }
    get shared(): string {
      if (_.isArray(this.$route.query.name))
        return this.$route.query.name[0]
      else
        return this.$route.query.name
    }

    share(_event: Event) {
      let name = prompt("What’s your name?")
      let route = this.$router.resolve({name: 'stack_results', params: {id: this.$route.params.id}, query: {m: this.$route.query.m, name: name}})
      let href = `${window.location.origin}${route.href}`
      prompt("Copy this link and share with your friends:", href)
    }

    mounted() {
      Axios.get(`/stacks/${this.$route.params.id}.json?m=${this.$route.query.m}`).then(({data}) => {
        this.stack = data
      }).catch(error => {
        this.error = error
      })
    }
  }
</script>

<style scoped>
  h2 {
    font-weight: 300;
  }

  ol {
    counter-reset: li;
    margin: 50px 0;
    padding: 0;
  }

  ol > li {
    font-size: 48px;
    font-weight: 500;
    list-style: none;
    line-height: 64px;
  }

  ol > li:before {
    content: '#' counter(li);
    counter-increment: li;
    display: inline-block;
    width: 100px;
    font-weight: 200;
    text-align: right;
    margin-right: 0.5em;
  }

  p {
    text-align: center;
  }

  span.dot {
    margin-left: 1em;
    margin-right: 1em;
  }
</style>
