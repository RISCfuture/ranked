<template>
  <p>
    Ranked uses the Elo algorithm find the relative rankings of items in your list.
    <a href="https://github.com/RISCfuture/ranked">Check out the source code on GitHub</a>
    to learn more, or send me a pull request to contribute.
  </p>
</template>

<script lang="ts">
  import Vue from 'vue'
  import Component from 'vue-class-component'

  @Component
  export default class FAQ extends Vue {}
</script>

<style scoped>
  p {
    margin-top: 50px;
    font-size: 13px;
  }
</style>
