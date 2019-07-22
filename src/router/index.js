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
        meta: { title: "首页" }
    }, {
        path: '/index',
        name: 'Global',
        component: Global,
        children: [{
                path: '/index/goodsdetail',
                name: 'GoodsDetail',
                component: GoodsDetail,
                meta: { title: "商品详情" }
            }, {
                path: '/index/goodslist',
                name: 'Goods',
                component: Goods,
                meta: { title: "商品列表" }
            }, {
                path: '/index/shopcar',
                name: 'ShopCar',
                component: ShopCar,
                meta: {
                    requireAuth: true,
                    title: "购物车"
                },
            }, {
                path: '/index/sureorder',
                name: 'SureOrder',
                component: SureOrder,
                meta: {
                    requireAuth: true,
                    title: "确定订单"
                }
            }, {
                path: '/index/orderdetail',
                name: 'UserOrderDetail',
                component: UserOrderDetail,
                meta: {
                    requireAuth: true,
                    title: "订单详情"
                }
            },
            {
                path: '/index/orderlist',
                name: 'UserOrderList',
                component: UserOrderList,
                meta: {
                    requireAuth: true,
                    title: "订单列表"
                }
            },
        ]

    }, {
        path: '/offlinesales',
        name: 'OffLineSales',
        component: OffLineSales,
        meta: { title: "模拟线下购物" }
    }, {
        path: '/payfor',
        name: 'PayFor',
        component: PayFor,
        meta: {
            requireAuth: true,
            title: "支付订单"
        },
    }, {
        path: '/login',
        name: 'Login',
        component: Login,
        meta: { title: "登录" }
    }, {
        path: '/regist',
        name: 'Regist',
        component: Regist,
        meta: { title: "注册" }
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
                meta: { title: "后台首页" }
            }, {
                path: '/admin/userlist',
                name: 'UserList',
                component: UserList,
                meta: { title: "用户列表" }
            }, {
                path: '/admin/adminlist',
                name: 'AdminList',
                component: AdminList,
                meta: { title: "管理员列表" }
            },
            {
                path: '/admin/addarticle',
                name: 'AddArticle',
                component: AddArticle,
                meta: { title: "添加文章" }
            },
            {
                path: '/admin/articledetail',
                name: 'ArticleDetail',
                component: ArticleDetail,
                meta: { title: "文章详情" }
            }, {
                path: '/admin/articlelist',
                name: 'ArticleList',
                component: ArticleList,
                meta: { title: "文章列表" }
            }, {
                path: '/admin/userinfo',
                name: 'UserInfo',
                component: UserInfo,
                meta: { title: "用户信息" }
            }, {
                path: '/admin/editadmin',
                name: 'EditAdmin',
                component: EditAdmin,
                meta: { title: "修改管理员信息" }
            }, {
                path: '/admin/categorylist',
                name: 'CategoryList',
                component: CategoryList,
                meta: { title: "分类列表" }
            }, {
                path: '/admin/addgoods',
                name: 'AddGoods',
                component: AddGoods,
                meta: { title: "添加商品" }
            }, {
                path: '/admin/goodslist',
                name: 'GoodsList',
                component: GoodsList,
                meta: { title: "商品列表" }
            }, {
                path: '/admin/addwarehousing',
                name: 'AddWareHousing',
                component: AddWareHousing,
                meta: { title: "添加进货" }
            }, {
                path: '/admin/warehousinglist',
                name: 'WareHousingList',
                component: WareHousingList,
                meta: { title: "进货列表" }
            }, {
                path: '/admin/addsupplier',
                name: 'AddSupplier',
                component: AddSupplier,
                meta: { title: "添加供货商" }
            }, {
                path: '/admin/supplierlist',
                name: 'SupplierList',
                component: SupplierList,
                meta: { title: "供货商列表" }
            }, {
                path: '/admin/orderlist',
                name: 'OrderList',
                component: OrderList,
                meta: { title: "订单列表" }
            },
            {
                path: '/admin/commentlist',
                name: 'CommentList',
                component: CommentList,
                meta: { title: "评论列表" }
            }, {
                path: '/admin/returnorderlist',
                name: 'ReturnOrderList',
                component: ReturnOrderList,
                meta: { title: "退单列表" }
            }, {
                path: '/admin/orderdetail',
                name: 'OrderDetail',
                component: OrderDetail,
                meta: { title: "订单详情" }
            },
            {
                path: '/admin/report',
                name: 'Report',
                component: Report,
                meta: { title: "数据报表" }
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