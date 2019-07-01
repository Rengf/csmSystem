import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/global/home'
import Global from '@/views/global/global'
import GoodsDetail from '@/views/global/goodsdetail'
import Goods from '@/views/global/goodslist'
import ShopCar from '@/views/global/shopcar'
import OffLineSales from '@/views/global/Offlinesales'
import SureOrder from '@/views/global/sureorder'
import UserOrderDetail from '@/views/global/orderdetail'
import UserOrderList from '@/views/global/orderlist'
import PayFor from '@/views/global/payfor'
import Login from '@/views/global/login'
import Regist from '@/views/global/regist'

import AdminHome from '@/views/admin/adminhome'
import AddArticle from '@/components/admin/addarticle'
import ArticleDetail from '@/components/admin/articledetail'
import ArticleList from '@/components/admin/articlelist'
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
import ReturnOrderList from '@/components/admin/returnorderlist'
import OrderDetail from '@/components/admin/orderdetail'
import CommentList from '@/components/admin/commentlist'
import Report from '@/components/admin/report'

Vue.use(Router)

const router = new Router({
    routes: [{
        path: '/',
        name: 'Home',
        component: Home,
    }, {
        path: '/index',
        name: 'Global',
        component: Global,
        children: [{
                path: '/index/goodsdetail',
                name: 'GoodsDetail',
                component: GoodsDetail
            }, {
                path: '/index/goodslist',
                name: 'Goods',
                component: Goods
            }, {
                path: '/index/shopcar',
                name: 'ShopCar',
                component: ShopCar,
                meta: {
                    requireAuth: true,
                },
            }, {
                path: '/index/sureorder',
                name: 'SureOrder',
                component: SureOrder,
                meta: {
                    requireAuth: true,
                }
            }, {
                path: '/index/orderdetail',
                name: 'UserOrderDetail',
                component: UserOrderDetail,
                meta: {
                    requireAuth: true,
                }
            },
            {
                path: '/index/orderlist',
                name: 'UserOrderList',
                component: UserOrderList,
                meta: {
                    requireAuth: true,
                }
            },
        ]

    }, {
        path: '/offlinesales',
        name: 'OffLineSales',
        component: OffLineSales
    }, {
        path: '/payfor',
        name: 'PayFor',
        component: PayFor,
        meta: {
            requireAuth: true,
        },
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
        meta: {
            requireAuth: true,
        },
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
            },
            {
                path: '/admin/addarticle',
                name: 'AddArticle',
                component: AddArticle,
            },
            {
                path: '/admin/articledetail',
                name: 'ArticleDetail',
                component: ArticleDetail,
            }, {
                path: '/admin/articlelist',
                name: 'ArticleList',
                component: ArticleList,
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
            },
            {
                path: '/admin/commentlist',
                name: 'CommentList',
                component: CommentList,
            }, {
                path: '/admin/returnorderlist',
                name: 'ReturnOrderList',
                component: ReturnOrderList,
            }, {
                path: '/admin/orderdetail',
                name: 'OrderDetail',
                component: OrderDetail,
            },
            {
                path: '/admin/report',
                name: 'Report',
                component: Report,
            }
        ]
    }]
})

router.beforeEach((to, from, next) => {
    if (to.matched.some(r => r.meta.requireAuth)) {
        if (localStorage.token) {
            next();
        } else {
            next({
                path: '/login',
                query: { redirect: to.fullPath }
            })
        }
    } else {
        next();
    }
})

export default router