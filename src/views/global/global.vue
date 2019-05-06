<template>
    <div class="globalbox">
        <logined-header  v-if="isShow"></logined-header>
        <my-header></my-header>
        <router-view></router-view>
        <sider-bar></sider-bar>
    </div>
</template>
<script>
import MyHeader from '@/components/global/header'
import LoginedHeader from '@/components/global/loginedheader'
import SiderBar from "@/components/global/siderBar";
import {mapGetters} from 'vuex'
export default {
    data(){
        return{
            
        }
    },
    created() {
        this.$store.dispatch('getUserInfo');
    },
     watch: {
        isShow: {
            handler(newValue, oldValue) {
                this.userinfo.user_name = newValue;
            }
        }
    },
    computed: {
        ...mapGetters(['userinfo']),
        isShow(){
                return (this.userinfo.user_name?true:false)
            }
    },
    methods: {
      
    },
    components:{
        LoginedHeader,
        MyHeader,
        SiderBar,
    }
}
</script>