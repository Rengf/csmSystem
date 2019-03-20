import {
    RECEIVE_CATEGORY_LIST,
    RECEIVE_GOODS_LIST,
} from './../mutations-types'

import {
    reqCategoryList,
    reqGoodsList,
} from './../../api/index'

const state = {
    categorylist: {},
    goodslist: {}
}

const getters = {
    categorylist(state) {
        return state.categorylist
    },
    goodslist(state) {
        return state.goodslist
    },
}
const actions = {
    async getCategoryList({ commit }) {
        const result = await reqCategoryList()
        if (result.code == 0) {
            const categorylist = result.categorylist;
            commit(RECEIVE_CATEGORY_LIST, categorylist)
        }
    },
    async getGoodsList({ commit }) {
        const result = await reqGoodsList()
        if (result.code == 0) {
            const goodslist = result.goodslist;
            commit(RECEIVE_GOODS_LIST, goodslist)
        }
    },
}
const mutations = {
    [RECEIVE_CATEGORY_LIST](state, categorylist) {
        state.categorylist = categorylist;
    },
    [RECEIVE_GOODS_LIST](state, goodslist) {
        state.goodslist = goodslist;
    },
}
export default {
    state,
    actions,
    mutations,
    getters,
}