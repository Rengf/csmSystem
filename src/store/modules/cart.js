import {
    RECEIVE_CART_LIST,
} from './../mutations-types'

import {
    reqCartList,
} from './../../api/index'

const state = {
    cartlist: [],
}

const getters = {
    cartlist(state) {
        return state.cartlist
    },
}
const actions = {
    async getCartList({ commit }, data) {
        const result = await reqCartList(data)
        if (result.code == 0) {
            const cartlist = result.cartlist;
            commit(RECEIVE_CART_LIST, cartlist)
        }
    },
}
const mutations = {
    [RECEIVE_CART_LIST](state, cartlist) {
        state.cartlist = cartlist;
    }
}
export default {
    state,
    actions,
    mutations,
    getters,
}