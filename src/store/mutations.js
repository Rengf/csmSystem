import {
    RECEIVE_CAPTCHA,
    RECEIVE_IMAGE,
} from './mutations-types'

export default {
    [RECEIVE_CAPTCHA](state, captcha) {
        state.captcha = captcha
    },
}