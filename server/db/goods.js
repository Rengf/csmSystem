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

    //添加供应商
    addsupplier(client, data, callback) {
        var sql = `insert into supplier
        (supplier_name,supplier_contact,supplier_address,supplier_postcode,supplier_tel,supplier_email,supplier_bank,supplier_account)
        values(?,?,?,?,?,?,?,?);`
        var params = [
            data.supplier_name,
            data.supplier_contact,
            data.supplier_address,
            data.supplier_postcode,
            data.supplier_tel,
            data.supplier_email,
            data.supplier_bank,
            data.supplier_account
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取供应商列表
    getsupplierlist(client, callback) {
        var sql = `select * from supplier`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除供应商
    deletesupplier(client, data, callback) {
        var sql = `delete from supplier
        where supplier_id=?`
        var params = [
            data.supplier_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加进货单
    addwarehousing(client, data, callback) {
        var sql = `insert into warehousing
        ( warehousing_order_id,warehousing_time, goods_id,warehousing_count,total_price,warehousing_staff,supplier)
        values(?,?,?,?,?,?,?);`
        var params = [
            data.warehousing_order_id,
            data.warehousing_time,
            data.goods_id,
            data.warehousing_count,
            data.total_price,
            data.warehousing_staff,
            data.supplier,
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取进货单
    getwarehousinglist(client, callback) {
        var sql = `select * from warehousing 
        inner join goods on warehousing.goods_id=goods.goods_id
        inner join supplier on warehousing.supplier=supplier.supplier_id`
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除进货单
    deletewarehousing(client, data, callback) {
        var sql = `delete from warehousing
        where warehousing_id=?`
        var params = [
            data.warehousing_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

}