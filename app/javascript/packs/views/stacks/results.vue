<template>
  <div>
    <h1>{{stack.name}}, ranked.</h1>
    <h2 v-if="shared">by {{$route.query.name}}</h2>

    <ol>
      <li v-for="ranking in stack.rankings">{{ranking.name}}</li>
    </ol>

    <p v-if="canShare"><a href="#" @click.prevent="share">Share with my friends.</a></p>
    <p v-if="shared"><router-link :to="{name: 'stack_new'}">I’d like to rank something now!</router-link></p>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    data() {
      return {
        stack: {},
        error: null
      }
    },

    computed: {
      canShare() { return !this.$route.query.name },
      shared() { return this.$route.query.name }
    },

    methods: {
      share(_event) {
        let name = prompt("What’s your name?")
        let route = this.$router.resolve({name: 'stack_results', params: {id: this.$route.params.id}, query: {m: this.$route.query.m, name: name}})
        let href = `${window.location.origin}${route.href}`
        prompt("Copy this link and share with your friends:", href)
      }
    },

    mounted() {
      axios.get(`/stacks/${this.$route.params.id}.json?m=${this.$route.query.m}`).then(({data}) => {
        this.stack = data
      }).catch((error) => {
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
</style>
