import Vue from 'vue'
import Vuex from 'vuex'
import state from './state'
import mutations from './mutations'
import actions from './actions'
import getters from './getters'
import users from './modules/user'
import admin from './modules/admin'
import goods from './modules/goods'
import order from './modules/order'
import article from './modules/article'
import cart from './modules/cart'

Vue.use(Vuex)

export default new Vuex.Store({
    state,
    mutations,
    actions,
    getters,
    modules: {
        users,
        admin,
        goods,
        order,
        article,
        cart
    }
})