import {
    RECEIVE_CATEGORY_LIST,
    RECEIVE_GOODS_LIST,
    RECEIVE_SUPPLIER_LIST,
    RECEIVE_WAREHOUSING_LIST,
} from './../mutations-types'

import {
    reqCategoryList,
    reqGoodsList,
    reqSupplierList,
    reqWarehousingList
} from './../../api/index'

const state = {
    categorylist: {},
    goodslist: {},
    supplierlist: {},
    warehousinglist: {}
}

const getters = {
    categorylist(state) {
        return state.categorylist
    },
    goodslist(state) {
        return state.goodslist
    },
    supplierlist(state) {
        return state.supplierlist
    },
    warehousinglist(state) {
        return state.warehousinglist
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
    async getSupplierList({ commit }) {
        const result = await reqSupplierList()
        if (result.code == 0) {
            const supplierlist = result.supplierlist;
            commit(RECEIVE_SUPPLIER_LIST, supplierlist)
        }
    },
    async getWarehousingList({ commit }) {
        const result = await reqWarehousingList()
        if (result.code == 0) {
            const warehousinglist = result.warehousinglist;
            commit(RECEIVE_WAREHOUSING_LIST, warehousinglist)
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
    [RECEIVE_SUPPLIER_LIST](state, supplierlist) {
        state.supplierlist = supplierlist;
    },
    [RECEIVE_WAREHOUSING_LIST](state, warehousinglist) {
        state.warehousinglist = warehousinglist;
    },
}
export default {
    state,
    actions,
    mutations,
    getters,
}