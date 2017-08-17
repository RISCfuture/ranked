<template>
  <div>
    <h1>Sorry, you took a wrong turn somewhere.</h1>
    <p>Try <router-link :to="{name: 'stack_new'}">going back to the home page</router-link>.</p>
  </div>
</template>

<style scoped>
  h1 {
    font-size: 36px;
    font-weight: 200;
  }
</style>
