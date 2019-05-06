// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import axios from 'axios'
import store from './store'
import moment from 'moment'
import BaiduMap from 'vue-baidu-map'

import '../static/ueditor/ueditor.config.js'
import '../static/ueditor/ueditor.all.min.js'
import '../static/ueditor/lang/zh-cn/zh-cn.js'
import '../static/ueditor/ueditor.parse.min.js'

axios.defaults.withCredentials = true
Vue.prototype.$http = axios

Vue.config.productionTip = false
Vue.prototype.$moment = moment;

Vue.filter('dateformat', function(dataStr, pattern = 'YYYY-MM-DD HH:mm:ss') {  
    return moment(dataStr).format(pattern)

})

Vue.use(BaiduMap, {
        // ak 是在百度地图开发者平台申请的密钥 详见 http://lbsyun.baidu.com/apiconsole/key */
        ak: '2nF9PWizKTHtHVqr2GpLdHlY9y9KN25C'
    })
    /* eslint-disable no-new */
new Vue({
    el: '#app',
    router,
    store,
    components: { App },
    template: '<App/>'
})