<template>
    <div>
        <logined-header  v-if="isShow"></logined-header>
        <my-header></my-header>
        <sider-menu></sider-menu>
        <rolling-img></rolling-img>
        <goods-category></goods-category>
        <sider-bar></sider-bar>
    </div>
</template>
<script>
import MyHeader from '@/components/global/header'
import LoginedHeader from '@/components/global/loginedheader'
import GoodsCategory from '@/components/global/goodsCategory'
import RollingImg from '@/components/global/rollingImg'
import SiderMenu from "../../components/global/siderMenu";
import SiderBar from "../../components/global/siderBar";
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
        GoodsCategory,
        RollingImg,
        SiderMenu
    }
}
</script>