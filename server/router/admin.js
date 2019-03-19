var express = require('express');
var router = express.Router();
var mysql_connect = require('../db/mysql_connect')
var Admin = require('../db/admin');
var Goods = require('../db/goods');

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

//获取用户列表
router.get('/getuserlist', function(req, res, next) {
    var client = mysql_connect.connectServer();
    Admin.getuserlist(client, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            userlist: result
        })
    })
})

//获取管理员列表
router.get('/getadminlist', function(req, res, next) {
    var client = mysql_connect.connectServer();
    Admin.getadminlist(client, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            adminlist: result
        })
    })
})


//按编号获取用户个人信息
router.post('/getadmininfo', function(req, res, next) {
    var id = parseInt(req.body.id);
    var client = mysql_connect.connectServer();
    var data = {
        user_id: id
    }
    Admin.getadmininfo(client, data, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            admininfo: result[0]
        })
    })
})

//删除用户
router.post('/deleteuser', function(req, res, next) {
    var user_id = req.body.user_id;
    var client = mysql_connect.connectServer();
    var data = {
        user_id: parseInt(user_id)
    }
    Admin.deleteuser(client, data, function(result) {
        res.json({
            code: 0,
            message: '删除成功',
        })
    })
})

//设置管理员
router.post('/editadmin', function(req, res, next) {
    var user_id = req.body.user_id;
    var isadmin = req.body.isadmin;
    var client = mysql_connect.connectServer();
    var data = {
        user_id: parseInt(user_id),
        isadmin: parseInt(isadmin)
    }
    Admin.editadmin(client, data, function(result) {
        res.json({
            code: 0,
            message: '设置成功',
        })
    })
})


//添加商品分类
router.post('/addcategory', function(req, res, next) {
    var goods_type_name = req.body.goods_type_name;
    var date = new Date();
    var created_time = date.Format("yyyy-MM-dd HH:mm:ss")
    var client = mysql_connect.connectServer();
    var data = {
        goods_type_name: goods_type_name,
        created_time: created_time
    }
    Goods.addcategory(client, data, function(result) {
        res.json({
            code: 0,
            message: '添加成功',
        })
    })
})

//获取分类列表
router.get('/getcategorylist', function(req, res, next) {
    var client = mysql_connect.connectServer();
    Goods.getcategorylist(client, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            categorylist: result
        })
    })
})

//删除分类
router.post('/deletecategory', function(req, res, next) {
    var goods_type_id = req.body.goods_type_id;
    var data = {
        goods_type_id: goods_type_id
    }
    var client = mysql_connect.connectServer();
    Goods.deletecategory(client, data, function(result) {
        res.json({
            code: 0,
            message: '删除成功',
        })
    })
})

module.exports = router