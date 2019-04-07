module.exports = {

    //添加文章
    addarticle(client, data, callback) {
        var sql = `insert into article 
        (title,content,release_time,author,user_id,status)
        values(?,?,?,?,?,?);`;
        var params = [
            data.title,
            data.content,
            data.release_time,
            data.author,
            parseInt(data.user_id),
            data.status,
        ]
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取文章列表
    getarticlelist(client, callback) {
        var sql = `select * from article 
        left join user on article.user_id=user.user_id;`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //按id获取文章
    getarticlebyid(client, data, callback) {
        var sql = `select * from article 
        where article_id=?;`;
        var params = [
            data.article_id,
        ]
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },
}