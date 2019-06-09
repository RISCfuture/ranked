<template>
  <div>
    <template v-if="error">
      <h1 class="error">Sorry, an error occurred.</h1>
      <p class="error">{{error}}</p>
    </template>

    <template v-if="loaded">
      <h2>Let’s Rank {{stack.name}}.</h2>

      <p>Which is better?</p>

      <div class="match-pair" v-if="match">
        <div class="first"><a href="#" @click.prevent="choose(1)">{{match[0].name}}</a></div>
        <div class="both"><a href="#" @click.prevent="choose(3)">They’re about equal.</a></div>
        <div class="second"><a href="#" @click.prevent="choose(2)">{{match[1].name}}</a></div>
      </div>

      <p>
        <span id="number-remaining">{{remaining}} remaining.</span>
        <span v-if="matches.length" id="skip-to-end"><br />Or, if you’d like, you can <router-link :to="{name: 'stack_results', query: $route.query}">see your results right now.</router-link></span>
      </p>
    </template>
  </div>
</template>

<script lang="ts">
  import Vue from 'vue';
  import Component from 'vue-class-component'
  import * as _ from 'lodash'
  import Axios from 'axios'
  import * as numeral from 'numeral'

  import * as coding from 'utilities/coding'
  import {Card, Stack} from 'types'

  @Component
  export default class Rank extends Vue {
    stack?: Stack = null
    error?: Error = null

    get loaded(): boolean {
      return !_.isNull(this.stack)
    }

    get matches(): number[] {
      if (!this.$route.query.m)
        return []
      else if (_.isArray(this.$route.query.m))
        return coding.decode(this.$route.query.m[0])
      else
        return coding.decode(this.$route.query.m)
    }

    get match(): [Card, Card] {
      if (!this.stack || !this.stack.pairs_order) return null
      let indexes = this.stack.pairs_order[this.matches.length]
      return [
        this.stack.cards[indexes[0]],
        this.stack.cards[indexes[1]]
      ]
    }

    get remaining(): string {
      let remaining = this.stack.pairs_order.length - this.matches.length
      let remainingStr = numeral(remaining).format('0,0')
      let choice = (remaining === 1) ? "choice" : "choices"
      return `${remainingStr} ${choice}`
    }

    choose(choice: number) {
      let results = this.matches.concat([choice])
      if (results.length >= this.stack.pairs_order.length)
        this.$router.push({name: 'stack_results', query: {m: coding.encode(results)}})
      else
        this.$router.push({query: {m: coding.encode(results)}})
    }

    mounted() {
      Axios.get(`/stacks/${this.$route.params.id}.json`).then(({data}) => {
        this.stack = data
      }).catch(error => {
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

  #number-remaining {
    font-weight: 300;
  }

  #skip-to-end {
    font-weight: 200;
  }
</style>
