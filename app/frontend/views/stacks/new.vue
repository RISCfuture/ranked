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
               :placeholder="placeholder.cardNames"
               v-model="stack.card_names"
               :errors="errors" />

        <input type="submit" name="commit" value="Let’s Rank" />
      </article>
    </form>

    <faq />
  </div>
</template>

<script>
  import _ from 'lodash'
  import defaultPlaceholders from './examples'
  import axios from 'axios'
  import Field from '../../components/field.vue'
  import FAQ from '../faq.vue'

  export default {
    components: {Field, faq: FAQ},

    data() {
      let placeholder = _.sample(defaultPlaceholders)
      placeholder.cardNames = _.shuffle(placeholder.cardNames).join("\n")
      return {
        stack: {},
        errors: {},
        placeholder
      }
    },

    methods: {
      create() {
        axios.post('/stacks.json', {stack: this.stack}).then(({data}) => {
          console.debug(data)
          this.$router.push({name: 'stack_rank', params: {id: data.id}})
        }).catch((error) => {
          if (error.response && error.response.status === 422) {
            this.errors = error.response.data.errors
          }
          else alert(error) //TODO
        })
      }
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
