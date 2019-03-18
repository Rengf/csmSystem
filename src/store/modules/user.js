import {
    RECEIVE_USER_INFO,
    USER_LOGIN,
    USER_REGIST,
    USER_LOGOUT,
} from './../mutations-types'

import {
    reqUserInfo,
    userLogout,
    userLogin,
    userRegist
} from './../../api/index'

const state = {
    userinfo: {},
    result: {}
}

const getters = {
    userinfo(state) {
        return state.userinfo
    },
    result(state) {
        return state.result
    }
}
const actions = {
    async getUserInfo({ commit }) {
        const result = await reqUserInfo()
        if (result.code == 0) {
            const user = result.user;
            commit(RECEIVE_USER_INFO, user)
        }
    },
    async login({ commit }, data) {
        const result = await userLogin(data)
        commit(USER_LOGIN, result)

    },
    async regist({ commit }, data) {
        const result = await userRegist(data)
        commit(USER_REGIST, result)

    },
    async logout({ commit }) {
        const result = await userLogout()
        if (result.code == 0) {
            commit(USER_LOGOUT, null)
        }
    },
}
const mutations = {
    [RECEIVE_USER_INFO](state, user) {
        state.userinfo = user;
    },
    [USER_LOGIN](state, result) {
        state.result = result;
    },
    [USER_REGIST](state, result) {
        state.result = result;
    },
    [USER_LOGOUT](state) {
        state.userinfo = {}
    },
}
export default {
    state,
    actions,
    mutations,
    getters,
}