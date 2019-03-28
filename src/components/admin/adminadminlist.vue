<template>
    <div class="adminlist">
        <div class="userlistbox">
        <table>
            <thead>
                <tr>
                    <th width="30">#</th>
                    <th width="120">用户名</th>
                    <th width="100">真实姓名</th>
                    <th width="150">用户类型</th>
                    <th width="100">注册电话</th>
                    <th width="150">注册邮箱</th>
                    <th width="180">注册时间</th>
                    <th width="180">最后修改时间</th>
                    <th width="70">登录统计</th>
                    <th width="180">上次登录</th>
                    <th width="100">操作</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(user,index) in adminlist" :key="index">
                    <td>{{index+1}}</td>
                    <td><router-link :to="{path:'/admin/userinfo?user_id='+user.user_id}">{{user.user_name}}</router-link></td>
                    <td>{{user.real_name==null?'未实名':user.real_name}}</td>
                    <td>{{user.isadmin=='1'?'普通管理员':'超级管理员'}}</td>
                    <td>{{user.user_tel}}</td>
                    <td>{{user.user_email}}</td>
                    <td>{{user.regist_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                    <td>{{user.last_modified_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                    <td>{{user.statistics}}</td>
                    <td>{{user.last_login_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                    <td><button @click="deleteuser(user.user_id)">删除</button></td>
                </tr>
            </tbody>
        </table>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import {mapActions,mapGetters} from 'vuex'
export default {
    name:'userlist',
    data(){
        return{
            
        }
    },
    created() {
       this.$store.dispatch('getAdminlist')
    },
    computed: {
        ...mapGetters(['adminlist'])
    },
    methods: {
        getuserlist(){
           
        },
        deleteuser(id){
            axios.post('http://localhost:3333/admin/deleteuser',{
               user_id:id
           }).then(
               response=>{
                   if(response.data.code==0){
                       this.$store.dispatch('getAdminlist')
                       console.log(response.data.message)
                   }else{
                       console.log("删除失败");
                   }
               },
               response=>{
                   console.log("error:"+response)
               }
           )
        }
    },
}
</script>
<style scoped>
.adminlist{
    box-sizing: border-box;
    position: relative;
    left: 11%;
    width: 89%;
    background: #fff;
    padding: 10px 10px;
}
.userlistbox{
    padding: 20px;
    border: 1px solid #ccc;
}
.adminlist table{
    display: block;
}

/* .userlist th:nth-child(1){
    width: 20px;
} */
.adminlist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.adminlist th{
    height: 29px;
    line-height: 29px;
    padding: 5px 10px;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #666;
    text-align: center;
}
.adminlist td{
    padding: 5px 30px;
    line-height: 30px;
    vertical-align: middle;
    border: 1px solid #ddd;
    color: #666;
    text-align: center;
    font-size: 12px;
}
tr:hover{
    background: rgb(174, 241, 253);
}
button{
    width: 70px;
    outline: 0;
    background: #3a8ee6;
    border: 0px;
    color: #fff;
}
button:hover{
    cursor: pointer;
}
</style>
