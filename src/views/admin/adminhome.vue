<template>
    <div class="home">
        <admin-header :user="user"></admin-header>
        <admin-menu></admin-menu>
        <router-view></router-view>
    </div>
</template>
<script>
import AdminHeader from '../../components/admin/adminheader'
import AdminMenu from '../../components/admin/adminmenu'
export default {
    name:'AdminHome',
    data(){
        return {
            user:{},
            showbg:false
        }
    },
    created() {
        this.user=JSON.parse(localStorage.getItem('user'))
    },
    methods: {
    },
    components:{
        AdminMenu,
        AdminHeader,
    }
    
}
</script>
<style scoped>
.home{
    overflow: hidden;
}
</style>