module.exports = {
    //添加商品分类
    addcategory(client, data, callback) {
        var sql = `insert into goods_type
        (goods_type_name,created_time)
        values(?,?);`
        var params = [
            data.goods_type_name,
            data.created_time
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取商品分类
    getcategorylist(client, callback) {
        var sql = `select * from goods_type`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除商品分类
    deletecategory(client, data, callback) {
        var sql = `delete from goods_type
        where goods_type_id=?`
        var params = [
            data.goods_type_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加商品分类
    addgoods(client, data, callback) {
        var sql = `insert into goods
        (goods_name,goods_picture,goods_price,goods_type_id,goods_description,created_time,stock)
        values(?,?,?,?,?,?,?);`
        var params = [
            data.goods_name,
            data.goods_picture,
            data.goods_price,
            data.goods_type_id,
            data.goods_description,
            data.created_time,
            data.stock
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取商品列表
    getgoodslist(client, callback) {
        var sql = `select * from goods as s
        inner join goods_type as t on t.goods_type_id=s.goods_type_id`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除商品
    deletegoods(client, data, callback) {
        var sql = `delete from goods
        where goods_id=?`
        var params = [
            data.goods_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },
}