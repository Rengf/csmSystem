var express = require('express');
var router = express.Router();
var svgCaptcha = require('svg-captcha');
var fs = require('fs');
var path = require('path');
var mysql_connect = require('../db/mysql_connect')
var User = require('../db/user');
var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();

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


//修改个人信息
router.post('/updateuserinfo', multipartMiddleware, (req, res, next) => {
    var userdata = req.body;
    var data = {
        user_name: userdata.newuser_name,
        user_email: userdata.newuser_email,
        user_tel: userdata.newuser_tel,
        real_name: userdata.newreal_name,
        user_avatar: '',
        user_id: userdata.user_id
    }
    var myfile = req.files.files; //文件数据
    var client = mysql_connect.connectServer();
    if (myfile == undefined) {
        data.user_avatar = userdata.files;
        User.updateuserinfo(client, data, function(result) {
            res.json({
                code: 0,
                message: "上传成功",
                result: result
            });
        })
    } else {
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
            data.user_avatar = newimgpath;
            imgpath = newimgpath;
            fs.writeFile(newPath, fs.readFileSync(filePath), function(err, result) {
                if (err) {
                    return res.json({
                        code: 1,
                        message: "上传失败",
                    });
                } else {
                    User.updateuserinfo(client, data, function(result) {
                        res.json({
                            code: 0,
                            message: "修改成功",
                            result: result
                        });
                    })
                }
            })
        }
    }
})
module.exports = router;