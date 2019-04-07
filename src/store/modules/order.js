import {
    RECEIVE_ORDER_LIST,
    RECEIVE_ORDER,
} from './../mutations-types'

import {
    reqOrderList,
    reqOrder,
} from './../../api/index'

const state = {
    orderlist: {},
    order: {}
}

const getters = {
    orderlist(state) {
        return state.orderlist
    },
    order(state) {
        return state.order
    },
}
const actions = {
    async getOrderList({ commit }, condition) {
        const result = await reqOrderList(condition)
        if (result.code == 0) {
            const orderlist = result.orderlist;
            commit(RECEIVE_ORDER_LIST, orderlist)
        }
    },
    async getOrder({ commit }, data) {
        const result = await reqOrder(data)
        if (result.code == 0) {
            const order = result.order;
            commit(RECEIVE_ORDER, order)
        }
    },
}
const mutations = {
    [RECEIVE_ORDER_LIST](state, orderlist) {
        state.orderlist = orderlist;
    },
    [RECEIVE_ORDER](state, order) {
        state.order = order;
    }
}
export default {
    state,
    actions,
    mutations,
    getters,
}