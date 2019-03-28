import {
    RECEIVE_CAPTCHA,
    RECEIVE_COUNTER,
} from './mutations-types'

export default {
    [RECEIVE_CAPTCHA](state, captcha) {
        state.captcha = captcha
    },
    [RECEIVE_COUNTER](state, data) {
        state.counter = data
    },
}