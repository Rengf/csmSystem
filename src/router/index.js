import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/global/home'
import GoodsDetail from '@/views/global/goodsdetail'
import SureOrder from '@/views/global/sureorder'
import PayFor from '@/views/global/payfor'
import Login from '@/views/global/login'
import Regist from '@/views/global/regist'

import AdminHome from '@/views/admin/adminhome'
import AdminIndex from '@/components/admin/adminhome'
import UserList from '@/components/admin/adminuserlist'
import AdminList from '@/components/admin/adminadminlist'
import UserInfo from '@/components/admin/adminuserinfo'
import EditAdmin from '@/components/admin/admineditadmin'
import CategoryList from '@/components/admin/goodscategorylist'
import AddGoods from '@/components/admin/addgoods'
import GoodsList from '@/components/admin/goodslist'
import AddWareHousing from '@/components/admin/addwarehousing'
import WareHousingList from '@/components/admin/warehousinglist'
import AddSupplier from '@/components/admin/addsupplier'
import SupplierList from '@/components/admin/supplierlist'
import OrderList from '@/components/admin/orderlist'
import OrderDetail from '@/components/admin/orderdetail'

Vue.use(Router)

export default new Router({
    routes: [{
        path: '/',
        name: 'Home',
        component: Home
    }, {
        path: '/goodsdetail',
        name: 'GoodsDetail',
        component: GoodsDetail
    }, {
        path: '/payfor',
        name: 'PayFor',
        component: PayFor
    }, {
        path: '/sureorder',
        name: 'SureOrder',
        component: SureOrder
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
            path: '/admin',
            name: 'AdminIndex',
            component: AdminIndex,
        }, {
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
            path: '/admin/categorylist',
            name: 'CategoryList',
            component: CategoryList,
        }, {
            path: '/admin/addgoods',
            name: 'AddGoods',
            component: AddGoods,
        }, {
            path: '/admin/goodslist',
            name: 'GoodsList',
            component: GoodsList,
        }, {
            path: '/admin/addwarehousing',
            name: 'AddWareHousing',
            component: AddWareHousing,
        }, {
            path: '/admin/warehousinglist',
            name: 'WareHousingList',
            component: WareHousingList,
        }, {
            path: '/admin/addsupplier',
            name: 'AddSupplier',
            component: AddSupplier,
        }, {
            path: '/admin/supplierlist',
            name: 'SupplierList',
            component: SupplierList,
        }, {
            path: '/admin/orderlist',
            name: 'OrderList',
            component: OrderList,
        }, {
            path: '/admin/orderdetail',
            name: 'OrderDetail',
            component: OrderDetail,
        }]
    }]
})