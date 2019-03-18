var express = require('express');
var router = express.Router();
var mysql_connect = require('../db/mysql_connect')
var User = require('../db/user');

Date.prototype.Format = function(fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份         
        "d+": this.getDate(), //日         
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时         
        "H+": this.getHours(), //小时         
        "m+": this.getMinutes(), //分         
        "s+": this.getSeconds(), //秒         
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度         
        "S": this.getMilliseconds() //毫秒         
    };
    var week = {
        "0": "/u65e5",
        "1": "/u4e00",
        "2": "/u4e8c",
        "3": "/u4e09",
        "4": "/u56db",
        "5": "/u4e94",
        "6": "/u516d"
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f" : "/u5468") : "") + week[this.getDay() + ""]);
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}

/*  判断是否登录  */
router.get('/', function(req, res, next) {
    if (req.session.user) {
        res.status(200).json({
            code: 0,
            message: '已登录',
            user: req.session.user
        })
    } else {
        res.status(200).json({
            code: 1,
            message: '未登录',
        })
    }
})


//登陆
router.post('/user/login', function(req, res, next) {
    var userdata = req.body.data;
    var username = userdata.username;
    var user_password = userdata.password;
    var captcha = userdata.captcha;
    if (username && user_password && captcha) {
        if (captcha === req.session.captcha) {
            var client = mysql_connect.connectServer();
            var data = {
                user_name: username,
            }
            User.login(client, data, function(result) {
                if (result[0]) {
                    if (result[0].user_password === user_password) {
                        req.session.user = {
                            user_avatar: result[0].user_avatar,
                            user_id: result[0].user_id,
                            user_tel: result[0].user_tel,
                            user_name: result[0].user_name,
                            real_name: result[0].real_name,
                            isadmin: result[0].isadmin,
                        }
                        res.json({
                            code: 0,
                            message: '登录成功',
                            user: req.session.user
                        })
                    } else {
                        return res.json({
                            code: 1,
                            message: '密码错误',
                        })
                    }
                } else {
                    return res.json({
                        code: 1,
                        message: '账号或密码错误',
                    })
                }
            })
        } else {
            res.json({
                code: 1,
                message: '验证码错误',
            })
        }
    }
})

//注册
router.post('/user/regist', function(req, res, next) {
    var userdata = req.body.data;
    var date = new Date();
    var avatar = "../../static/image/avatar.png";
    var user_tel = userdata.username;
    var user_email = userdata.useremail;
    var user_pwd = userdata.password;
    var created_time = date.Format("yyyy-MM-dd hh:mm:ss")
    if (user_pwd && user_tel && user_email) {
        var client = mysql_connect.connectServer();
        data = {
            user_name: 'csm' + user_tel,
            user_pwd: user_pwd,
            user_tel: user_tel,
            user_email: user_email,
            isadmin: 0,
            created_time: created_time,
            user_avatar: avatar,
        }
        User.regist(client, data, function(result) {
            res.json({
                code: 0,
                message: '注册成功',
            })
        })
    } else {
        return res.json({
            code: 1,
            message: '信息不完整',
        })
    }

})



//修改密码
router.post('/updatepassword', function(req, res, next) {
    var oldpassword = req.body.oldpassword;
    var user_password = req.body.user_password;
    var user_id = req.body.user_id
    if (user_id && user_password && oldpassword) {
        var client = mysql_connect.connectServer();
        var data = {
            user_id: user_id,
            user_password: user_password
        }
        User.searchbyid(client, data, function(result) {
            console.log(result)
            if (result[0]) {
                if (result[0].user_password === oldpassword) {
                    User.updatepassword(client, data, function(result) {
                        res.json({
                            code: 0,
                            message: '修改成功',
                        })
                    })
                } else {
                    return res.json({
                        code: 1,
                        message: '原密码错误',
                    })
                }
            } else {
                return res.json({
                    code: 1,
                    message: '该用户不存在',
                })
            }
        })
    } else {
        res.json({
            code: 1,
            message: '输入不能为空',
        })
    }
})

//退出登录
router.get("/user/logout", function(req, res) {
    if (req.session.user) {
        req.session.user = null;
        res.json({
            code: 0,
            message: "退出成功"
        })
    } else {
        res.json({
            code: 1,
            message: "退出失败"
        })
    }
})
module.exports = router