import ajax from './ajax'
const BASE_URL = 'http://localhost:3333'
const USER_API = '/api';
const MAIN_API = '/main';
const ADMIN_API = '/admin';

//获取验证码
export const reqCaptcha = () => ajax(BASE_URL + MAIN_API + '/getcaptcha', {}, 'GET')

// 登录
export const userLogin = (data) => ajax(BASE_URL + USER_API + '/user/login', {
  data
}, 'POST')

// 注册
export const userRegist = (data) => ajax(BASE_URL + USER_API + '/user/regist', {
  data
}, 'POST')

// 获取登录的用户信息
export const reqUserInfo = () => ajax(BASE_URL + USER_API, {}, 'GET')

// 退出登录
export const userLogout = () => ajax(BASE_URL + USER_API + '/user/logout', {}, 'GET')

//获取用户列表
export const reqUserList = (condition) => ajax(BASE_URL + ADMIN_API + '/getuserlist', {
  condition
}, 'POST')

//获取管理员列表
export const reqAdminList = (condition) => ajax(BASE_URL + ADMIN_API + '/getadminlist', {
  condition
}, 'POST')

//按id获取个人全部列表
export const reqAdminInfo = (id) => ajax(BASE_URL + ADMIN_API + '/getadmininfo', {
  id
}, 'POST')

//获取分类列表
export const reqCategoryList = () => ajax(BASE_URL + ADMIN_API + '/getcategorylist', {}, 'GET')

//获取商品列表
export const reqGoodsList = (condition) => ajax(BASE_URL + ADMIN_API + '/getgoodslist', {
  condition
}, 'POST')

//获取供应商列表
export const reqSupplierList = () => ajax(BASE_URL + ADMIN_API + '/getsupplierlist', {}, 'GET')

//获取进货单列表
export const reqWarehousingList = () => ajax(BASE_URL + ADMIN_API + '/getwarehousinglist', {}, 'GET')

//获取订单列表
export const reqOrderList = (condition) => ajax(BASE_URL + ADMIN_API + '/getorderlist', {
  condition
}, 'POST')

//获取订单
export const reqOrder = (data) => ajax(BASE_URL + ADMIN_API + '/getorder', {
  data
}, 'POST')

//获取文章列表
export const reqArticleList = (condition) => ajax(BASE_URL + ADMIN_API + '/getarticlelist', {
  condition
}, 'POST')

//获取购物车列表
export const reqCartList = (data) => ajax(BASE_URL + MAIN_API + '/getcartlist', {
  data
}, 'POST')
