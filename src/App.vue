<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
import {mapGetters} from 'vuex'
export default {
  name: 'App',
  created() {
     this.$store.dispatch('getUserInfo');
        window.mirrorCommandQueue = {
          system: 'aaaa',
          user: localStorage.getItem("username")||''
      }
    },
    computed: {
      ...mapGetters(['userinfo'])
    },
}
</script>

<style>
@import url(./assets/css/reset.css);
@import url(./assets/css/iconfont/iconfont.css);
</style>
