var express = require('express');
var router = express.Router();
var svgCaptcha = require('svg-captcha');
var mysql_connect = require('../db/mysql_connect')
var User = require('../db/user');
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

//验证码生成
router.get('/getcaptcha', (req, res, next) => {
    var codeConfig = {
        size: 5, // 验证码长度
        ignoreChars: '0o1i', // 验证码字符中排除 0o1i
        noise: 2, // 干扰线条的数量
        height: 44
    }
    var captcha = svgCaptcha.create(codeConfig);
    req.session.captcha = captcha.text.toLowerCase(); //存session用于验证接口获取文字码
    var codeData = {
        img: captcha.data
    }
    return res.json({
        code: 0,
        result: codeData,
        message: '验证码'
    });
})


//按id获取商品列表
router.post('/getgoodsdetail', function(req, res, next) {
    var goods_id = req.body.goods_id;
    var client = mysql_connect.connectServer();
    var data = {
        goods_id: goods_id
    }
    Goods.getgoodsdetail(client, data, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            goods: result
        })
    })
})

//按用户id获取商品列表
router.post('/getaddress', function(req, res, next) {
    var user_id = req.body.user_id;
    var client = mysql_connect.connectServer();
    var data = {
        user_id: user_id
    }
    User.getaddress(client, data, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            address: result
        })
    })
})

//添加购物车
router.post('/addcart', function(req, res, next) {
    var data = req.body;
    var client = mysql_connect.connectServer();
    var date = new Date();
    var addcart_time = date.Format("yyyy-MM-dd HH:mm:ss")
    data.addcart_time = addcart_time;
    Goods.addcart(client, data, function(result) {
        res.json({
            code: 0,
            message: '添加成功',
            goods: result
        })
    })
})

//按id获取购物车列表
router.post('/getcart', function(req, res, next) {
    var user_id = req.body.user_id;
    var client = mysql_connect.connectServer();
    var data = {
        user_id: user_id
    }
    Goods.getcart(client, data, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            cart: result
        })
    })
})

//删除购物车
router.post('/deletecart', function(req, res, next) {
    var cart_id = req.body.cart_id;
    var data = {
        cart_id: cart_id
    }
    var client = mysql_connect.connectServer();
    Goods.deletecart(client, data, function(result) {
        res.json({
            code: 0,
            message: '删除成功',
        })
    })
})

//添加订单
router.post('/addorder', function(req, res, next) {
    var data = req.body;
    var client = mysql_connect.connectServer();
    var date = new Date();
    var addorder_time = date.Format("yyyy-MM-dd HH:mm:ss");
    var order_no = parseInt(Math.random() * 100000000000000);
    data.addorder_time = addorder_time;
    data.order_no = order_no;
    Goods.addorder(client, data, function(result) {
        res.json({
            code: 0,
            message: '添加成功',
            order_id: result.insertId
        })
    })
})

//添加发票
router.post('/addinvoice', function(req, res, next) {
    var data = req.body
    console.log(data)
    var client = mysql_connect.connectServer();
    var date = new Date();
    var addinvoice_time = date.Format("yyyy-MM-dd HH:mm:ss");
    var invoice_no = parseInt(Math.random() * 100000000000000);
    data.addinvoice_time = addinvoice_time;
    data.invoice_no = invoice_no;
    Goods.addinvoice(client, data, function(result) {
        res.json({
            code: 0,
            message: '添加成功',
            invoice_id: result.insertId
        })
    })
})

//付款更新订单
router.post('/updateorder', function(req, res, next) {
    var data = req.body;
    var client = mysql_connect.connectServer();
    var out_trade_no = parseInt(Math.random() * 100000000000000);
    var date = new Date();
    var payed_time = date.Format("yyyy-MM-dd HH:mm:ss");
    if (data.pay_channel == '货到付款') {
        data.out_trade_no = null;
        data.payed_time = null;
        data.order_status = 0;
    } else {
        data.out_trade_no = out_trade_no;
        data.payed_time = payed_time;
        data.order_status = 1;
    }
    Goods.getgoodsbyid(client, data, function(result) {
        if (result) {
            data.stock = parseInt(result[0].stock) - parseInt(data.goods_count);
            data.sales = parseInt(result[0].sales) + parseInt(data.goods_count);
            Goods.updateorder(client, data, function(result) {
                if (result) {
                    Goods.updategoods(client, data, function(result) {
                        Goods.deletecart(client, data, function(result) {
                            res.json({
                                code: 0,
                                message: '修改成功',
                            })
                        })
                    })
                } else {
                    return res.json({
                        code: 1,
                        message: '修改失败',
                    })
                }
            })
        }
    })
})
module.exports = router;