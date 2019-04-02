<template>
    <div class="home">
        <admin-header></admin-header>
        <admin-menu></admin-menu>
        <div class="main">
            <router-view></router-view>
        </div>
    </div>
</template>
<script>
import AdminHeader from '../../components/admin/adminheader'
import AdminMenu from '../../components/admin/adminmenu'
export default {
    name:'AdminHome',
    data(){
        return {
            
        }
    },
    created() {
        
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
.main{
    margin-top: 70px;
    box-sizing: border-box;
    border: 1px solid #ddd;
    position: relative;
    left: 11%;
    width: 89%;
    background: #fff;
    padding: 10px 10px;
}
</style>