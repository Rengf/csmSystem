var express = require('express');
var router = express.Router();
var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();
var fs = require('fs');
var path = require('path');

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

//添加商品
router.post('/addgoods', multipartMiddleware, function(req, res, next) {
    var myfile = req.files.files;
    var goodsdata = req.body;
    var client = mysql_connect.connectServer();
    var date = new Date();
    var created_time = date.Format("yyyy-MM-dd HH:mm:ss")
    var data = {
        goods_name: goodsdata.goods_name,
        goods_price: goodsdata.goods_price,
        goods_type_id: parseInt(goodsdata.goods_type_id),
        goods_description: goodsdata.goods_description,
        created_time: created_time,
        stock: goodsdata.stock
    }
    var filePath = '';
    var originalFilename = '';
    var imgpath = '';
    if (myfile) {
        filePath = myfile.path || '';
        originalFilename = myfile.originalFilename;
    }
    if (originalFilename) {
        var newfilename = originalFilename;
        var newPath = path.join(__dirname, '../../', 'static/image/' + newfilename);
        var newimgpath = '../../static/image/' + originalFilename;
        data.goods_picture = newimgpath;
        imgpath = newimgpath;
        fs.writeFile(newPath, fs.readFileSync(filePath), function(err, result) {
            if (err) {
                return res.json({
                    code: 1,
                    message: "上传失败",
                });
            } else {
                Goods.addgoods(client, data, function(result) {
                    res.json({
                        code: 0,
                        message: "添加成功",
                        result: result
                    });
                })
            }
        })
    }
})


//获取商品列表
router.get('/getgoodslist', function(req, res, next) {
    var client = mysql_connect.connectServer();
    Goods.getgoodslist(client, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            goodslist: result
        })
    })
})

//删除商品
router.post('/deletegoods', function(req, res, next) {
    var goods_id = req.body.goods_id;
    var data = {
        goods_id: goods_id
    }
    var client = mysql_connect.connectServer();
    Goods.deletegoods(client, data, function(result) {
        res.json({
            code: 0,
            message: '删除成功',
        })
    })
})

//添加供货商
router.post('/addsupplier', function(req, res, next) {
    var supplierdata = req.body;
    var client = mysql_connect.connectServer();
    var data = supplierdata;
    Goods.addsupplier(client, data, function(result) {
        res.json({
            code: 0,
            message: '添加成功',
        })
    })
})

//获取供应商列表
router.get('/getsupplierlist', function(req, res, next) {
    var client = mysql_connect.connectServer();
    Goods.getsupplierlist(client, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            supplierlist: result
        })
    })
})

//删除供应商
router.post('/deletesupplier', function(req, res, next) {
    var supplier_id = req.body.supplier_id;
    var data = {
        supplier_id: supplier_id
    }
    var client = mysql_connect.connectServer();
    Goods.deletesupplier(client, data, function(result) {
        res.json({
            code: 0,
            message: '删除成功',
        })
    })
})

//添加进货
router.post('/addwarehousing', function(req, res, next) {
    var warehousingdata = req.body;
    var client = mysql_connect.connectServer();
    var data = warehousingdata;
    Goods.addwarehousing(client, data, function(result) {
        res.json({
            code: 0,
            message: '添加成功',
        })
    })
})

//获取供应商列表
router.get('/getwarehousinglist', function(req, res, next) {
    var client = mysql_connect.connectServer();
    Goods.getwarehousinglist(client, function(result) {
        res.json({
            code: 0,
            message: '查询成功',
            warehousinglist: result
        })
    })
})

//删除进货单
router.post('/deletewarehousing', function(req, res, next) {
    var warehousing_id = req.body.warehousing_id;
    var data = {
        warehousing_id: warehousing_id
    }
    var client = mysql_connect.connectServer();
    Goods.deletewarehousing(client, data, function(result) {
        res.json({
            code: 0,
            message: '删除成功',
        })
    })
})
module.exports = router