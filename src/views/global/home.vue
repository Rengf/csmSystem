<template>
    <div>
        <logined-header  v-if="isShow"></logined-header>
    </div>
</template>
<script>
import LoginedHeader from '@/components/global/loginedheader'
import axios from 'axios'
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
    }
}
</script>