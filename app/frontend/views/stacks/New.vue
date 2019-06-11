<template>
  <div>
    <h1>Ranked.</h1>
    <h6>
      Make a list of things, then let us help you (and others) rank them. Start your list:</h6>

    <form method="post" action="/stacks.json" @submit.prevent="create">
      <header>
        <field type="text"
               name="stack[name]"
               required
               class="inline"
               :maxlength="126"
               :placeholder="placeholder.name"
               v-model.trim="stack.name"
               :errors="errors" />
        <p>, ranked.</p>
      </header>

      <article>
        <p>
          Start listing things. The order doesn’t matter; you’ll rank them later.</p>
        <field type="textarea"
               name="stack[card_names]"
               required
               :placeholder="placeholderCardNames"
               v-model="stack.card_names"
               :errors="errors" />

        <input type="submit" name="commit" value="Let’s Rank" />
      </article>
    </form>

    <faq />
  </div>
</template>

<script lang="ts">
  import Vue from 'vue'
  import Component from 'vue-class-component'
  import * as _ from 'lodash'
  import Axios from 'axios'

  import {Errors} from 'types'
  import defaultPlaceholders, {Example} from './examples'
  import Field from '../../components/Field'
  import FAQ from '../FAQ'

  interface ScratchStack {
    name?: string
    card_names?: string
  }

  @Component({
    components: {Field, faq: FAQ}
  })
  export default class New extends Vue {
    stack: ScratchStack = {}
    errors: Errors = {}
    placeholder?: Example = null

    get placeholderCardNames(): string {
      return this.placeholder.cardNames.join("\n")
    }

    create() {
      Axios.post('/stacks.json', {stack: this.stack}).then(({data}) => {
        this.$router.push({name: 'stack_rank', params: {id: data.id}})
      }).catch(error => {
        if (error.response && error.response.status === 422) {
          this.errors = error.response.data.errors
        }
        else alert(error) //TODO
      })
    }

    created() {
      this.placeholder = _.clone(_.sample(defaultPlaceholders))
      this.placeholder.cardNames = _.shuffle(this.placeholder.cardNames)
    }
  }
</script>

<style scoped>
  header {
    background-color: #dadada;
    padding: 10px;
  }

  article {
    padding: 20px 10px;
    background-color: #efefef;
  }

  header {
    display: flex;
    flex-flow: row nowrap;
    align-items: baseline;
    font-size: 36px;
    line-height: 36px;
    font-weight: 300;
  }

  header > div {
    flex: 1 1 auto;
    max-width: 600px;
  }

  header > p {
    flex: 0 0 auto;
  }

  h6 {
    margin-bottom: 50px;
  }

  input[type=submit] {
    margin-top: 20px;
  }
</style>
