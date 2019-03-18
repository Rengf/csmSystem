module.exports = {

    //获取用户列表
    getuserlist(client, callback) {
        var sql = `select * from user`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })

    },
    //获取管理员列表
    getadminlist(client, callback) {
        var sql = `select * from user where isadmin>0`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })

    },
    getadmininfo(client, data, callback) {
        var sql = `select user_name,user_id,user_avatar,user_tel,user_email,real_name,isadmin,created_time,last_login_time
                   from user where user_id=?`;
        var params = [
            data.user_id,
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    }
}