<template>
    <div class="userlist">
        <table>
            <thead>
                <tr>
                    <th width="30">#</th>
                    <th width="100">用户名</th>
                    <th width="100">真实姓名</th>
                    <th width="150">用户类型</th>
                    <th width="100">注册电话</th>
                    <th width="150">注册邮箱</th>
                    <th width="150">注册时间</th>
                    <th width="150">上次登录</th>
                    <th width="100">操作</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(user,index) in userlist" :key="index">
                    <td>{{index+1}}</td>
                    <td>{{user.user_name}}</td>
                    <td>{{user.real_name==null?'未实名':user.real_name}}</td>
                    <td>{{user.isadmin=='0'?'普通用户':(user.isadmin=='1'?'普通管理员':'超级管理员')}}</td>
                    <td>{{user.user_tel}}</td>
                    <td>{{user.user_email}}</td>
                    <td>{{user.created_time.substring(0,10)}}</td>
                    <td>{{user.last_login_time}}</td>
                    <td><button @click="deleteuser(user._id)">删除</button></td>
                </tr>
            </tbody>
        </table>
    </div>
</template>
<script>
import {mapActions,mapGetters} from 'vuex'
export default {
    name:'userlist',
    data(){
        return{
            
        }
    },
    created() {
       this.$store.dispatch('getUserlist')
    },
    computed: {
        ...mapGetters(['userlist'])
    },
    methods: {
        getuserlist(){
           
        },
        deleteuser(id){
           
        }
    },
}
</script>
<style scoped>
.userlist{
    box-sizing: border-box;
    border: 1px solid #ddd;
    position: relative;
    left: 11%;
    width: 89%;
    background: #fff;
    padding: 10px 0;
}
.userlist table{
    display: block;
    margin-left: 50px;
}

/* .userlist th:nth-child(1){
    width: 20px;
} */
.userlist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.userlist th{
    height: 29px;
    line-height: 29px;
    padding: 5px 10px;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #666;
    text-align: center;
}
.userlist td{
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
