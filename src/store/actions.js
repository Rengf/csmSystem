import {
    RECEIVE_CAPTCHA,
    RECEIVE_COUNTER,
} from './mutations-types'

import {
    reqCaptcha,
    reqImage
} from './../api/index'
export default {
    async getCaptcha({ commit }) {
        const result = await reqCaptcha()
        if (result.code == 0) {
            const captcha = result.result.img;
            commit(RECEIVE_CAPTCHA, captcha)
        }
    },
    commitorder({ commit }, data) {
        commit(RECEIVE_COUNTER, data)
    },
}