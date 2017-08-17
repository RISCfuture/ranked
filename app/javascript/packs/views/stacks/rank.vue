<template>
  <div>
    <h1 class="error" v-if="error">Sorry, an error occurred.</h1>
    <p class="error" v-if="error">{{error}}</p>

    <template v-else>
      <h2>Let’s Rank {{stack.name}}.</h2>

      <p>Which is better?</p>

      <div class="match-pair" v-if="match">
        <div class="first"><a href="#" @click.prevent="choose(1)">{{match[0].name}}</a></div>
        <div class="both"><a href="#" @click.prevent="choose(3)">They’re about equal.</a></div>
        <div class="second"><a href="#" @click.prevent="choose(2)">{{match[1].name}}</a></div>
      </div>

      <p>
        <span>{{remaining}} remaining.</span>
        <span v-if="match">Or, if you’d like, you can <router-link :to="{name: 'stack_results', query: {m: $route.query.m}}">see your results right now.</router-link></span>
      </p>
    </template>
  </div>
</template>

<script>
  import _ from 'lodash'
  import axios from 'axios'
  import numeral from 'numeral'
  import coding from './encoder'

  export default {
    data() {
      return {
        stack: {},
        error: null
      }
    },

    computed: {
      results() {
        if (!this.$route.query.m) return []
        else return coding.decode(this.$route.query.m)
      },

      match() {
        if (!this.stack || !this.stack.pairs_order) return null
        let indexes = this.stack.pairs_order[this.results.length]
        return _.map(indexes, (i) => this.stack.cards[i])
      },

      remaining() {
        let remaining = this.stack.pairs_order.length - this.results.length
        let remainingStr = numeral(remaining).format('0,0')
        let choice = (remaining === 1) ? "choice" : "choices"
        return `${remainingStr} ${choice}`
      }
    },

    methods: {
      choose(choice) {
        let results = this.results.concat([choice])
        if (results.length >= this.stack.pairs_order.length)
          this.$router.push({name: 'stack_results', query: {m: coding.encode(results)}})
        else
          this.$router.push({query: {m: coding.encode(results)}})
      }
    },

    mounted() {
      axios.get(`/stacks/${this.$route.params.id}.json`).then(({data}) => {
        this.stack = data
      }).catch((error) => {
        this.error = error.toString()
      })
    }
  }
</script>

<style scoped>
  h2 {
    margin-bottom: 100px;
  }

  p:not(.error) {
    font-size: 18px;
    font-weight: 500;
    text-align: center;
  }

  .match-pair {
    border: 4px solid black;
    margin: 20px auto 60px auto;
    padding: 20px;
    max-width: calc(960px/2); /* TODO variable */
  }

  .first, .second {
    font-size: 36px;
    font-weight: 700;
  }

  .first {
    text-align: right;
  }

  .second {
    text-align: left;
  }

  .both {
    text-align: center;
    margin: 30px 0;
  }
</style>
