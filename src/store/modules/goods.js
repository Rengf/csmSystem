import {
    RECEIVE_CATEGORY_LIST,
} from './../mutations-types'

import {
    reqCategoryList,
} from './../../api/index'

const state = {
    categorylist: {}
}

const getters = {
    categorylist(state) {
        return state.categorylist
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
}
const mutations = {
    [RECEIVE_CATEGORY_LIST](state, categorylist) {
        state.categorylist = categorylist;
    },
}
export default {
    state,
    actions,
    mutations,
    getters,
}