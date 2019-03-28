<template>
    <div>
        <logined-header  v-if="isShow"></logined-header>
        <goods-category></goods-category>
        <sider-bar></sider-bar>
    </div>
</template>
<script>
import LoginedHeader from '@/components/global/loginedheader'
import SiderBar from "../../components/global/siderBar";
import GoodsCategory from "../../components/global/goodsCategory";
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
        SiderBar,
        GoodsCategory,
    }
}
</script>