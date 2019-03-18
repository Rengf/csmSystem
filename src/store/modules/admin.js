import {
    RECEIVE_USER_LIST,
    RECEIVE_ADMIN_LIST,
    RECEIVE_ADMININFO
} from './../mutations-types'

import {
    reqUserList,
    reqAdminList,
    reqAdminInfo
} from './../../api/index'

const state = {
    userlist: {},
    adminlist: {},
    admininfo: {}
}

const getters = {
    userlist(state) {
        return state.userlist
    },
    adminlist(state) {
        return state.adminlist
    },
    admininfo(state) {
        return state.admininfo
    }
}
const actions = {
    async getAdminInfo({ commit }, id) {
        const result = await reqAdminInfo(id)
        console.log(result)
        if (result.code == 0) {
            const admininfo = result.admininfo;
            commit(RECEIVE_ADMININFO, admininfo)
        }
    },
    async getUserlist({ commit }) {
        const result = await reqUserList()
        if (result.code == 0) {
            const userlist = result.userlist;
            commit(RECEIVE_USER_LIST, userlist)
        }
    },
    async getAdminlist({ commit }) {
        const result = await reqAdminList()
        if (result.code == 0) {
            const adminlist = result.adminlist;
            commit(RECEIVE_ADMIN_LIST, adminlist)
        }
    },
}
const mutations = {
    [RECEIVE_USER_LIST](state, userlist) {
        state.userlist = userlist;
    },
    [RECEIVE_ADMIN_LIST](state, adminlist) {
        state.adminlist = adminlist;
    },
    [RECEIVE_ADMININFO](state, admininfo) {
        state.admininfo = admininfo;
    }
}
export default {
    state,
    actions,
    mutations,
    getters,
}