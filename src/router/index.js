import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/global/home'
import Login from '@/views/global/login'
import Regist from '@/views/global/regist'

import AdminHome from '@/views/admin/adminhome'
import UserList from '@/components/admin/adminuserlist'
import AdminList from '@/components/admin/adminadminlist'
import UserInfo from '@/components/admin/adminuserinfo'
import EditAdmin from '@/components/admin/admineditadmin'
import AddCategory from '@/components/admin/addgoodscategory'

Vue.use(Router)

export default new Router({
    routes: [{
        path: '/',
        name: 'Home',
        component: Home
    }, {
        path: '/login',
        name: 'Login',
        component: Login
    }, {
        path: '/regist',
        name: 'Regist',
        component: Regist
    }, {
        path: '/admin',
        name: 'AdminHome',
        component: AdminHome,
        children: [{
            path: '/admin/userlist',
            name: 'UserList',
            component: UserList,
        }, {
            path: '/admin/adminlist',
            name: 'AdminList',
            component: AdminList,
        }, {
            path: '/admin/userinfo',
            name: 'UserInfo',
            component: UserInfo,
        }, {
            path: '/admin/editadmin',
            name: 'EditAdmin',
            component: EditAdmin,
        }, {
            path: '/admin/addcategory',
            name: 'AddCategory',
            component: AddCategory,
        }]
    }]
})