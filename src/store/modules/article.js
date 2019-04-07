import {
    RECEIVE_ARTICLE_LIST,
} from './../mutations-types'

import {
    reqArticleList,
} from './../../api/index'

const state = {
    articlelist: {},
}

const getters = {
    articlelist(state) {
        return state.articlelist
    },
}
const actions = {
    async getArticleList({ commit }, condition) {
        const result = await reqArticleList(condition)
        console.log(result)
        if (result.code == 0) {
            const articlelist = result.articlelist;
            commit(RECEIVE_ARTICLE_LIST, articlelist)
        }
    },
}
const mutations = {
    [RECEIVE_ARTICLE_LIST](state, articlelist) {
        state.articlelist = articlelist;
    }
}
export default {
    state,
    actions,
    mutations,
    getters,
}