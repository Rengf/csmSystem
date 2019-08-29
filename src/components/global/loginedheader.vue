<template>
    <div class="loginedHeader">
        <div class="headerBox">
            <div class="userMsg">
                <a href="/"><img :src="userinfo.user_avatar" alt=""></a>
                <a href="/">{{userinfo.user_name}}</a>
                <router-link to="/adminhome" title="点击进入后台管理系统" v-if="isAdmin">（管理员）</router-link>
                <span @click="logout">退出登录</span>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
import { mapGetters} from "vuex";
export default {
  name: "LoginedHeader",
  data() {
    return {
    };
  },
  created() {
        this.$store.dispatch('getUserInfo');
  },
  computed: {
      ...mapGetters(['userinfo']),
      isAdmin(){
          return this.userinfo.isadmin==0?false:true
      }
  },
  methods: {
    logout() {
        this.$store.dispatch('logout');
        localStorage.removeItem('token');
    }
  }
};
</script>

<style scoped>
.loginedHeader {
    position: fixed;
    top: 0;
    left: 0;
    height: 40px;
    width: 100%;
    border: 1px solid #aaa;
    background: -webkit-linear-gradient(#fff, #ddd); 
    background: -o-linear-gradient(#fff, #ddd); 
    background: -moz-linear-gradient(#fff, #ddd); 
    background: linear-gradient(#fff, #ddd); 
    z-index: 9999;
}
.headerBox{
    width: 1200px;
    height: 40px;
    margin: auto;
}
.userMsg span {
    display: inline-block;
    width: 70px;
    height: 30px;
    line-height: 30px;
    font-size: 15px;
    text-align: center;
    color: #1b7ad1;
}
.userMsg span:hover{
    cursor: pointer;
}
.userMsg a{
    display: inline-block;
    line-height: 40px;
    color: #555;
    font-size: 15px;
}
.userMsg a img{
    vertical-align: middle;
    width: 35px; 
    height: 35px;
    border-radius: 50%;
}
</style>